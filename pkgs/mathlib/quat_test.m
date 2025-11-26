p = rand(1,4)*20;
q = rand(1,4)*10;
v = rand(1,3)*10;
p = p/norm(p);
q = q/norm(q);

clc

% quatmod

% 计算范数dot(p, p)，注意没有开根
disp('求范数运算，注意没有开根')
quatnorm(p) - quat(p).norm()

% 归一化
disp('归一化运算q/sqrt(dot(q,q))')
quatnormalize(p) - quat(p).normalize().data'

% 共轭运算
disp('共轭运算conj(q)')
quatconj(q) - quat(q).conj().data'

% 逆运算
disp('逆运算inv(q)')
quatinv(q) - quat(q).inv().data'

% 乘法
disp('乘法运算p*q')
tmp = quat(p)*q;
quatmultiply(p, q) - tmp.data'


% quatdivide
disp('除法运算p/q')
tmp = quat(p)/quat(q);
quatdivide(p,q) -tmp.data'



% quatexp
disp('指数运算exp(q)')
quatexp(p) - quat(p).exp().data'

% quatlog，注意matlab要求归一化
disp('对数运算log(q)')
t = q/norm(q)*1;
quatlog(t) - quat(t).log().data'


% quatpower，matlab要求归一化
disp('幂运算q^n')
t = q/norm(q)*1;
quatpower(t, -2.65) - quat(t).power(-2.65).data'

% 旋转运算
disp('旋转运算q*v*q''')
quatrotate(p, v) - quat(p).rotate(v)

% quatinterp