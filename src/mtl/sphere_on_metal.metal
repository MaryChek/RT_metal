//TODO Нужно переписать весь код используя функции metal-а

typedef struct	s_vec
{
	float		x;
	float		y;
	float		z;
}				t_vec;

typedef struct 	s_sphere
{
	t_vec		chenter;
	float 		r;
	int 		color;
}				t_sphere;

typedef struct	s_img
{
	int			img_size_x;
	int			img_size_y;
	void		*img;
	int 		*img_data;
	int			bpp;
	int			sl;
	int			el;
}				t_img;

typedef struct	s_rend_par
{
	t_sphere 	sphere;
	t_vec 		camera_c;
	t_img 		conv;
}				t_rend_par;

//TODO Можешь удалить это если не нужно.
float			vec_length(t_vec a);
t_vec			vec_diff(t_vec a, t_vec b);
t_vec			vec_divis_cst(t_vec a, double t);
float			vec_dot(t_vec a, t_vec b);
t_vec			vec_scal_mult(t_vec a, t_vec b);
t_vec			vec_sum(t_vec a, t_vec b);
t_vec			vec_mult_cst(t_vec a, float t);
t_vec			rev_vec(t_vec a);
t_vec			norm_sphere(t_vec c, t_vec p);
int				ray_tracing(t_rend_par p, t_vec r);
int				color(int color, float i);
float			spec(t_vec l, t_vec n, t_vec p, t_vec v, float s, float i);
float			light_point(t_rend_par q, t_vec n, t_vec p, t_vec v, float s);
float			light_intens(t_rend_par q, t_vec n, t_vec p, t_vec v, float s);
int 			get_color(t_rend_par q, t_vec d, float t);

t_vec	vec_diff(t_vec a, t_vec b)
{
	a.x -= b.x;
	a.y -= b.y;
	a.z -= b.z;
	return(a);
}

t_vec	vec_divis_cst(t_vec a, double t)
{
	a.x /= t;
	a.y /= t;
	a.z /= t;
	return (a);
}

t_vec	vec_scal_mult(t_vec a, t_vec b)
{
	a.x *= b.x;
	a.y *= b.y;
	a.z *= b.z;
	return(a);
}

float		vec_dot(t_vec a, t_vec b)
{
	a = vec_scal_mult(a, b);
	return(a.x + a.y + a.z);
}

float		vec_length(t_vec vec)
{
	return (sqrt(pow(vec.x, 2.0l) + pow(vec.y, 2.0l) + pow(vec.z, 2.0l)));
}

t_vec	vec_sum(t_vec a, t_vec b)
{
	a.x += b.x;
	a.y += b.y;
	a.z += b.z;
	return (a);
}

t_vec	vec_mult_cst(t_vec a, float t)
{
	a.x *= t;
	a.y *= t;
	a.z *= t;
	return (a);
}

t_vec	rev_vec(t_vec a)
{
	a.x = -a.x;
	a.y = -a.y;
	a.z = -a.z;
	return (a);
}

t_vec	norm_sphere(t_vec c, t_vec p)
{
	t_vec	n;

	n = vec_diff(p, c);
	n = vec_divis_cst(n, vec_length(n));
	return (n);
}

int		color(int color, float i)
{
	int		red;
	int		green;
	int		blue;

	red = (color >> 16) & 0xFF;
	red = (int)(red * i);
	if (red > 0x0000FF)
		red = 0x0000FF;
	green = (color >> 8) & 0xFF;
	green = (int)(green * i);
	if (green > 0x0000FF)
		green = 0x0000FF;
	blue = (color & 0xFF);
	blue = (int)(blue * i);
	if (blue > 0x0000FF)
		blue = 0x0000FF;
	return ((red << 16) | (green << 8) | blue);
}

float	spec(t_vec l, t_vec n, t_vec p, t_vec v, float s, float i)
{
	t_vec	r;
	float 	r_dot_v;

	if (s >= 0)
	{
		r = (vec_diff(vec_mult_cst(vec_mult_cst(n, 2), vec_dot(n, l)), l));
		r_dot_v = vec_dot(r, v);
		if (r_dot_v > 0)
			return (i * pow(r_dot_v / (vec_length(r) * vec_length(v)), s));
		else
			return (0.0);
	}
	else
		return (0.0);
}

float	light_point(t_rend_par q, t_vec n, t_vec p, t_vec v, float s)
{
	double		intens;
	t_vec		l;
	double		n_dot_l;

	intens = 0.9;
	l = (t_vec){1, -1, 0};
	l = vec_diff(l, p);
	n_dot_l = vec_dot(n, l);
	if (n_dot_l > 0)
		return ((intens * n_dot_l / (vec_length(n) * vec_length(l)) + spec(l, n, p, v, s, intens)));
	else
		return (0.0);
}

float	light_intens(t_rend_par q, t_vec n, t_vec p, t_vec v, float s)
{
	double	i;

	i = light_point(q, n, p, v, s);
	return (i);
}

int get_color(t_rend_par q, t_vec d, float t)
{
	float	i;
	float	s;
	t_vec	p;
	t_vec	n;
	t_vec	v;

	s = 100.0f;
	p = vec_sum(q.camera_c, vec_mult_cst(d, t));
	n = norm_sphere(q.sphere.chenter, p);
	v = rev_vec(d);
	i = light_intens(q, n, p, v, s);
	return (color(q.sphere.color ,i));
}

int	ray_tracing(t_rend_par p, t_vec r)
{
	t_vec	d;
	t_vec	oc;
	float	disk;
	float	t1;
	float	t2;
	float	t_max;
	float	t_min;

	t_max = 2000000000.0f;
	t_min = 0.0f;
	d = vec_diff(r, p.camera_c);
	oc = vec_diff(p.camera_c, p.sphere.chenter);
	d = vec_divis_cst(d, vec_length(d));
	disk = (pow((2 * vec_dot(oc, d)), 2) - (4 * vec_dot(d, d) *(vec_dot(oc, oc) - pow(p.sphere.r, 2))));
	if (disk <= 0)
		return (0);
	t1 = ((-2 * vec_dot(oc, d)) + sqrt(disk)) / (2 * vec_dot(d, d));
	t2 = ((-2 * vec_dot(oc, d)) - sqrt(disk)) / (2 * vec_dot(d, d));
	t1 = min(t1, t2);
	if (t1 < t_max && t1 > t_min)
	{
		t_max = t1;
		return (get_color(p, d, t1));
	}
	return (0);
}

kernel void draw(/*TODO ставь тут то что надо ))) */ int* pixel, t_rend_par p)
{
	double	x;
	double	y;
	int		gid;

	gid = get_global_id(0);
	y = (double)(gid / p.conv.img_size_y) - p.conv.img_size_y / 2;
	x = (double)(gid % p.conv.img_size_x) - p.conv.img_size_x / 2;

	pixel[gid] = ray_tracing(p, (t_vec){x, y, p.conv.img_size_y});
}