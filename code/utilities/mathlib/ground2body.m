function Rbe = ground2body(phi, theta, psi)
% 从地面坐标系到机体坐标系的旋转过程
% (1)绕z轴旋转psi
% (2)绕y轴旋转theta
% (3)绕x轴旋转phi

Rbe = [
                                 cos(psi)*cos(theta),                              cos(theta)*sin(psi),         -sin(theta)
    cos(psi)*sin(phi)*sin(theta) - cos(phi)*sin(psi), cos(phi)*cos(psi) + sin(phi)*sin(psi)*sin(theta), cos(theta)*sin(phi)
    sin(phi)*sin(psi) + cos(phi)*cos(psi)*sin(theta), cos(phi)*sin(psi)*sin(theta) - cos(psi)*sin(phi), cos(phi)*cos(theta)
    ];

