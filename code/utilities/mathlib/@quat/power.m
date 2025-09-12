function r = power(q, w)
% 计算q^t = exp(w*log(q))

r = exp(w*log(q));
