function y = constrain(x, min, max)

if (x < min)
    y = single(min);
elseif (x > max)
    y = single(max);
else
    y = single(x);
end

