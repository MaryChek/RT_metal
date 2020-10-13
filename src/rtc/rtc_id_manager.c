/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   rtc_id_manager.c                                   :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcharla <kcharla@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/10/12 21:21:25 by kcharla           #+#    #+#             */
/*   Updated: 2020/10/12 22:15:41 by kcharla          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "rt.h"

int			rtc_id_manager_next_id(t_idm *id_manager)
{
	if (id_manager == NULL)
		return (rt_err("id_manager is NULL pointer"));
	return (id_manager->current_id++);
}

int			rtc_id_manager_init(t_idm *id_manager)
{
	id_manager->current_id = 0;
	id_manager->next_id = rtc_id_manager_next_id;
	return (0);
}
