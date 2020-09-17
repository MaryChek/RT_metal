# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    rt_trace_mode_color_only.metal                     :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: wpoudre <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/09/17 15:45:55 by wpoudre           #+#    #+#              #
#    Updated: 2020/09/17 15:45:58 by wpoudre          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#include "metal_shader.h"

t_color 		rt_trace_mode_color_only(t_scene *scene, t_ray ray)
{
	t_obj 	*nearest;

	if ((nearest = rt_trace_nearest(scene, ray)) != NULL)
	{
		if (nearest->mat != NULL)
			return (col_from_vec_norm(nearest->material.color));
	}
	return ((t_color)(0, 0, 0, ALPHA_MAX));
}
