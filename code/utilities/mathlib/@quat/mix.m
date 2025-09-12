function vb = mix(q, va)
% 四元素混合积，物理意义表示刚体绕着轴旋转后的坐标
% 
% 矢量va 绕着四元数旋转之后的坐标为vb
%

vb = q * va * conj(q);

