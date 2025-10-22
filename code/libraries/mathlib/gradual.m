function y = gradual(x, x_low, x_high, y_low, y_high)
%{
/*
 * Constant, linear, constant function with the two corner points as parameters
 * y_high          -------
 *                /
 *               /
 *              /
 * y_low -------
 *         x_low   x_high
 */
%}
if x < x_low
    y = single(y_low);
elseif x > x_high
    y = single(y_high);
else
    a = (y_high - y_low) / (x_high - x_low);
    b = y_low - a * x_low;
    y = single(a) * single(x) + single(b);
end

