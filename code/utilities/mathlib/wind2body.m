function Rba = wind2body(alpha, beta)
% 从机体到气流坐标系的旋转过程是
% (1)绕y轴旋转-alpha
% (2)绕z轴旋转beta

Rba = [
        cos(alpha)*cos(beta), -cos(alpha)*sin(beta), -sin(alpha)
                   sin(beta),             cos(beta),           0
        cos(beta)*sin(alpha), -sin(alpha)*sin(beta),  cos(alpha)
    ]';

