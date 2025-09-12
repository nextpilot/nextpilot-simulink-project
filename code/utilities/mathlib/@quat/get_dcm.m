function r = get_dcm(q)
% 从四元数到方向余弦
% R = qv*qv' + [q0*I - qx^2]
% 其中
% qv = [q1, q2, q3]
% qx = []
% I  = eye(3)


q0 = q.q0;
q1 = q.q1;
q2 = q.q2;
q3 = q.q3;

qx = [
     q0  q3 -q2
    -q3  q0  q1
     q2 -q1  q0
    ];

qv = q.imag(:);

r = qv*qv' + qx^2;