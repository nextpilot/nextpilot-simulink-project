
function y = sqrt_linear(x)
%{
/*
 * Squareroot, linear function with fixed corner point at intersection (1,1)
 *                     /
 *      linear        /
 *                   /
 * 1                /
 *                /
 *      sqrt     |
 *              |
 * 0     -------
 *             0    1
 */
%}

if (x < 0)
    y = 0;
elseif (x < 1)
    y = sqrt(x);
else
    y = x;
end