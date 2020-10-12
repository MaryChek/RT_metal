/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   rtc_init.c                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcharla <kcharla@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/09/30 21:04:09 by kcharla           #+#    #+#             */
/*   Updated: 2020/10/12 23:27:26 by kcharla          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "rt.h"

void		rtc_hooks_editor(void *win)
{
	mlx_hook(win, MLX_HOOK_DRAG_DROP, 0, rt_editor_drag_file, NULL);
}

// TODO add viewer window
// TODO add renderer window

#define RT_BUF_SCENE "scene"


void rtc_mgx_load_buffer(t_rts *rts);
void rtc_mgx_load_lib(t_rts *rts, char *name);

int			rtc_init(t_rts *rts)
{
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

	rtc_mgx_load_lib(rts, "src/mtl/mtl_shader_language_example.metal");
	rtc_mgx_load_buffer(rts);


	return (0);
}

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void rtc_mgx_load_lib(t_rts *rts, char *name)
{
	char * libstr = NULL;
	long length;
	FILE * f = fopen (name, "rb");

	if (f)
	{
		fseek (f, 0, SEEK_END);
		length = ftell (f);
		fseek (f, 0, SEEK_SET);
		libstr = malloc (length + 1);
		if (libstr)
		{
			fread (libstr, 1, length, f);
		}
		fclose (f);

	}

	if (libstr == NULL)
	{
		printf("file govno!\n");
		return ;
	}

	libstr[length] = '\0';
	if (mlx_metal_lib_load_source(rts->mgx, libstr) != 0)
		printf("lib govno\n");
	else
		printf("lib success!\n");
}

void rtc_mgx_load_buffer(t_rts *rts)
{
	if (mlx_metal_buffer_add(rts->mgx, RT_BUF_SCENE, (void*)(rts->scene), (int)sizeof(t_scn)))
		ft_printf("buffer govno\n");
	else
	ft_printf("buffer success!\n");
}

