function q = ang2quat(varargin)
% ang2quat 根据绕XYZ轴旋转角创建方向余弦矩阵
%
% dcm = ang2quat(r1,r2,r3,...,'xyz...')
% dcm = ang2quat([r1, r2, ...], 'xyz...')
% 其中: 
%    r1, r2, r3, 是旋转角度（弧度或sym符号）
%    'xyz...'，是每次旋转的轴，是xyz的组合
%
% Examples:
%
%  Determine the direction cosine matrix from rotation angles:
%  yaw = 0.7; pitch = 0.2; roll = 0.6;
%  dcm = ang2quat(yaw, pitch, roll, 'zyx')
%
%  使用sym符号运算，进行公式推导
%  syms yaw pitch roll real
%  dcm = ang2quat(yaw, pitch, roll, 'zyx')
%
% See also ANGLE2QUAT, EUL2QUAT

if nargin < 2
    error('ang2quat:inputerror', '至少包含两个输入参数！');
else
    tmp = cellfun(@(x)x(:), varargin(1:end-1), 'UniformOutput', false);
    ang = cat(1, tmp{:});
    seq = varargin{end};
end

if length(ang) ~= length(seq)
    warning('ang2quat:lengtherror', '输入角度和转轴长度不一致！');
end

n = min(length(ang), length(seq));

q = [1 0 0 0];
for i = 1 : n
    r = sig2quat(ang(i), seq(i));
    q = quatmult(q, r);    
end

function q = sig2quat(t, k)
s = sin(t/2);
c = cos(t/2);

switch k
    case {'x','X'}
        q = [c s 0 0];
    case {'y','Y'}
        q = [c 0 s 0];
    case {'z','Z'}
        q = [c 0 0 s];
end

function r = quatmult(p, q)

r = zeros(1, 4);

ps = p(1); pv = p(2:end);
qs = q(1); qv = q(2:end);

r(1) = ps*qs - dot(pv, qv);
r(2:4) = ps*qv + qs*pv + cross(pv, qv);