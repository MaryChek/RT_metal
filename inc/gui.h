/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   gui.h                                              :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcharla <kcharla@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/09/07 13:17:05 by kcharla           #+#    #+#             */
/*   Updated: 2020/09/07 15:57:22 by kcharla          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef GUI_H
# define GUI_H

/*
** MLX pointer
*/
t_mlx			*g_mlx;

# define WINDOW_EDITOR   "Editor"
# define WINDOW_VIEWER   "Viewer"
# define WINDOW_RENDERER "Renderer"

int				rt_editor_drag_file(char *filename, void *dataptr);

#endif
