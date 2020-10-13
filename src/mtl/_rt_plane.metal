/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   _rt_plane.metal                                    :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcharla <kcharla@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/10/14 01:53:52 by kcharla           #+#    #+#             */
/*   Updated: 2020/10/14 01:53:52 by kcharla          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <metal_stdlib>
using namespace metal;

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

