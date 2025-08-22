function q = eul2quat(phi,theta,psi)

cosPhi_2 = cos(phi/2);
cosTheta_2 = cos(theta/2);
cosPsi_2 = cos(psi/2);
sinPhi_2 = sin(phi/2);
sinTheta_2 = sin(theta/2);
sinPsi_2 = sin(psi/2);

q0 = cosPhi_2 * cosTheta_2 * cosPsi_2 + sinPhi_2 * sinTheta_2 * sinPsi_2;
q1 = sinPhi_2 * cosTheta_2 * cosPsi_2 - cosPhi_2 * sinTheta_2 * sinPsi_2;
q2 = cosPhi_2 * sinTheta_2 * cosPsi_2 + sinPhi_2 * cosTheta_2 * sinPsi_2;
q3 = cosPhi_2 * cosTheta_2 * sinPsi_2 - sinPhi_2 * sinTheta_2 * cosPsi_2;

q = [q0; q1; q2; q3];

end

