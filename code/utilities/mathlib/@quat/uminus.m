function r = uminus(p)

if ~isa(p,'quat')
    p = quat(p);
end

r = quat(-p.data);