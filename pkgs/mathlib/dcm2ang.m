function ang = dcm2ang(dcm, seq)
%
% see also DCM2ANGLE, ROTM2EUL

arguments
    dcm 
    seq (1,:) {}='ZYX' 
end

dcm = dcm';
theta = asin(-dcm(3,1));

if (abs(theta - pi/2) < 1e-3)
    phi = 0;
    psi = atan2(dcm(2, 3), dcm(1, 3));
elseif (abs(theta + pi/2) < 1e-3)
    phi = 0;
    psi = atan2(-dcm(2, 3), -dcm(1, 3));
else
    phi = atan2(dcm(3, 2), dcm(3, 3));
    psi = atan2(dcm(2, 1), dcm(1, 1));
end

ang = cast([psi, theta, phi], 'like', dcm);
end
