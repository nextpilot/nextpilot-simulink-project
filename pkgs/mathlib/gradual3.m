function y = gradual3(x, x_low, x_middle, x_high, y_low, y_middle, y_high)
%{
/*
 * Constant, linear, linear, constant function with the three corner points as parameters
 *  y_high               -------
 *                      /
 *                    /
 *  y_middle        /
 *                /
 *               /
 *              /
 * y_low -------
 *         x_low x_middle x_high
 */
%}
if (x < x_middle)
    y = gradual(value, x_low, x_middle, y_low, y_middle);

else
    y = gradual(x, x_middle, x_high, y_middle, y_high);
end
