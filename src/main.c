/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcharla <kcharla@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/09/02 23:48:38 by kcharla           #+#    #+#             */
/*   Updated: 2020/09/02 23:48:38 by kcharla          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "rt.h"

int				main(int ac, char **av)
{
	t_rt		rt;

	(void)ac;
	(void)av;
	ft_bzero(&rt, sizeof(t_rt));
	rt.one_coroutine.func = NULL;
	rt.coroutines_run = TRUE;
	if (mgx_init("RT - ray-tracing renderer", (t_size2){640, 480}, &(rt.mgx)))
		return (-1);
	if (mgx_loop(rt.mgx, rt_loop, &rt))
		return (-1);
	return (0);
}