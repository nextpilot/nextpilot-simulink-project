function r = cross(p, q)

r = quat();

r.real = q.real * q.real - dot(p.imag, q.imag);
r.imag = cross(p.imag, q.imag);