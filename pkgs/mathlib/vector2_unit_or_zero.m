function out = vector2_unit_or_zero(vec)

out = [single(0), single(0)];

n = norm(vec);
if n > eps
    out = vec / n;
end

end

