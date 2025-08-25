function payload = init_payload()

% 光电吊舱重量5kg
payload.weight = 5;
% 光电的转动惯量已叠加到全机重量了
payload.inertia = zeros(3,3);
% 光电吊舱的重心坐标（构型坐标系）
payload.cog = [0 0 0];