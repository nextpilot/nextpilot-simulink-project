function y = superexpo(x, e, g)
%{
/*
 * So called SuperExpo function implementation.
 * It is a 1/(1-x) function to further shape the rc input curve intuitively.
 * I enhanced it compared to other implementations to keep the scale between [-1,1].
 * @param value [-1,1] input value to function
 * @param e [0,1] function parameter to set ratio between linear and cubic shape (see expo)
 * @param g [0,1) function parameter to set SuperExpo shape
 * 		0 - pure expo function
 * 		0.99 - very strong bent curve, stays zero until maximum stick input
 * @return result of function output
 */
%}

xc = constrain(x, -1, 1);
gc = constrain(g, 0, 0.99);
y= expo(xc, e) * (1 - gc) / (1 - abs(xc) * gc);
