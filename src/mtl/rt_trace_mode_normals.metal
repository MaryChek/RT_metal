# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    rt_trace_mode_normals.metal                        :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: wpoudre <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/09/17 15:03:44 by wpoudre           #+#    #+#              #
#    Updated: 2020/09/17 15:03:47 by wpoudre          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#include "metal_shader.h"

t_obj 	*rt_trace_nearest(t_scene *scene, t_ray ray)
{
	return (rt_trace_nearest_dist(scene, ray, NULL));
}

t_color		rt_trace_mode_normals(t_scene *scene, t_ray ray)
{
	t_obj	*nearest;

	if ((nearest = rt_trace_nearest(scene, ray)) != NULL)
	{
		return (col_from_normal(trace_normal_fig(ray, nearest)));
	}
	return ((t_color){0, 0, 0, ALPHA_MAX});
}
