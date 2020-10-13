/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   mtl_shader_language_example.msl                    :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcharla <kcharla@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/09/07 11:06:07 by kcharla           #+#    #+#             */
/*   Updated: 2020/09/07 11:06:07 by kcharla          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <metal_stdlib>
using namespace metal;

constant const float pi = 3.14159265358979323846f;

typedef struct		Ray {
	float3 pos;
	float3 dir;
	float max;
	float min;
	Ray() : pos(0.0f), dir(1.0f), max(INFINITY), min(0) {};
	Ray(	float3 p, float3 d,
			float max = INFINITY, float min = 0.0 )
			: pos(p), dir(normalize(d)), max(max), min(min) {};
} Ray;

enum e_obj_type
{
	OBJ_NONE = 0,
	OBJ_PLANE,
	OBJ_SPHERE,
	OBJ_CYLINDER,
	OBJ_CONE,
	OBJ_GEOMETRY
};

struct				s_sphere
{
	packed_float3	pos;
	float			r;
};

struct				s_plane
{
	packed_float3	n;
	float			d;
};

union				u_obj_content
{
	struct s_sphere		sphere;
	struct s_plane		plane;
};

struct				s_obj
{
	int						id;
	int						material_id;
	enum e_obj_type			type;
	union u_obj_content		content;
};

struct				s_cam
{
	int				id;
	packed_float3	pos;
	packed_float3	forward;
	packed_float3	up;
	packed_float3	right;
	packed_float2	fov;
};

struct				s_mat
{
	int				id;
	float 			metalness;
	float 			roughness;
	float 			ior;
	float 			transparency;
	packed_float3	albedo;
	packed_float3	f0;
};

#define RT_MAX_OBJECTS 128
#define RT_MAX_CAMERAS 16
#define RT_MAX_MATERIALS 32

typedef struct		s_scn
{
	int				id;
	struct s_obj	objects[RT_MAX_OBJECTS];
	int				objects_num;
	struct s_cam	cameras[RT_MAX_CAMERAS];
	int				camera_active;
	int				cameras_num;
	struct s_mat	materials[RT_MAX_MATERIALS];
	int				materials_num;
}					t_scn;

float		map(float x, float2 in, float2 out)
{
	return ((x - in.x) * (out.y - out.x) / (in.y - in.x) + out.x);
}

float2		map2(float2 val, float4 in, float4 out)
{
	return (float2(map(val.x, in.xy, out.xy), map(val.y, in.zw, out.zw)));
}

// val must be in range (0 .. pi/2)
// from and to must be normalized
// from and to must be in 90 degree angle
float3 rt_interpolation_round(float val, float3 from, float3 to)
{
	return (normalize(from * cos(val) + to * sin(val)));
}

//round interpolation
float3 rerp(float val, float3 from, float3 to)
{
	return (normalize(from * cos(val) + to * sin(val)));
}

float3 rerp2(float2 val, float3 fromX, float3 toY, float3 toZ)
{
	return (normalize(rerp(val.x, fromX, toY) + rerp(val.y, fromX, toZ)));
}

float angle_to_radians(float degrees)
{
	return (degrees * pi / 180.0f);
}

float2 angle2_to_radians(float2 degrees)
{
	return (degrees * pi / 180.0f);
}

Ray rt_camera_get_ray(device struct s_cam *cam, uint2 viewport, uint2 pixel)
{
	float2 v = static_cast<float2>(viewport);
	float2 p = static_cast<float2>(pixel);
	//fov-range x and y
	float4 fr;
	fr.xy = float2(-1 * cam->fov[0] / 2, cam->fov[0] / 2);
	fr.zw = float2(-1 * cam->fov[1] / 2, cam->fov[1] / 2);
	//map to radians
	p = map2(p, float4(0, v.x, 0, v.y), fr);
	p = angle2_to_radians(p);
	float3 dest = rerp2(p, float3(cam->forward), float3(cam->right), float3(cam->up));
	Ray ray = Ray(float3(cam->pos), dest);
	return ray;
}

float2		rt_intersect_sphere(Ray ray, device struct s_sphere *sphere)
{
	float		a;
	float		b;
	float		c;
	float		d;
	float3		a_min_c;

	a_min_c = (ray.pos - sphere->pos);
	a = dot(ray.dir, ray.dir);
	b = 2 * dot(ray.dir, a_min_c);
	c = dot(a_min_c, a_min_c) - (sphere->r * sphere->r);
	d = (b * b) - 4 * a * c;
	if (d < 0)
		return (float2(INFINITY));
	return (float2(((-b - sqrt(d)) / (2 * a), (-b + sqrt(d)) / (2 * a))));
}

float	rt_dist_sphere(Ray ray, device struct s_sphere *sphere)
{
	float			minimal;
	float2			points;

	points = rt_intersect_sphere(ray, sphere);
	minimal = INFINITY;
	if (points.x > 0 && points.x < minimal)
		minimal = points.x;
	if (points.y > 0 && points.y < minimal)
		minimal = points.y;
	return (minimal);
}

float rt_dist(Ray ray, device struct s_obj *obj)
{
	if (obj->type == OBJ_SPHERE) {
		return (rt_dist_sphere(ray, &(obj->content.sphere)));
	}
	return (INFINITY);
}

int	find_material_by_id( int id, device struct s_mat *array, int len)
{
	for (int i = 0; i < len; i++)
	{
		if (array[i].id == id)
			return (i);
	}
	return (-1);
}

kernel void scene_test(	device struct		s_scn		*scene	[[buffer(0)]],
						texture2d<float,access::write> 	out		[[texture(1)]],
						uint2                  			gid 	[[thread_position_in_grid]])
{
	uint2 size = uint2(out.get_width(), out.get_height());
	device struct s_cam *cam = &scene->cameras[0];

	if (gid.x < size.x && gid.y < size.y)
	{
		float4 color = float4(0.5, 0.5, 0.5, 0);

		Ray ray = rt_camera_get_ray(cam, size, gid);

		int		nearest_id = -1;
		float	nearest_dist = INFINITY;

		for (int i = 0; i < scene->objects_num; i++)
		{
			float dist = rt_dist(ray, &scene->objects[i]);
			if (dist < nearest_dist && dist != INFINITY) {
				nearest_id = i;
				nearest_dist = dist;
			}
		}

		if (nearest_id >= 0) {
//			color = float4(0, 1, 0, 0);
			int index = find_material_by_id(
					scene->objects[nearest_id].material_id,
					scene->materials, scene->materials_num);
			if (scene->materials_num == 1) {
				color = float4(1, 1, 1, 0.0f);
			}
			else
			{
				color = float4(float3(scene->materials[index].albedo), 0.0f);
			}
		}

//		if (length(ray.dir - cam->forward) < 0.001) {
//			color = float4(0, 1, 0, 0);
//		}

		out.write(color, gid);
	}
}


