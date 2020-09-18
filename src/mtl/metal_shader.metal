# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    metal_shader.metal                                 :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: wpoudre <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/09/11 18:30:35 by wpoudre           #+#    #+#              #
#    Updated: 2020/09/11 18:30:37 by wpoudre          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#include "metal_shader.h"

bool		vec_point_is_behind(float3 vec_from_zero, float3 point)
{
	float3 res;

	res = vec_from_zero * point;
	if (res.x + res.y + res.z < 0)
		return (true);
	return (false);
}

bool		ray_point_is_behind(t_ray ray, float3 point)
{
	return (vec_point_is_behind(ray.dir, (point - ray.pos)));
}

float					num_clamp(float val, float min, float max)
{
	if (val < min)
	{
		return (min);
	}
	if (val > max)
	{
		return (max);
	}
	return (val);
}

float3			vec_clamp(float3 source, float min, float max)
{
	source.x = num_clamp(source.x, min, max);
	source.y = num_clamp(source.y, min, max);
	source.z = num_clamp(source.z, min, max);
	return (source);
}

float3		vec_to_srgb(float3 v)
{
	v.x = pow(v.x, 1.0f / 2.2f);
	v.y = pow(v.y, 1.0f / 2.2f);
	v.z = pow(v.z, 1.0f / 2.2f);
	return (v);
}

t_color		col_from_normal(float3 vector)
{
	unsigned char	res[4];

	vector = normalize(vector);
	res[0] = (unsigned char)(vector.x + 1) * COLOR_MAX / 2;
	res[1] = (unsigned char)(vector.y + 1) * COLOR_MAX / 2;
	res[2] = (unsigned char)(vector.z + 1) * COLOR_MAX / 2;
	res[3] = ALPHA_MAX;
	return ((t_color){res[0], res[1], res[2], res[3]});

}

t_color		col_from_vec_norm(float3 vector)
{
	unsigned char	res[4];

	res[0] = (unsigned char)(num_clamp(vector.x, 0, 1) * COLOR_MAX);
	res[1] = (unsigned char)(num_clamp(vector.y, 0, 1) * COLOR_MAX);
	res[2] = (unsigned char)(num_clamp(vector.z, 0, 1) * COLOR_MAX);
	res[3] = ALPHA_MAX;
	return ((t_color){res[0], res[1], res[2], res[3]});
}

float3	fresnel_schlick(float3 f0, float cos_theta)
{
	float3	res;

	cos_theta = 1.0 - num_clamp(cos_theta, 0.0, 1.0);
	cos_theta = cos_theta * cos_theta * cos_theta * cos_theta * cos_theta;
	res = (((float3){1.0, 1.0, 1.0} - f0) * cos_theta);
	res = f0 + res;
	return (res);
}

float					trace_dot_plane(t_ray ray, t_obj *fig)
{
	t_plane				*pl;
	float				d_dot_v;

	if (fig == NULL)
		return (INFINITY);
	pl = &(fig->figs.plane);
	ray.dir = normalize(ray.dir);
	d_dot_v = dot(ray.dir, pl->normal);
	return (-1 * dot((ray.pos - (pl->normal * (-1.0 * pl->d))), pl->normal) / d_dot_v);
}

float					trace_dot_cap(t_ray ray, t_ray plane_ray)
{
	t_obj		fig;

	fig.type = PLANE;
	fig.obj.plane.normal = plane_ray.dir;
	fig.obj.plane.d = -(dot(plane_ray.dir, plane_ray.pos));
	return (trace_dot_plane(ray, &fig));
}

static float3			sphere_intersect_points(t_ray ray, t_sphere sphere)
{
	float		a;
	float		b;
	float		c;
	float		d;
	float3		a_min_c;

	a_min_c = (ray.pos - sphere.center);
	a = dot(ray.dir, ray.dir);
	b = 2 * dot(ray.dir, a_min_c);
	c = dot(a_min_c, a_min_c) - (sphere.radius * sphere.radius);
	d = (b * b) - 4 * a * c;
	if (d < 0)
		return ((float3){INFINITY, INFINITY, INFINITY});
	return ((float3){((-b - sqrt(d)) / (2 * a), (-b + sqrt(d)) / (2 * a), 0)});
}

