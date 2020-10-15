/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   rt.h                                               :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcharla <kcharla@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/09/07 13:17:11 by kcharla           #+#    #+#             */
/*   Updated: 2020/10/12 22:14:41 by kcharla          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef RT_H
# define RT_H

/*
** Main header
*/

# include "err.h"
# include "fio.h"
# include "gui.h"
# include "rtc.h"

int		rt_init(t_rts **rts);
int		rt_loop(t_rts *rts);

#endif
