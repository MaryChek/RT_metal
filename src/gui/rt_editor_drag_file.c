/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   rt_editor_drag_file.c                              :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcharla <kcharla@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/09/07 15:56:36 by kcharla           #+#    #+#             */
/*   Updated: 2020/09/07 16:02:25 by kcharla          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

# include "rt.h"

int				rt_editor_drag_file(char *filename, void *dataptr)
{
//	t_scene		*new_scene;

	(void)dataptr;
//	(void)filename;
	if (ft_memcmp(filename, MLX_FILE_PREFIX, ft_strlen(MLX_FILE_PREFIX)) != 0)
		return (-1);
	filename = filename + ft_strlen(MLX_FILE_PREFIX);
//	if ((new_scene = fio_load_scene()) == NULL)
//		return (rt_warn("Cannot load scene"));
//	if (g_rt->scene != NULL)
//		rt_scene_free();
//	g_rt->scene = new_scene;
//	rt_editor_update();
//	rt_viewer_update();

	int w, h;
	(void)w;
	(void)h;
	// TODO delete demo old code
	void *pngimg = mlx_png_file_to_image(g_mlx, filename, &w, &h);
	if (pngimg == NULL)
		return (-1);
	mlx_put_image_to_window(g_mlx, mlx_window_get(g_mlx, WINDOW_EDITOR), pngimg, 0, 0);
	mlx_beep(g_mlx);
	return (0);
}
