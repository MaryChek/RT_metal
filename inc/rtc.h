/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   rtc.h                                              :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcharla <kcharla@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/09/30 20:58:12 by kcharla           #+#    #+#             */
/*   Updated: 2020/10/13 01:02:35 by kcharla          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef RTC_H
# define RTC_H

# include "rtc_scn.h"
# include "rts.h"

int		rtc_init(t_rts *rts);
int		rtc_loop(void *ptr);
void	rtc_hooks_editor(void *win);

//void	rtc_hooks_viewer(void *win)
//void	rtc_hooks_renderer(void *win)

int		rtc_id_manager_init(t_idm *id_manager);


int		rtc_scn_init(t_scn **scn_ptr, t_idm *idm);
int		rtc_scn_free(t_scn *scene);

#endif
