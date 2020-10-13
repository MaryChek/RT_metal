/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   rtc_loop.c                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcharla <kcharla@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/09/30 21:04:13 by kcharla           #+#    #+#             */
/*   Updated: 2020/10/12 22:12:44 by kcharla          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "rt.h"

int		rtc_loop(void *ptr)
{
	(void)ptr;
	return (0);
}

//int		rtc_loop()
//{
//	t_rt	*rt;
//	t_mgx	*mgx;
//
//	if ((rt = (t_rt*)void_rt) == NULL)
//		return (-1);
//	if ((mgx = rt->mgx) == NULL)
//		return (-1);
//	if (mgx->win_active == NULL)
//		return (-1);
//	if (mgx->win_active->input.close)
//	{
//		ft_printf("pressed (X) button, exit...\n");
//		//rt_free(?)
//		exit(0);
//	}
//	clock_gettime(CLOCK_MONOTONIC_RAW, &(rt->timespec));
//	rt_loop_main_win(rt, mgx, mgx->win_active);
//	rt_run_coroutines(rt);
//	mgx_buf_merge(mgx->win_active->bufs, mgx_get_win_buf(mgx->win_active, 2));
//	mgx_win_draw(mgx->win_active);
//	return (0);
//}

//int		coroutine_add(t_rt *rt, int (*func)(t_rt*, t_timespec*, t_bool*))
//{
//	t_coroutine		*cor;
//
//	cor = &(rt->one_coroutine);
//	cor->timespec = rt->timespec;
//	cor->func = func;
//	return (0);
//}
//
//int		rt_loop_main_win(t_rt *rt, t_mgx *mgx, t_mgx_win *win)
//{
//	if (rt == NULL || mgx == NULL || win == NULL)
//		return (-1);
//	if (mgx_mouse_clicked_left(win))
//	{
//		ft_putstr("left button clicked!\n");
//		if (rt->one_coroutine.func == NULL)
//			coroutine_add(rt, coroutine_example);
//	}
//	if (mgx_mouse_clicked_right(win))
//	{
//		ft_putstr("right button clicked!\n");
//		rt->coroutines_run = FALSE;
//	}
//	return (0);
//}
//
//int		rt_run_coroutines(t_rt *rt)
//{
//	if (rt->one_coroutine.func == NULL)
//		return (0);
//	if (rt->one_coroutine.func(rt, &(rt->one_coroutine.timespec), &(rt->coroutines_run)))
//	{
//		rt->one_coroutine.func = NULL;
//	}
//	return (0);
//}
//


