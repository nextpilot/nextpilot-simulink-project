function y = IsFinite(u, param)

if isfinite(u)
    y = single(u);
else
    y = single(param);
end

end


