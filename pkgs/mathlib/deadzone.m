function y = deadzone(x, dz)
% Deadzone function being linear and continuous outside of the deadzone
% 1                ------
%                /
%             --
%           /
% -1 ------
%        -1 -dz +dz 1
% @param value [-1,1] input value to function
% @param dz [0,1) ratio between deazone and complete span
% 		0 - no deadzone, linear -1 to 1
% 		0.5 - deadzone is half of the span [-0.5,0.5]
% 		0.99 - almost entire span is deadzone

xc = constrain(x, -1.0, 1.0);
dzc = constrain(dz, 0, 0.99);

% Rescale the input such that we get a piecewise linear function that will be continuous with applied deadzone
out = (xc - sign(xc) * dzc) / (1 - dzc);

% apply the deadzone (values zero around the middle)
y = out * (abs(xc) > dzc);

