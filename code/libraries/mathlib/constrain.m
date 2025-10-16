function result = constrain(input, min_val, max_val)

if (input < min_val)
    result = single(min_val);
elseif (input > max_val)
    result = single(max_val);
else
    result = single(input);
end

end


