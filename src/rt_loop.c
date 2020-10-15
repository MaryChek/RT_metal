/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   rt_loop.c                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcharla <kcharla@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/10/12 21:52:48 by kcharla           #+#    #+#             */
/*   Updated: 2020/10/12 21:54:03 by kcharla          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "rt.h"

int				rt_loop(t_rts *rts)
{
	if (rts == NULL)
		return (rt_err("rts_ptr is NULL pointer"));
	return (mlx_loop(rts->mgx));
}