float					trace_dot_sphere(t_ray ray, t_obj *fig)
{
	float			minimal;
	float3			points;

	if (fig == NULL)
		return (INFINITY);
	points = sphere_intersect_points(ray, fig->obj.sphere);
	minimal = INFINITY;
	if (points.x > 0 && points.x < minimal)
		minimal = points.x;
	if (points.y > 0 && points.y < minimal)
		minimal = points.y;
	return (minimal);
}

///cone trace------------------------------------------------------

float3					cone_intersect(t_ray ray, t_cone cone, float3 v)
{
	float3		x;
	float		a;
	float		b;
	float		c;
	float		d;

	d = cone.radius / length(cone.tail - cone.head);
	x = ray.pos - cone.tail;
	a = dot(ray.dir, ray.dir)
		- (1 + (d * d)) * sqrt(dot(ray.dir, v));
	b = (dot(ray.dir, x) - dot(ray.dir, v) * (1 + d * d) * dot(x, v)) * 2;
	c = dot(x, x) - (1 + d * d) * sqrt(dot(x, v));
	d = (b * b) - 4 * a * c;
	if (d < 0)
		return ((float3){INFINITY, INFINITY, INFINITY});
	d = sqrt(d);
	return ((float3){(-b - d) / (2 * a), (-b + d) / (2 * a), 0});
}

static float3			cone_capped(t_ray ray_in, t_cone cone)
{
	float3				points;
	float3				v;
	float3				m;
	float3				clamped;
	float				x_dot_v;

	v = normalize(cone.head - cone.tail);
	ray_in.dir = normalize(ray_in.dir);
	points = cone_intersect(ray_in, cone, v);
	x_dot_v = dot(ray_in.pos - cone.pos, v);
	m.x = dot(ray_in.dir, v * points.x) + x_dot_v;
	m.y = dot(ray_in.dir, v * points.y) + x_dot_v;
	clamped.x = num_clamp(m.x, 0, length(cone.tail - cone.head));
	clamped.y = num_clamp(m.y, 0, length(cone.tail - cone.head));
	if (clamped.x != m.x && clamped.y != m.y)
		return ((float3){INFINITY, INFINITY, INFINITY});
	if (clamped.x != m.x)
		points.x = trace_dot_cap(ray_in, (t_ray){cone.head, v});
	if (clamped.y != m.y)
		points.y = trace_dot_cap(ray_in, (t_ray){cone.head, v});
	return (points);
}

float					trace_dot_cone(t_ray ray, t_obj *fig)
{
	float 				minimal;
	float3 				points;

	if (fig == NULL)
		return (INFINITY);
	points = cone_capped(ray, fig->obj.cone);
	minimal = INFINITY;
	if (points.x > 0 && points.x < minimal)
		minimal = points.x;
	if (points.y > 0 && points.y < minimal)
		minimal = points.y;
	return (minimal);
}

///cylinder trace-----------------------------------------------

float3					cylinder_intersect(t_ray ray, t_cylinder cyl, float3 v)
{
	float3				x;
	float				a;
	float				b;
	float				c;
	float				d;

	x = ray.pos - cyl.tail;
	a = dot(ray.dir, ray.dir) - sqrt(dot(ray.dir, v));
	b = (dot(ray.dir, x) - dot(ray.dir, v) * dot(x, v)) * 2;
	c = dot(x, x) - sqrt(dot(x, v)) - sqrt(cyl.r);
	d = (b * b) - 4 * a * c;
	if (d < 0)
		return ((float3){INFINITY, INFINITY, INFINITY});
	d = sqrt(d);
	return ((float3){(-b - d) / (2 * a), (-b + d) / (2 * a), 0});
}

static float3			cylinder_capped(t_ray ray, t_cylinder cyl)
{
	float				maxm;
	float3				points;
	float3				v;
	float3				m;
	float				x_dot_v;

	v = normalize(cyl.head - cyl.tail));
	points = cylinder_intersect(ray, cyl, v);
	maxm = length(cyl.head - cyl.tail);
	x_dot_v = dot((ray.pos - cyl.tail), v);
	m.x = dot(ray.dir, (v * points.x)) + x_dot_v;
	m.y = dot(ray.dir, (v * points.y)) + x_dot_v;
	if (m.x >= 0 && m.x <= maxm && m.y >= 0 && m.y <= maxm)
		return (points);
	if ((m.x < 0 && m.y < 0) || (m.x > maxm && m.y > maxm))
		return ((float3){INFINITY, INFINITY, INFINITY});
	if (m.x < 0)
		points.x = trace_dot_cap(ray, (t_ray) {cyl.tail, -(v)});
	if (m.y < 0)
		points.y = trace_dot_cap(ray, (t_ray) {cyl.tail, -(v)});
	if (m.x > maxm)
		points.x = trace_dot_cap(ray, (t_ray){cyl.head, v});
	if (m.y > maxm)
		points.y = trace_dot_cap(ray, (t_ray){cyl.head, v});
	return (points);
}

