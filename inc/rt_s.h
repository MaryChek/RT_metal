/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   rt_s.h                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcharla <kcharla@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/09/07 13:17:15 by kcharla           #+#    #+#             */
/*   Updated: 2020/09/07 13:17:15 by kcharla          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef RT_S_H
# define RT_S_H

# include "libft.h"
# include "mlx.h"

typedef struct	s_scene
{
	char		*scene_name;
}				t_scene;

//flags settings here as bit field
typedef struct	s_settings
{
	int 		flag_1 : 1;
	int 		flag_2 : 1;
	int 		flag_3 : 1;
}				t_settings;

//TODO define in mlx
typedef void	t_mlx;

typedef struct	s_rt
{
	t_mlx		*g_mgx;
	t_scene		*scene;
}				t_rt;

#endif
