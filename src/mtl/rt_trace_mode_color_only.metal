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
		if (nearest->material != NULL)
			return (col_from_vec_norm(nearest->material.color));
	}
	return ((t_color)(0, 0, 0, ALPHA_MAX));
}

kernal	void 	trace_mode_color_only(	device	t_scene* 				scene [[buffer(0)]],
										texture2d<float,access::write>	pixel [[texture(1)]],
										uint2                     		gid [[thread_position_in_grid]])
{
	t_rat	ray;
	t_scene s;
	float4	color;
	t_color	buf;

	ray = project_get_ray_from_coords(scene.camera, git.x, git.y);
	buf = rt_trace_mode_color_only(scene, ray);
	color = (float4){buf.r, buf.g, buf.g, buf.a};
	out.write(color, git);
}