float					trace_dot_cylinder(t_ray ray, t_obj *fig)
{
	float				minimal;
	float3				points;

	if (fig == NULL)
		return (INFINITY);
	points = cylinder_capped(ray, fig->obj.cylinder);
	minimal = INFINITY;
	if (points.x > 0 && points.x < minimal)
		minimal = points.x;
	if (points.y > 0 && points.y < minimal)
		minimal = points.y;
	return (minimal);
}

///figur trace-------------------------------------------------

float					trace_dot_fig(t_ray ray, t_obj *fig)
{
	if (fig == NULL)
		return (INFINITY);
	if (fig->type == PLANE)
		return (trace_dot_plane(ray, fig));
	else if (fig->type == SPHERE)
		return (trace_dot_sphere(ray, fig));
	else if (fig->type == CONE)
		return (trace_dot_cone(ray, fig));
	else if (fig->type == CYLINDER)
		return (trace_dot_cylinder(ray, fig));
	else
		return (INFINITY);
}

t_obj					*rt_trace_nearest_dist(t_scene *scene, t_ray ray, float *dist)
{
	t_obj				*nearest;
	float				tmp_dist;
	float				res_dist;
	size_t				i;

	if (scene == NULL)
		return (NULL);
	nearest = NULL;
	res_dist = INFINITY;
	i = 0;
	while (i < scene->fig_num)
	{
		tmp_dist = trace_dot_fig(ray, &(scene->figs[i]));
		if (tmp_dist < res_dist && tmp_dist > 0)
		{
			res_dist = tmp_dist;
			nearest = &(scene->figs[i]);
		}
		i++;
	}
	if (dist != NULL)
		*dist = res_dist;
	return (nearest);
}

float		brdf_get_g(float3 n, float3 v, float3 l, t_material *mat)
{
	float	g;
	float	roug_sqr;

	if (mat == NULL)
		return (INFINITY);
	roug_sqr = sqrt(mat->roughness);
	g = ggx_partial_geometry(dot(n, v), roug_sqr);
	g = g * ggx_partial_geometry(dot(n, l), roug_sqr);
	return (g);
}

///figur norm-------------------------------------------------

///plane norm-------------------------------------------------

float3				trace_normal_plane(t_ray ray, t_obj *fig)
{
	if (fig == NULL)
		return ((float3){INFINITY, INFINITY, INFINITY});
	if (fig->obj.plane.normal.x * ray.pos.x + fig->obj.plane.normal.y * ray.pos.y
		+ fig->obj.plane.normal.z * ray.pos.z + fig->obj.plane.d < 0)
		return (-(fig->obj.plane.normal));
	return (fig->obj.plane.normal);
}

///sphere norm------------------------------------------------

float3				trace_normal_sphere(t_ray ray, t_obj *fig)
{
	float3				bounce_pos;

	if (fig == NULL)
		return ((float3){INFINITY, INFINITY, INFINITY});
	bounce_pos = ray.pos + (ray.dir * trace_dot_sphere(ray, fig));
	return (normalize(bounce_pos - fig->obj.sphere.center));
}

///cone norm--------------------------------------------------

float3				trace_normal_cone(t_ray ray_in, t_obj *fig)
{
	float3			v;
	float3			point_p;
	float3			ca;
	float			cg;
	float			cr;

	if (fig == NULL)
		return ((float3){INFINITY, INFINITY, INFINITY});
	v = fig->obj.cone.head - fig->obj.cone.tail;
	ray_in.dir = normalize(ray_in.dir);
	point_p = ray_in.pos + ray_in.dir * trace_dot_cone(ray_in, fig);
	cg = length(v);
	cr = (float)sqrt((float)(sqrt(fig->obj.cone.radius) + sqrt(cg)));
	ca = normalize(v) * (cg * length(point_p - fig->obj.cone.tail) / cr);
	return (normalize(point_p - (fig->obj.cone.tail + ca)));
}

