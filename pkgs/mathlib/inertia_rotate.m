function Ib = inertia_rotate(Ia, Rab)
%
% Ia，在a坐标系下的惯性张量
% Rab，坐标系a到b的方向余弦
% Ib，在b坐标系的惯性张量
%
% see also
%
% (1) https://blog.csdn.net/weixin_45910027/article/details/129648972
% (2) http://jgsx-csiam.org.cn/CN/10.3969/j.issn.1005-3085.2022.06.013
%
% example
%
% Ia = rand(3) + diag(rand(3,1)*10);
% Ia = Ia + Ia';
% Rab = angle2dcm(pi/2,0,0,'zyx');
% Ib = Rab * Ia * Rab'

Ib = Rab * Ia * Rab';