/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   fio_read_files.c                                   :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcharla <kcharla@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/10/14 00:12:16 by kcharla           #+#    #+#             */
/*   Updated: 2020/10/14 01:18:50 by kcharla          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "rt.h"

int				fio_read_files_cat(char **dest, char **files)
{
	int			i;
	size_t		size;

	if (dest == NULL || files == NULL)
		return (rt_err("Argument is NULL pointer"));
	size = 0;
	i = 0;
	while (files[i] != NULL)
		size += ft_strlen(files[i]);
	if ((*dest = ft_memalloc(size + 1)) == NULL)
		return (rt_err("System call malloc() returned NULL pointer"));
	(*dest)[0] = '\0';
	i = 0;
	while (files[i] != NULL)
		ft_strcat(*dest, files[i]);
	return (0);
}

/*
** Glues contents of multiple files into one string
**
** example call:
** fio_read_files(&mystr, "file1 file2 dir/file3");
*/

int				fio_read_files(char **dest, char *filenames)
{
	int			i;
	char		**files;
	int			size;

	if (filenames == NULL || dest == NULL)
		return (rt_err("Argument is NULL pointer"));
	files = ft_strsplit(filenames, ' ');
	i = 0;
	while (files[i] != NULL)
	{
		if (fio_read_file(&(files[i]), files[i]))
		{
			ft_free_char_2d_arr(&files);
			return (rt_err("Cannot read files"));
		}
		i++;
	}
	i = fio_read_files_cat(dest, files);
	ft_free_char_2d_arr(&files);
	if (i != 0)
		return (rt_err("Cannot concat file contents"));
	return (0);
}