/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   rt_init.c                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcharla <kcharla@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/09/30 21:04:04 by kcharla           #+#    #+#             */
/*   Updated: 2020/09/30 21:04:04 by kcharla          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "rt.h"

//TODO implement initialization

int			rt_init()
{
	g_rt = ft_memalloc(sizeof(t_rt));
	if (g_rt == NULL)
		return (rt_err("Cannot malloc g_rt variable"));
	return (0);
}
