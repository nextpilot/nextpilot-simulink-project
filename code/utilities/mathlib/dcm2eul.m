function [phi, theta, psi] = dcm2eul(R)

theta = single(asin(-R(3,1)));

if (abs(theta - pi/2) < 1e-3)
    phi = single(0);
    psi = single(atan2(R(2, 3), R(1, 3)));
elseif (abs(theta + pi/2) < 1e-3)
    phi = single(0);
    psi = single(atan2(-R(2, 3), -R(1, 3)));
else
    phi = single(atan2(R(3, 2), R(3, 3)));
    psi = single(atan2(R(2, 1), R(1, 1)));
end

end
