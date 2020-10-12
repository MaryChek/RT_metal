/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   rt_init.c                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcharla <kcharla@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/10/12 21:53:04 by kcharla           #+#    #+#             */
/*   Updated: 2020/10/12 23:15:52 by kcharla          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "rt.h"

/*
** rts_init() allocates rts struct
**
** mlx_init() inits internal mlx functionality
**
** rtc_init() binds mlx/mgx hooks and glues rts and mgx together
*/

int				rt_init(t_rts **rts_ptr)
{
	t_rts		*rts;

	if (rts_ptr == NULL)
		return (rt_err("rts_ptr is NULL pointer"));
	rts = NULL;
	if ((rts_init(&rts)))
		return (rt_err("Cannot init RT struct"));
	if ((rts->mgx = mlx_init()) == NULL)
		return (rt_err("Cannot init MLX"));
	if (rtc_init(rts))
		return (rt_err("Cannot init RT core"));
	*rts_ptr = rts;
	return (0);
}
