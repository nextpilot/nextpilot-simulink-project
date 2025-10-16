% So called exponential curve function implementation.
% It is essentially a linear combination between a linear and a cubic function.
% @param value [-1,1] input value to function
% @param e [0,1] function parameter to set ratio between linear and cubic shape
% 		0 - pure linear function
% 		1 - pure cubic function
% @return result of function output

 function result = expo(value, e)

x  = constrain(value, -1.0, 1.0);
ec = constrain(e, 0.0, 1.0);

result = (1 - ec) * x + ec * x^3;

 end


