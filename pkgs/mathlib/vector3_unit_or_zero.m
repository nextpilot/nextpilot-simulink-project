function out = vector3_unit_or_zero(vec)
n = norm(vec);

if n > eps
    out = vec / n;
else
    out = cast([0 0 0], 'like', vec);
end

end

