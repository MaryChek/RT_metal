/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   rt_init.c                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcharla <kcharla@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/10/12 21:53:04 by kcharla           #+#    #+#             */
/*   Updated: 2020/10/12 22:19:52 by kcharla          ###   ########.fr       */
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
	if (rts_ptr == NULL)
		return (rt_err("rts_ptr is NULL pointer"));
	*rts_ptr = NULL;
	if ((rts_init(rts_ptr)))
		return (rt_err("Cannot init RT struct"));
	if (((*rts_ptr)->mgx = mlx_init()) == NULL)
		return (rt_err("Cannot init MLX"));
	if (rtc_init(*rts_ptr))
		return (rt_err("Cannot init RT core"));
	return (0);
}