///cylinder norm-----------------------------------------------

static float3		cylinder_side_nrm(float3 p, float3 c, float3 v, t_num m)
{
	p = p - c;
	p = p - v * m;
	return (p);
}

static float3		cylinder_m(t_ray ray, float3 v, float3 cyl_pos, float3 points)
{
	float			x_dot_v;
	float3			m;

	x_dot_v = dot(ray.pos - cyl_pos, v);
	m.x = dot(ray.dir, v * points.x) + x_dot_v;
	m.y = dot(ray.dir, v * points.y) + x_dot_v;
	return (m);
}

float3				trace_normal_cylinder(t_ray ray, t_obj *fig)
{
	float			maxm;
	float3			dis;
	float3			v;
	float3			m;
	float3			p;

	if (fig == NULL)
		return ((float3){INFINITY, INFINITY, INFINITY});
	v = normalize(fig->obj.cylinder.head - fig->obj.cylinder.tail);
	dis = cylinder_intersect(ray, fig->obj.cylinder, v);
	maxm = length(fig->figs.cyl.pos - fig->figs.cyl.cap);
	m = cylinder_m(ray, v, fig->obj.cylinder.tail, dis);
	if (dis.x > dis.y)
	{
		dis.x = dis.y;
		m.x = m.y;
	}
	if (m.x < 0)
		return (-(v));
	else if (m.x > maxm)
		return (v);
	p = ray.pos + ray.dir * dis.x;
	return (cylinder_side_nrm(p, fig->obj.cylinder.tail, v, m.x));
}

float3		trace_normal_fig(t_ray ray, t_obj *fig)
{
	if (fig == NULL)
		return ((float3){INFINITY, INFINITY, INFINITY});
	if (fig->type == PLANE)
		return (trace_normal_plane(ray, fig));
	else if (fig->type == SPHERE)
		return (trace_normal_sphere(ray, fig));
	else if (fig->type == CONE)
		return (trace_normal_cone(ray, fig));
	else if (fig->type == CYLINDER)
		return (trace_normal_cylinder(ray, fig));
	else
		return ((float3){INFINITY, INFINITY, INFINITY});
}

t_color					rt_trace(t_scene *scene, t_ray ray, t_trace_mode mode)
{
	if (mode == TRACE_MODE_FULL)
		return (rt_trace_mode_ggx(scene, ray));
	else if (mode == TRACE_MODE_NORMALS)
		return (rt_trace_mode_normals(scene, ray));
	else if (mode == TRACE_MODE_COLOR)
		return (rt_trace_mode_color_only(scene, ray));
	else if (mode == TRACE_MODE_LIGHT)
		return (rt_trace_mode_light(scene, ray));
	else if (mode == TRACE_MODE_DIST)
		return (rt_trace_mode_dist(scene, ray));
	else if (mode == TRACE_MODE_BRDF_G)
		return (rt_trace_brdf_g(scene, ray));
	else if (mode == TRACE_MODE_BRDF_D)
		return (rt_trace_brdf_d(scene, ray));
	else if (mode == TRACE_MODE_NORM_ANGLE)
		return (rt_trace_mode_normals_angle(scene, ray));
	return (col(0, 0, 0));
}

t_ray					project_get_ray_from_coords(t_camera *cam, double x, double y)
{
	t_ray				ray;
	float3				dot;
	float3				dot_1;
	float3				dot_2;

	dot_1 = cam->dir_right * ((double)cam->size_x * ((double)(x / WIN_WIDTH) - (1.0 / 2.0)));
	dot_2 = dot_1 + (cam->dir_up * ((double)-1 * cam->size_y * ((double)(y / WIN_HEIGHT) - (1.0 / 2.0))));
	dot = cam->plane_pos + dot_2;
	ray.pos = cam->pos;
	ray.dir = normalize(dot - cam->pos);
	return (ray);
}

kernal	void 			shader(int pixel, t_obj *obj, t_camera *camera)
{
	t_ray				ray;

	ray = project_get_ray_from_coords(c, x, y);
	pixel = rt_trace(scene, ray, camera->mode);
}
