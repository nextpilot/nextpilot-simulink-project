function y = lerp(a, b, s)
%{
/*
 * Linear interpolation between 2 points a, and b.
 * s=0 return a
 * s=1 returns b
 * Any value for s is valid.
 */
%}
y = (1 - s) * a + s * b;
