function vb = rotate(q, va)
% 刚体旋转，矢量v绕着q旋转之后

% 需要先将q归一化
q = normalize(q);
% 矢量坐标旋转
r = conj(q) * va * q;
% 提取虚部
vb = reshape(imag(r), size(va));