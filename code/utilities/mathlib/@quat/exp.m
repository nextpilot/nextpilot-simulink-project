function e = exp(q)
% 计算exp(q)指数

s = q.real;
v = q.imag;

absv = sqrt(dot(v, v));

eq = exp(s) * [cos(absv); v / absv * sin(absv)];

e = quat(eq);