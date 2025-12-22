function y = constrain(x, min, max)

if (x < min)
    y = cast(min, 'like', x);
elseif (x > max)
    y = cat(max, 'like', x);
else
    y = x;
end

