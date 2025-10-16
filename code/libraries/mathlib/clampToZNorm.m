function y = clampToZNorm(u,max_z_norm,accuracy)

y = u;

znorm = abs(u(3));
if znorm > eps
    scale_factor = max_z_norm / znorm;
else
    scale_factor = single(1);
end

if scale_factor < 1
    if (max_z_norm < accuracy) && (znorm < accuracy)
        y(3) = u(3) * scale_factor;
    else
        y = u * scale_factor;
    end
end

end

