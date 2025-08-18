function y = saturation(x, lu, ub)

if x < lb
    y = lb;
elseif x > ub
    y = ub;
else
    y = x;
end