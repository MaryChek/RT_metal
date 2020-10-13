/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   fio_read_files.c                                   :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcharla <kcharla@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/10/14 00:12:16 by kcharla           #+#    #+#             */
/*   Updated: 2020/10/14 00:48:02 by kcharla          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

int				fio_read_err(char *msg, char *buf2free, int fd2close)
{
	free(buf2free);
	close(fd2close);
	return (rt_err(msg));
}

#define FIO_BUFFER_SIZE 1024

/*
** fnctl() is used to get state of file descriptor
** if any error happened during open() then fnctl() will return non-zero
*/

int				fio_read_file(char **dest, char *file)
{
	int			fd;
	int			val;
	char		buf[FIO_BUFFER_SIZE + 1];

	if (dest == NULL || file == NULL)
		return (rt_err("Argument is NULL pointer"));
	if (fcntl((fd = open(file, O_RDONLY)), F_GETFD) != 0)
		return (rt_err("Cannot open file"));
	*dest = NULL;
	while ((val = read(fd, buf, FIO_BUFFER_SIZE)) > 0)
	{
		buf[val] = '\0';
		file = *dest;
		if ((*dest = ft_str_add(*dest, buf)) == NULL)
			return (fio_read_err("Variable str is NULL pointer", file, fd));
	}
	if (val < 0)
		return (fio_read_err("System call read() returned error", *dest, fd));
	close(fd);
	return (0);
}

int				fio_read_files(char **dest, char *files)
{
	return (0);
}
