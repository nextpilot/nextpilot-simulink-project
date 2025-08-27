% * Wrap integer value to stay in range [low, high)
% *
% * @param x input possibly outside of the range
% * @param low lower limit of the allowed range
% * @param high upper limit of the allowed range
% * @return wrapped value inside the range
function [new_angle] = wrap(x, low, high)

range = high - low;

if (x < low)
    x = x + range * (floor((low - x) / range) + 1.0);
end

new_angle = low + mod((x - low), range);

end

