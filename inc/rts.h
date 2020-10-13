/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   rt_s.h                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcharla <kcharla@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/09/07 13:17:15 by kcharla           #+#    #+#             */
/*   Updated: 2020/10/13 00:58:26 by kcharla          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef RTS_H
# define RTS_H

/*
** RT Struct
*/

# include "libft.h"
# include "mlx.h"
# include "rtc_scn.h"

/*
** We cannot store (char *) values in structs
** because we cannot use pointer types in objects
** that we want to pass to GPU.
** So we store unique ID that corresponds
** to some string and/or other CPU resources
*/

/*
** Мы не можем хранить строки в объектах для видеокарты,
** так как в это указатели.
** Поэтому мы храним ID каждого объекта в самом объекте
** и по этому ID ищем ресуры (например имя) для каждого объекта
** в хранилище на оперативной памяти.
*/

typedef struct		s_id_manager
{
	int				current_id;
	int 			(*next_id)(struct s_id_manager *manager);
}					t_idm;

int					id_manager_next_id(struct s_id_manager *manager);

//flags settings here as bit field
//typedef struct	s_settings
//{
//	int 		flag_1 : 1;
//	int 		flag_2 : 1;
//	int 		flag_3 : 1;
//}				t_settings;

//TODO define in mlx
typedef void	t_mlx;

typedef struct	s_rts
{

	t_idm		idm;
	t_mlx		*mgx;
	t_scn		*scene;
}				t_rts;

int			rts_free(t_rts *rts);
int			rts_init(t_rts **rts);

#endif
