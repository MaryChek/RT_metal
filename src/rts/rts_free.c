/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   rts_free.c                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcharla <kcharla@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/10/12 22:00:36 by kcharla           #+#    #+#             */
/*   Updated: 2020/10/12 22:04:21 by kcharla          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "rt.h"

/*
** Assumes mlx/mgx is deinited/freed
*/

int			rts_free(t_rts *rts)
{
	if (rts == NULL)
		return (0);
	rtc_scn_free(rts->scene);
	free(rts);
	return (0);
}
