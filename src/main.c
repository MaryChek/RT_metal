/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcharla <kcharla@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/09/02 23:48:38 by kcharla           #+#    #+#             */
/*   Updated: 2020/09/30 21:04:23 by kcharla          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "rt.h"

t_rt			*g_rt;
t_mlx			*g_mlx;

int				rt_loop(void *void_rt)
{
	(void)void_rt;
	return (rtc_loop());
}

//TODO parse arguments

int				main(int ac, char **av)
{
	(void)ac;
	(void)av;
	g_rt = NULL;
	g_mlx = NULL;
	if ((g_mlx = mlx_init()) == NULL)
		return (rt_err("Cannot init MLX"));
	if (rtc_init())
		return (rt_err("Cannot init RT"));
	mlx_loop_hook(g_mlx, rt_loop, g_rt);
	mlx_loop(g_mlx);
	return (0);
}