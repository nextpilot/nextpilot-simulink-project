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
    y = cast(y_low, 'like', x);
elseif x > x_high
    y = cast(y_high, 'like', x);
else
    a = (y_high - y_low) / (x_high - x_low);
    b = y_low - a * x_low;
    y = cast(a * x + b, 'like', x);
end

