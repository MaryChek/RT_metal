/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   rtc_scene.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcharla <kcharla@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/10/12 20:53:18 by kcharla           #+#    #+#             */
/*   Updated: 2020/10/13 01:47:37 by kcharla          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "rt.h"

int			rtc_scn_init(t_scn **scn_ptr, t_idm *idm)
{
	t_scn			*scene;

	if (idm == NULL)
		return (rt_err("idm is NULL pointer"));
	if (scn_ptr == NULL)
		return (rt_err("scn_ptr is NULL pointer"));
	scene = NULL;
	scene = ft_memalloc(sizeof(t_scn));

	scene->id = 5;//idm->next_id(idm);

	scene->objects[0].id = 6;
	scene->objects[0].type = OBJ_SPHERE;
	scene->objects[0].content.sphere.pos = (t_vec3){1.0, 2.0, 3.3};
	scene->objects[0].content.sphere.r = (t_num){4.1};
	scene->objects_num = 1;


	scene->cameras_num = 0;
	//TODO init scene

	*scn_ptr = scene;
	return (0);
}

int			rtc_scn_free(t_scn *scene)
{
	if (scene == NULL)
		return (0);
	free(scene);
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


