function y = IsFinite555(u, param)

if isfinite(u)
    y = single(u);
else
    y = single(param);
end

end


