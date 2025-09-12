function q = inv(q)

absq = dot(q.data, q.data);

q.real = q.real/absq;
q.imag = -q.imag/absq;
