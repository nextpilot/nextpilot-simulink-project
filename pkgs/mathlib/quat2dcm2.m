function dcm = quat2dcm(quat)
%
% 注意：机器人工具箱quat2rotm函数返回的dcm，跟本函数返回的dcm是转置关系
%
% see also QUAT2DCM, QUAT2ROTM

% 归一化
norm_quat = norm(quat);
if norm_quat > eps
    q = quat ./ norm(quat);
else
    q = cast([1 0 0 0], 'like', quat);
end

s = q(1);
x = q(2);
y = q(3);
z = q(4);

dcm = [
    1 - 2*(y.^2 + z.^2),   2*(x.*y - s.*z),       2*(x.*z + s.*y),
    2*(x.*y + s.*z),       1 - 2*(x.^2 + z.^2),   2*(y.*z - s.*x),
    2*(x.*z - s.*y),       2*(y.*z + s.*x),       1 - 2*(x.^2 + y.^2)
    ]';

end

