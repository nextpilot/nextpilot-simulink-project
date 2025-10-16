function Ib = inertia_moving(Ia, m, pab)
% Ia：在a坐标下的惯性张量
% m：刚体质量
% pab，坐标系b原点在a坐标系中的向量
%
% example
%
% Ia = rand(3) + diag(rand(3,1)*10);
% Ia = Ia + Ia';
% m = 1;
% pab = [1 0 0]';
% Ia
% Ib = Ia + m*(pab'*pab*eye(3) - pab*pab')

% 转为列向量
pab = pab(:);
% 平移公式
Ib = Ia + m*(pab'*pab*eye(3) - pab*pab');
