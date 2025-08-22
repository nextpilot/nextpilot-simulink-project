function y = clampToXYNorm(u,max_xy_norm,accuracy)

y = u;

xynorm = norm([u(1), u(2)]);
if xynorm > eps
    scale_factor = max_xy_norm / xynorm;
else
    scale_factor = single(1);
end

if scale_factor < 1
    if (max_xy_norm < accuracy) && (xynorm < accuracy)
        y(1) = u(1) * scale_factor;
        y(2) = u(2) * scale_factor;
    else
        y = u * scale_factor;
    end
end

end

