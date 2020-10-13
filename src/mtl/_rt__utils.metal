/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   _rt__utils.metal                                   :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcharla <kcharla@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/10/14 01:53:55 by kcharla           #+#    #+#             */
/*   Updated: 2020/10/14 01:53:55 by kcharla          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <metal_stdlib>
using namespace metal;

float		map(float x, float2 in, float2 out)
{
	return ((x - in.x) * (out.y - out.x) / (in.y - in.x) + out.x);
}

float2		map2(float2 val, float4 in, float4 out)
{
	return (float2(map(val.x, in.xy, out.xy), map(val.y, in.zw, out.zw)));
}

// round interpolation
// val must be in range (0 .. pi/2)
// from and to must be normalized
// from and to must be in 90 degree angle
float3 rerp(float val, float3 from, float3 to)
{
	return (normalize(from * cos(val) + to * sin(val)));
}

float3 rerp2(float2 val, float3 fromX, float3 toY, float3 toZ)
{
	return (normalize(rerp(val.x, fromX, toY) + rerp(val.y, fromX, toZ)));
}

float angle_to_radians(float degrees)
{
	return (degrees * pi / 180.0f);
}

float2 angle2_to_radians(float2 degrees)
{
	return (degrees * pi / 180.0f);
}
