function r = plus(p, q)

if ~isa(p,'quat')
    p = quat(p);
end

if ~isa(q, 'quat')
    q = quat(q);
end

r = quat(p.data + q.data);