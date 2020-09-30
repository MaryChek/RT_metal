/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   rt_editor_drag_file.c                              :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcharla <kcharla@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/09/07 15:56:36 by kcharla           #+#    #+#             */
/*   Updated: 2020/09/30 23:52:30 by kcharla          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

# include "rt.h"

int				rt_editor_drag_file(char *filename, void *dataptr)
{
//	t_scene		*new_scene;

	(void)dataptr;
//	(void)filename;
	if (ft_memcmp(filename, MLX_FILE_PREFIX, ft_strlen(MLX_FILE_PREFIX)) != 0)
		return (-1);
	filename = filename + ft_strlen(MLX_FILE_PREFIX);
//	// TODO add hook code
	return (0);
}
