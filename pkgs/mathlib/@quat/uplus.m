function r = uplus(p)

if ~isa(p,'quat')
    p = quat(p);
end



r = p;