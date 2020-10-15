/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   fio.h                                              :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcharla <kcharla@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/09/07 13:17:00 by kcharla           #+#    #+#             */
/*   Updated: 2020/10/14 01:26:44 by kcharla          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef FIO_H
# define FIO_H

# include "rts.h"

# define FIO_BUFFER_SIZE 1024

int			fio_read_file(char **dest, char *file);
int			fio_read_files(char **dest, char *filenames);

int			fio_zip_load_scene(t_scn **scene, char *filename);

#endif
