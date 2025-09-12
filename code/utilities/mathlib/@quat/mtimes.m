function r = mtimes(p, q)
% ��Ԫ������Ԫ�����㣬P*Q
% ��Ԫ����ʸ�����㣬Q*v, v*Q
% ��Ԫ����������㣬Q*k��k*Q
% p = quat(p);
% q = quat(q);

p0 = real(p); pv = imag(p);
if isa(q, 'quat')
    q0 = real(q); qv = imag(q);
elseif length(q) == 3
    q0 = 0; qv = q;
elseif length(q) == 4
    q0 = q(1); qv = q(2:4);
end

pv = pv(:);
qv = qv(:);

r0 = p0*q0 - dot(pv, qv);
rv = p0*qv + q0*pv + cross(pv, qv);

r = quat();
r.real = r0;
r.imag = rv;