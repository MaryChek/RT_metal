/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   rtc_scn.h                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcharla <kcharla@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/10/01 16:13:04 by kcharla           #+#    #+#             */
/*   Updated: 2020/10/13 01:00:53 by kcharla          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef RTC_SCN_H
# define RTC_SCN_H

# include "rtc_scn_obj.h"

struct				s_cam
{
	int				id;
	t_vec3			pos;
	t_vec3			forward;
	t_vec3			up;
	t_vec3			right;
	t_vec2			fov;
};

#define RT_MAX_OBJECTS 128
#define RT_MAX_CAMERAS 16

/*
** objects_max and cameras_max values are
** needed for GPU to know size of arrays
** TODO defines are not enough?
*/

typedef struct		s_scn
{
	int				id;
	struct s_obj	objects[RT_MAX_OBJECTS];
	int				objects_num;
//	int				objects_max;
	struct s_cam	cameras[RT_MAX_CAMERAS];
	int				cameras_num;
//	int				cameras_max;
}					t_scn;


#endif
