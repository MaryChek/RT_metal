/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcharla <kcharla@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/09/02 23:48:38 by kcharla           #+#    #+#             */
/*   Updated: 2020/09/07 15:56:37 by kcharla          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "rt.h"

t_rt		*g_rt;
t_mlx		*g_mlx;

int				main(int ac, char **av)
{
	void		*win_edit;
//	void		*win_view;
//	void		*win_rend;

	(void)ac;
	(void)av;
	g_rt = NULL;
	if ((g_rt = rt_init()) == NULL)
		return (rt_err("Cannot init RT"));
	if ((g_mlx = mlx_init()) == NULL)
		return (rt_err("Cannot init MLX"));
	win_edit = mlx_window_add(g_mlx, 1000, 800, WINDOW_EDITOR);
//	win_view = mlx_window_add(g_mlx, 1000, 800, WINDOW_VIEWER);
//	win_rend = mlx_window_add(g_mlx, 1000, 800, WINDOW_RENDERER);
	mlx_hook(win_edit, MLX_HOOK_DRAG_DROP, 0, rt_editor_drag_file, NULL);
	mlx_loop_hook(g_mlx, rt_loop, g_rt);
	mlx_loop(g_mlx);
	return (0);
}