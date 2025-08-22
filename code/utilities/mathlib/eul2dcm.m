function dcm = eul2dcm(phi,theta,psi)
dcm = zeros(3,3);

cosPhi = cos(phi);
sinPhi = sin(phi);
cosThe = cos(theta);
sinThe = sin(theta);
cosPsi = cos(psi);
sinPsi = sin(psi);

dcm(1, 1) = cosThe * cosPsi;
dcm(1, 2) = -cosPhi * sinPsi + sinPhi * sinThe * cosPsi;
dcm(1, 3) = sinPhi * sinPsi + cosPhi * sinThe * cosPsi;

dcm(2, 1) = cosThe * sinPsi;
dcm(2, 2) = cosPhi * cosPsi + sinPhi * sinThe * sinPsi;
dcm(2, 3) = -sinPhi * cosPsi + cosPhi * sinThe * sinPsi;

dcm(3, 1) = -sinThe;
dcm(3, 2) = sinPhi * cosThe;
dcm(3, 3) = cosPhi * cosThe;

end

