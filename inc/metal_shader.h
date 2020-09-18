/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   metal_shader.h                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: wpoudre <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/09/11 18:31:27 by wpoudre           #+#    #+#             */
/*   Updated: 2020/09/11 18:31:29 by wpoudre          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef METAL_SHADER_H

# define METAL_SHADER_H

# define WIN_WIDTH	1920
# define WIN_HEIGHT	1080
# define ALPHA_MAX	255
# define COLOR_MAX	255

typedef uchar4		t_color;

typedef enum		e_shape_type
{
	NONE = 0,
	CONE,
	SPHERE,
	PLANE,
	CYLINDER
}					t_shape_type;

typedef enum		e_camera_projection
{
	PROJECTION_ORTOGRAPHIC,
	PROJECTION_PERSPECTIVE
}					t_projection;

typedef enum		e_trace_mode
{
	TRACE_MODE_FULL,
	TRACE_MODE_NORMALS,
	TRACE_MODE_LIGHT,
	TRACE_MODE_COLOR,
	TRACE_MODE_DIST,
	TRACE_MODE_BRDF_G,
	TRACE_MODE_BRDF_D,
	TRACE_MODE_NORM_ANGLE
}					t_trace_mode;

typedef struct		s_color
{
	t_byte			r;
	t_byte			g;
	t_byte			b;
	t_byte			a;
}					t_color;

typedef	struct		s_ray
{
	float3			pos;
	float3			dir;
}					t_ray;

typedef struct		s_material
{
	float3 			color;
	float3			f0;
	float			ior;
	float 			roughness;
	float 			metalness;
}					t_material;

typedef struct		s_sphere
{
	float3			center;
	float			radius;
}					t_sphere;

typedef struct		s_cone
{
	float3			head;
	float3			tail;
	float			radius;
}					t_cone;

typedef struct		s_plane
{
	float3			center;
	float3			normal;
}					t_plane;

typedef struct		s_cylinder
{
	float3			head;
	float3			tail;
	float			radius;
}					t_cylinder;

typedef union		u_shape
{
	t_sphere		sphere;
	t_cone			cone;
	t_plane			plane;
	t_cylinder		cylinder;
}					t_shape;

typedef struct		s_obj
{
	t_shape			obj;
	t_shape_type	type;
	t_material		material;
}					t_obj;

typedef	struct		s_light
{
	size_t			id;
	float3			pos;
	float3			col;
	float			power;
}					t_light;

typedef struct		s_camera
{
	int				id;
	float3			pos;
	float3			plane_pos;
	float3			dir;
	float3			dir_right;
	float3			dir_up;
	float			size_x;
	float			size_y;
	t_projection	projection;
	t_trace_mode	mode;
}					t_camera;

typedef struct		s_scene
{
	t_material		*materials;
	size_t			mat_num;
	t_obj			*figs;
	size_t			fig_num;
	t_camera		*cameras;
	size_t			cam_num;
	t_camera		*cam_active;
	t_light			*lights;
	size_t			light_num;
}					t_scene;

typedef struct		s_ggx_loop
{
	t_ray			normal;
	t_ray			cam_ray;
	t_scene			*scene;
	t_light			*lamp;
	t_material		*mat;
}					t_ggx_loop;

bool				vec_point_is_behind(float3 vec_from_zero, float3 point);
bool				ray_point_is_behind(t_ray ray, float3 point);
float				num_clamp(float val, float min, float max);
float3				vec_clamp(float3 source, float min, float max);
float3				vec_to_srgb(float3 v);
t_color				col_from_vec_norm(float3 vector);
float3				fresnel_schlick(float3 f0, float cos_theta);
float				trace_dot_plane(t_ray ray, t_obj *fig);
float				trace_dot_cap(t_ray ray, t_ray plane_ray);
float				trace_dot_sphere(t_ray ray, t_obj *fig);
float3				cone_intersect(t_ray ray, t_cone cone, float3 v);
float				trace_dot_cone(t_ray ray, t_obj *fig);
float3				cylinder_intersect(t_ray ray, t_cylinder cyl, float3 v);
float				trace_dot_cylinder(t_ray ray, t_obj *fig);
float				trace_dot_fig(t_ray ray, t_obj *fig);
t_obj				*rt_trace_nearest_dist(t_scene *scene, t_ray ray, float *dist);
float3				trace_normal_plane(t_ray ray, t_obj *fig);
float3				trace_normal_sphere(t_ray ray, t_obj *fig);
float3				trace_normal_cone(t_ray ray_in, t_obj *fig);
float3				trace_normal_cylinder(t_ray ray, t_obj *fig);
float3				trace_normal_fig(t_ray ray, t_obj *fig);
t_color				rt_trace(t_scene *scene, t_ray ray, t_trace_mode mode);
t_ray				project_get_ray_from_coords(t_camera *cam, double x, double y);
float				ggx_distribution(float cos_theta_nh, float alpha);
float3				cook_torrance_ggx(float3 n, float3 l, float3 v, t_material *m);
t_color				rt_trace_mode_ggx(t_scene *scene, t_ray cam_ray);
float				ggx_partial_geometry(float cos_theta_n, float alpha);
t_color				col_from_normal(float3 vector);
t_color				rt_trace_mode_normals(t_scene *scene, t_ray ray);
t_obj				*rt_trace_nearest(t_scene *scene, t_ray ray);
t_color 			rt_trace_mode_color_only(t_scene *scene, t_ray ray);
t_color				rt_trace_mode_light(t_scene *scene, t_ray ray);
t_color				rt_trace_mode_dist(t_scene *scene, t_ray ray);
float				brdf_get_g(float3 n, float3 v, float3 l, t_material *mat);
t_color				rt_trace_brdf_g(t_scene *scene, t_ray ray);

#endif