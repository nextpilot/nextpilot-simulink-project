function [j, a, v, x] = evaluatePoly(j_in,a0,v0,x0,t,d)

jt = single(d) * j_in;
t2 = t^2;
t3 = t^3;

j = jt;
a = a0 + jt * t;
v = v0 + a0 * t + 0.5 * jt * t2;
x = x0 + v0 * t + 0.5 * a0 * t2 + 1 / 6 * jt * t3;

end

