function q = set_vect(q,a,b)
axis = cross(a,b);

sinb = norm(axis);
cosb = abs(dot(a,b));

sigma = atan2d(sinb, cosb);

q = q.setaxis(axis, sigma);