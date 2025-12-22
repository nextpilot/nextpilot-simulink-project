function quat = dcm2quat(dcm)

% see also DCM2QUAT, ROTM2QUAT

quat = zeros(size(dcm,3), 4, 'like', dcm);

% Calculate all elements of symmetric K matrix
K11 = dcm(1,1,:) - dcm(2,2,:) - dcm(3,3,:);
K12 = dcm(1,2,:) + dcm(2,1,:);
K13 = dcm(1,3,:) + dcm(3,1,:);
K14 = dcm(3,2,:) - dcm(2,3,:);

K22 = dcm(2,2,:) - dcm(1,1,:) - dcm(3,3,:);
K23 = dcm(2,3,:) + dcm(3,2,:);
K24 = dcm(1,3,:) - dcm(3,1,:);

K33 = dcm(3,3,:) - dcm(1,1,:) - dcm(2,2,:);
K34 = dcm(2,1,:) - dcm(1,2,:);

K44 = dcm(1,1,:) + dcm(2,2,:) + dcm(3,3,:);

% Construct K matrix according to paper
K = [...
    K11,    K12,    K13,    K14;
    K12,    K22,    K23,    K24;
    K13,    K23,    K33,    K34;
    K14,    K24,    K34,    K44];

K = K ./ 3;

% For each input rotation matrix, calculate the corresponding eigenvalues
% and eigenvectors. The eigenvector corresponding to the largest eigenvalue
% is the unit quaternion representing the same rotation.
for i = 1:size(dcm,3)
    [eigVec,eigVal] = eig(K(:,:,i),'vector');
    [~,maxIdx] = max(real(eigVal));
    quat(i,:) = real([eigVec(4,maxIdx) -eigVec(1,maxIdx) -eigVec(2,maxIdx) -eigVec(3,maxIdx)]);

    % By convention, always keep scalar quaternion element positive.
    % Note that this does not change the rotation that is represented
    % by the unit quaternion, since q and -q denote the same rotation.
    if quat(i,1) < 0
        quat(i,:) = -quat(i,:);
    end    
end

function q = dcm2quat_trace(dcm)
% 根据trace(dcm)的计算q

for i = size(dcm,3) : -1 : 1
    q(i,4) =  0;
    tr = trace(dcm(:,:,i));
    if (tr > 0)
        sqtrp1 = sqrt( tr + 1.0 );
        q(i,1) = 0.5*sqtrp1;
        q(i,2) = (dcm(2, 3, i) - dcm(3, 2, i))/(2.0*sqtrp1);
        q(i,3) = (dcm(3, 1, i) - dcm(1, 3, i))/(2.0*sqtrp1);
        q(i,4) = (dcm(1, 2, i) - dcm(2, 1, i))/(2.0*sqtrp1);
    else
        d = diag(dcm(:,:,i));
        if ((d(2) > d(1)) && (d(2) > d(3)))
            % max value at dcm(2,2,i)
            sqdip1 = sqrt(d(2) - d(1) - d(3) + 1.0 );
            q(i,3) = 0.5*sqdip1;
            if ( sqdip1 ~= 0 )
                sqdip1 = 0.5/sqdip1;
            end
            q(i,1) = (dcm(3, 1, i) - dcm(1, 3, i))*sqdip1;
            q(i,2) = (dcm(1, 2, i) + dcm(2, 1, i))*sqdip1;
            q(i,4) = (dcm(2, 3, i) + dcm(3, 2, i))*sqdip1;
        elseif (d(3) > d(1))
            % max value at dcm(3,3,i)
            sqdip1 = sqrt(d(3) - d(1) - d(2) + 1.0 );
            q(i,4) = 0.5*sqdip1;
            if ( sqdip1 ~= 0 )
                sqdip1 = 0.5/sqdip1;
            end
            q(i,1) = (dcm(1, 2, i) - dcm(2, 1, i))*sqdip1;
            q(i,2) = (dcm(3, 1, i) + dcm(1, 3, i))*sqdip1;
            q(i,3) = (dcm(2, 3, i) + dcm(3, 2, i))*sqdip1;
        else
            % max value at dcm(1,1,i)
            sqdip1 = sqrt(d(1) - d(2) - d(3) + 1.0 );
            q(i,2) = 0.5*sqdip1;
            if ( sqdip1 ~= 0 )
                sqdip1 = 0.5/sqdip1;
            end
            q(i,1) = (dcm(2, 3, i) - dcm(3, 2, i))*sqdip1;
            q(i,3) = (dcm(1, 2, i) + dcm(2, 1, i))*sqdip1;
            q(i,4) = (dcm(3, 1, i) + dcm(1, 3, i))*sqdip1;
        end
    end
end

