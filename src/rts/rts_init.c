/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   rts_init.c                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcharla <kcharla@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/10/12 21:59:30 by kcharla           #+#    #+#             */
/*   Updated: 2020/10/12 22:08:04 by kcharla          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "rt.h"

int			rts_init(t_rts **rts_ptr)
{
	t_rts		*rts;

	if (rts_ptr == NULL)
		return (rt_err("rts_ptr is NULL pointer"));
	rts = NULL;
	rts = ft_memalloc(sizeof(t_rts));
	if (rts == NULL)
		return (rt_err("Cannot malloc rts variable"));
	if (rtc_id_manager_init(&(rts->idm)))
		return (rt_err("Cannot init ID manager"));
	if (rts->idm.next_id(&(rts->idm)) < 0)
		return (rt_err("ID manager error"));
	if (rtc_scn_init(&rts->scene, &rts->idm))
		return (rt_err("Cannot init scene"));
	*rts_ptr = rts;
	return (0);
}
