function y = IsFinite(u, param)

if isfinite(u)
    y = u;
else
    y = cast(param, 'like', u);
end
