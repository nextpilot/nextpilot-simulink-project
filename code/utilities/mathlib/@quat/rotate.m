function vb = rotate(q, va)
% ������ת��ʸ��v����q��ת֮��

% ��Ҫ�Ƚ�q��һ��
q = normalize(q);
% ʸ��������ת
r = conj(q) * va * q;
% ��ȡ�鲿
vb = reshape(imag(r), size(va));