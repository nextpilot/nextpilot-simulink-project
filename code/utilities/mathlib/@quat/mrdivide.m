function r = mrdivide(p, q)
% r=p/q;

if ~isa(p, 'quat')
    p=quat(p);
end

if ~isa(q, 'quat')
    q=quat(q);
end

r = p * q.inv();

