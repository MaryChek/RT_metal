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

typedef struct		s_ray {
	packed_float3 origin;
	packed_float3 direction;
	float minDistance;
	float maxDistance;
}					t_ray;

enum e_obj_type
{
	NONE = 0,
	PLANE,
	SPHERE,
	CYLINDER,
	CONE,
	GEOMETRY
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
	packed_float3	fov;
};

#define RT_MAX_OBJECTS 128
#define RT_MAX_CAMERAS 16

typedef struct		s_scn
{
	int				id;
	struct s_obj	objects[RT_MAX_OBJECTS];
	int				objects_num;
	struct s_cam	cameras[RT_MAX_CAMERAS];
	int				cameras_num;
}					t_scn;

t_ray rt_camera_get_ray(device struct s_cam *cam, uint2 viewport, uint2 pixel)
{
	t_ray ray;
	ray.origin = cam->pos;
	ray.direction = cam->forward;
	ray.minDistance = 0.0;
	ray.maxDistance = INFINITY;
	return ray;
}

kernel void scene_test(	device struct		s_scn		*scene	[[buffer(0)]],
						texture2d<float,access::write> 	out		[[texture(1)]],
						uint2                  			gid 	[[thread_position_in_grid]])
{
	uint2 size = uint2(out.get_width(), out.get_height());
	if (gid.x < size.x && gid.y < size.x)
	{
		int32_t id = scene->id;
//		float x = scene->objects[0].content.sphere.x;
		float4 color = float4(0.5, 0.5, 0.5, 0);

		if (scene->objects[0].content.sphere.r == 4.1) {
			color = float4(0, 1, 0, 0);
		}
//		ray r = rt_camera_get_ray(&scene->cameras[0], out.height, gid);
		out.write(color, gid);
	}
}


