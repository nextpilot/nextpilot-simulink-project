% Direction cosine matrix class
% The rotation between two coordinate frames is
% described by this class.

% This sets the transformation matrix from frame 2 to frame 1 where the rotation
% from frame 1 to frame 2 is described by a 3-2-1 intrinsic Tait-Bryan rotation sequatuence.

% dcm: body --> ned

function dcm = quat2dcm(quat)

dcm = single(zeros(3, 3));

a = quat(1);
b = quat(2);
c = quat(3);
d = quat(4);
aa = a * a;
ab = a * b;
ac = a * c;
ad = a * d;
bb = b * b;
bc = b * c;
bd = b * d;
cc = c * c;
cd = c * d;
dd = d * d;

dcm(1, 1) = single(aa + bb - cc - dd);
dcm(1, 2) = single(2 * (bc - ad));
dcm(1, 3) = single(2 * (ac + bd));
dcm(2, 1) = single(2 * (bc + ad));
dcm(2, 2) = single(aa - bb + cc - dd);
dcm(2, 3) = single(2 * (cd - ab));
dcm(3, 1) = single(2 * (bd - ac));
dcm(3, 2) = single(2 * (ab + cd));
dcm(3, 3) = single(aa - bb - cc + dd);

end

