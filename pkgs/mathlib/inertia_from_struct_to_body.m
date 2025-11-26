function [Ixx, Iyy, Izz, Ixy, Ixz, Iyz] = inertia_from_struct_to_body(Ixx, Iyy, Izz, Ixy, Ixz, Iyz)

% 由后右上转为前右下坐标系，相当于绕y轴旋转180°
% x' = -x
% y' = y
% z' = -z
% 因此转动惯量关系为
% Ixx' = Ixx
% Iyy' = Iyy
% Izz' = Izz
% Ixy' = -Ixy
% Ixz' = Ixz
% Iyz' = -Iyz

Ixy = -Ixy;
Iyz = -Iyz;