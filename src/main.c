/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcharla <kcharla@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/09/02 23:48:38 by kcharla           #+#    #+#             */
/*   Updated: 2020/10/12 22:19:10 by kcharla          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "rt.h"

//TODO parse arguments

int				main(int ac, char **av)
{
	t_rts		*rts;

	(void)ac;
	(void)av;
	if (rt_init(&rts))
		return (rt_err("Cannot init RT"));
	if (rt_loop(rts))
		return (rt_err("Cannot loop RT"));
	return (0);
}