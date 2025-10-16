function l = log(q)

absq = sqrt(dot(q.data, q.data));
absv = sqrt(dot(q.imag, q.imag));

l = quat([log(absq); q.imag / absv * acos(q.real/absq)]);