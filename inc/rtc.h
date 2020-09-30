/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   rtc.h                                              :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcharla <kcharla@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/09/30 20:58:12 by kcharla           #+#    #+#             */
/*   Updated: 2020/09/30 20:58:12 by kcharla          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef RTC_H
# define RTC_H

int		rtc_init();
int		rtc_loop();
void	rtc_hooks_editor(void *win);

//void	rtc_hooks_viewer(void *win)
//void	rtc_hooks_renderer(void *win)

#endif
