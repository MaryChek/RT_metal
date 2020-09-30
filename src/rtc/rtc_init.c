/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   rtc_init.c                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcharla <kcharla@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/09/30 21:04:09 by kcharla           #+#    #+#             */
/*   Updated: 2020/09/30 23:50:47 by kcharla          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "rt.h"

void		rtc_hooks_editor(void *win)
{
	mlx_hook(win, MLX_HOOK_DRAG_DROP, 0, rt_editor_drag_file, NULL);
}

// TODO add viewer window
// TODO add renderer window

int			rtc_init()
{

	if (rt_init())
		return (rt_err("Cannot init RT struct"));
	void *win_edit = mlx_window_add(g_mlx, 1000, 800, WINDOW_EDITOR);
	// creating windows
	if (win_edit == NULL)
		return (rt_err("Cannot init editor window"));
//	if (win_view == NULL)
//		return (rt_err("Cannot init viewer window"));
//	if (win_render == NULL)
//		return (rt_err("Cannot init renderer window"));

	// giving windows hooks
	rtc_hooks_editor(win_edit);
//	rtc_hooks_view(win_view);
//	rtc_hooks_render(win_render);

	mlx_loop_hook(g_mlx, rt_loop, g_rt);

	// TODO add this
//	if (mlx_metal_lib_load_source(d->mlx, libstr) != 0)
//		printf("lib govno\n");
//	else
//		printf("lib success!\n");

	return (0);
}
