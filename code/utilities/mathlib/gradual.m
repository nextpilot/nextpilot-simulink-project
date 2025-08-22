function y = gradual(value,x_low,x_high,y_low,y_high)

if value < x_low
    y = single(y_low);

elseif value > x_high
    y = single(y_high);

else
    a = (y_high - y_low) / (x_high - x_low);
    b = y_low - a * x_low;
    y = single(a) * single(value) + single(b);
end

end

