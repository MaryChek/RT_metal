/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   rtc_init.c                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcharla <kcharla@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/09/30 21:04:09 by kcharla           #+#    #+#             */
/*   Updated: 2020/10/12 22:58:54 by kcharla          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "rt.h"

void		rtc_hooks_editor(void *win)
{
	mlx_hook(win, MLX_HOOK_DRAG_DROP, 0, rt_editor_drag_file, NULL);
}

// TODO add viewer window
// TODO add renderer window

int			rtc_init(t_rts *rts)
{
//	return (0);
	if (rts == NULL)
		return (rt_err("rts is NULL pointer"));
	void *win_edit = mlx_window_add(rts->mgx, 1000, 800, WINDOW_EDITOR);
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

	mlx_loop_hook(rts->mgx, rtc_loop, rts);

	// TODO add this
//	if (mlx_metal_lib_load_source(d->mlx, libstr) != 0)
//		printf("lib govno\n");
//	else
//		printf("lib success!\n");

	return (0);
}
