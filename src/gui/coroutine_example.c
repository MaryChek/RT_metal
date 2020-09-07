/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   coroutine.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: u18600003 <u18600003@student.42.fr>        +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/09/02 09:46:27 by u18600003         #+#    #+#             */
/*   Updated: 2020/09/02 10:48:00 by u18600003        ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "rt.h"

/*
** Coroutine can be terminated by time
** Coroutine can be also terminated by some boolean flag
** Coroutine have to terminate if parameters are wrong
**
** Coroutine Example:
** - Coroutine runs
** - Every iteration it prints "coroutine running"
** - If 5 seconds passes since it was added it prints
** 		"coroutine stopped by time" and terminates
** - If flag is false it prints
** 		"coroutine stopped by flag" and terminates
** - If parameters are wrong it prints
** 		"coroutine stopped by flag" and terminates
*/

#define FIVE_SECONDS 5

int		coroutine_example(t_rt *rt, t_timespec *time_start, t_bool *flag)
{
	t_timespec		*time_now;
	t_uint64		delta_seconds;

	if (rt == NULL || time_start == NULL || flag == NULL)
	{
		ft_putstr("coroutine stopped by wrong parameters\n");
		return (-1);
	}
	time_now = &(rt->timespec);
	delta_seconds = (time_now->tv_sec - time_start->tv_sec) ;
	if (delta_seconds >= FIVE_SECONDS)
	{
		ft_putstr("coroutine stopped by time\n");
		return (-1);
	}
	if (*flag == FALSE)
	{
		ft_putstr("coroutine stopped by flag\n");
		return (-1);
	}
	ft_putstr("coroutine running\n");
	return (0);
}