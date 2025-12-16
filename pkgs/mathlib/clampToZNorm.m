function y = clampToZNorm(u,max_z_norm,accuracy)

y = u;

znorm = abs(u(3));
if znorm > eps
    scale_factor = cast(max_z_norm / znorm, 'like', u);
else
    scale_factor = cast(1, 'like', u);
end

if scale_factor < 1
    if (max_z_norm < accuracy) && (znorm < accuracy)
        y(3) = u(3) * scale_factor;
    else
        y = u * scale_factor;
    end
end

end

