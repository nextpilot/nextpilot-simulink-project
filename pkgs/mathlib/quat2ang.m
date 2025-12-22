function ang = quat2ang(quat, seq)
%
%
%
%
% see also QUAT2ANGLE, QUAT2EUL

arguments
    quat 
    seq (1,:) {} = 'ZYX'
end

if isvector(quat)
    quat = quat(:)' / norm(quat);
elseif  ismatrix(quat)
    quat = bsxfun(@times, quat, 1./sqrt(sum(quat.^2,2)));
end


%columnize quaternion parts
w = quat(:, 1);
x = quat(:, 2);
y = quat(:, 3);
z = quat(:, 4);
the1 = ones(1, 'like', w); % single(1) or double(1) as appropriate
the2 = 2*the1; % single(2) or double(2) as appropriate
a = zeros(size(w), 'like', w);
b = zeros(size(x), 'like', x);
c = zeros(size(y), 'like', y);

found = true;
switch upper(seq)
    case 'YZY'
        tmp = w.^2.*the2 - the1 + y.^2.*the2;
        tmp(tmp > the1) = the1;
        tmp(tmp < -the1) = -the1;
        for ii=1:numel(tmp)
            if (tmp(ii) < 0) && abs(tmp(ii) + 1) < 10*eps(the1)
                a(ii) = 2.*atan2(x(ii),z(ii));
                c(ii) = 0;
                b(ii) = cast(pi, 'like', tmp);
            elseif (tmp(ii) > 0) && abs(tmp(ii) - 1) < 10*eps(the1)
                a(ii) = 2.*atan2(y(ii),w(ii));
                c(ii) = 0;
                b(ii) = cast(0, 'like', tmp);
            else
                a(ii) = atan2((w(ii).*x(ii).*the2 + y(ii).*z(ii).*the2),(w(ii).*z(ii).*the2 - x(ii).*y(ii).*the2));
                c(ii) = -atan2((w(ii).*x(ii).*the2 - y(ii).*z(ii).*the2),(w(ii).*z(ii).*the2 + x(ii).*y(ii).*the2));
                b(ii) = acos(tmp(ii));
            end
        end
    case 'YXY'
        tmp = w.^2.*the2 - the1 + y.^2.*the2;
        tmp(tmp > the1) = the1;
        tmp(tmp < -the1) = -the1;
        for ii=1:numel(tmp)
            if (tmp(ii) < 0) && abs(tmp(ii) + 1) < 10*eps(the1)
                a(ii) = -2.*atan2(z(ii),x(ii));
                c(ii) = 0;
                b(ii) = cast(pi, 'like', tmp);
            elseif (tmp(ii) > 0) && abs(tmp(ii) - 1) < 10*eps(the1)
                a(ii) = 2.*atan2(y(ii),w(ii));
                c(ii) = 0;
                b(ii) = cast(0, 'like', tmp);
            else
                a(ii) = -atan2((w(ii).*z(ii).*the2 - x(ii).*y(ii).*the2),(w(ii).*x(ii).*the2 + y(ii).*z(ii).*the2));
                c(ii) = atan2((w(ii).*z(ii).*the2 + x(ii).*y(ii).*the2),(w(ii).*x(ii).*the2 - y(ii).*z(ii).*the2));
                b(ii) = acos(tmp(ii));
            end
        end
    case 'ZYZ'
        tmp = w.^2.*the2 - the1 + z.^2.*the2;
        tmp(tmp > the1) = the1;
        tmp(tmp < -the1) = -the1;
        for ii=1:numel(tmp)
            if (tmp(ii) < 0) && abs(tmp(ii) + 1) < 10*eps(the1)
                a(ii) = -2.*atan2(x(ii),y(ii));
                c(ii) = 0;
                b(ii) = cast(pi, 'like', tmp);
            elseif (tmp(ii) > 0) && abs(tmp(ii) - 1) < 10*eps(the1)
                a(ii) = 2.*atan2(z(ii),w(ii));
                c(ii) = 0;
                b(ii) = cast(0, 'like', tmp);
            else
                a(ii) = -atan2((w(ii).*x(ii).*the2 - y(ii).*z(ii).*the2),(w(ii).*y(ii).*the2 + x(ii).*z(ii).*the2));
                c(ii) = atan2((w(ii).*x(ii).*the2 + y(ii).*z(ii).*the2),(w(ii).*y(ii).*the2 - x(ii).*z(ii).*the2));
                b(ii) = acos(tmp(ii));
            end
        end
    case 'ZXZ'
        tmp = w.^2.*the2 - the1 + z.^2.*the2;
        tmp(tmp > the1) = the1;
        tmp(tmp < -the1) = -the1;
        for ii=1:numel(tmp)
            if (tmp(ii) < 0) && abs(tmp(ii) + 1) < 10*eps(the1)
                a(ii) = 2.*atan2(y(ii),x(ii));
                c(ii) = 0;
                b(ii) = cast(pi, 'like', tmp);
            elseif (tmp(ii) > 0) && abs(tmp(ii) - 1) < 10*eps(the1)
                a(ii) = 2.*atan2(z(ii),w(ii));
                c(ii) = 0;
                b(ii) = cast(0, 'like', tmp);
            else
                a(ii) = atan2((w(ii).*y(ii).*the2 + x(ii).*z(ii).*the2),(w(ii).*x(ii).*the2 - y(ii).*z(ii).*the2));
                c(ii) = -atan2((w(ii).*y(ii).*the2 - x(ii).*z(ii).*the2),(w(ii).*x(ii).*the2 + y(ii).*z(ii).*the2));
                b(ii) = acos(tmp(ii));
            end
        end
    case 'XYX'
        tmp = w.^2.*the2 - the1 + x.^2.*the2;
        tmp(tmp > the1) = the1;
        tmp(tmp < -the1) = -the1;
        for ii=1:numel(tmp)
            if (tmp(ii) < 0) && abs(tmp(ii) + 1) < 10*eps(the1)
                a(ii) = 2.*atan2(z(ii),y(ii));
                c(ii) = 0;
                b(ii) = cast(pi, 'like', tmp);
            elseif (tmp(ii) > 0) && abs(tmp(ii) - 1) < 10*eps(the1)
                a(ii) = 2.*atan2(x(ii),w(ii));
                c(ii) = 0;
                b(ii) = cast(0, 'like', tmp);
            else
                a(ii) = atan2((w(ii).*z(ii).*the2 + x(ii).*y(ii).*the2),(w(ii).*y(ii).*the2 - x(ii).*z(ii).*the2));
                c(ii) = -atan2((w(ii).*z(ii).*the2 - x(ii).*y(ii).*the2),(w(ii).*y(ii).*the2 + x(ii).*z(ii).*the2));
                b(ii) = acos(tmp(ii));
            end
        end
    case 'XZX'
        tmp = w.^2.*the2 - the1 + x.^2.*the2;
        tmp(tmp > the1) = the1;
        tmp(tmp < -the1) = -the1;
        for ii=1:numel(tmp)
            if (tmp(ii) < 0) && abs(tmp(ii) + 1) < 10*eps(the1)
                a(ii) = -2.*atan2(y(ii),z(ii));
                c(ii) = 0;
                b(ii) = cast(pi, 'like', tmp);
            elseif (tmp(ii) > 0) && abs(tmp(ii) - 1) < 10*eps(the1)
                a(ii) = 2.*atan2(x(ii),w(ii));
                c(ii) = 0;
                b(ii) = cast(0, 'like', tmp);
            else
                a(ii) = -atan2((w(ii).*y(ii).*the2 - x(ii).*z(ii).*the2),(w(ii).*z(ii).*the2 + x(ii).*y(ii).*the2));
                c(ii) = atan2((w(ii).*y(ii).*the2 + x(ii).*z(ii).*the2),(w(ii).*z(ii).*the2 - x(ii).*y(ii).*the2));
                b(ii) = acos(tmp(ii));
            end
        end
    case 'XYZ'
        tmp = w.*y.*the2 + x.*z.*the2;
        tmp(tmp > the1) = the1;
        tmp(tmp < -the1) = -the1;
        for ii=1:numel(tmp)
            if (tmp(ii) > 0) && abs(tmp(ii) - 1) < 10*eps(the1)
                a(ii) = 2.*atan2(x(ii),w(ii));
                c(ii) = 0;
                b(ii) = cast(0.5.*pi, 'like', tmp);
            elseif (tmp(ii) < 0) && abs(tmp(ii) + 1) < 10*eps(the1)
                a(ii) = 2.*atan2(x(ii),w(ii));
                c(ii) = 0;
                b(ii) = cast(-0.5.*pi, 'like', tmp);
            else
                a(ii) = atan2((w(ii).*x(ii).*the2 - y(ii).*z(ii).*the2),(w(ii).^2.*the2 - the1 + z(ii).^2.*the2));
                c(ii) = atan2((w(ii).*z(ii).*the2 - x(ii).*y(ii).*the2),(w(ii).^2.*the2 - the1 + x(ii).^2.*the2));
                b(ii) = asin(tmp(ii));
            end
        end
    case 'YZX'
        tmp = w.*z.*the2 + x.*y.*the2;
        tmp(tmp > the1) = the1;
        tmp(tmp < -the1) = -the1;
        for ii=1:numel(tmp)
            if (tmp(ii) > 0) && abs(tmp(ii) - 1) < 10*eps(the1)
                a(ii) = 2.*atan2(x(ii),w(ii));
                c(ii) = 0;
                b(ii) = cast(0.5.*pi, 'like', tmp);
            elseif (tmp(ii) < 0) && abs(tmp(ii) + 1) < 10*eps(the1)
                a(ii) = -2.*atan2(x(ii),w(ii));
                c(ii) = 0;
                b(ii) = cast(-0.5.*pi, 'like', tmp);
            else
                a(ii) = atan2((w(ii).*y(ii).*the2 - x(ii).*z(ii).*the2),(w(ii).^2.*the2 - the1 + x(ii).^2.*the2));
                c(ii) = atan2((w(ii).*x(ii).*the2 - y(ii).*z(ii).*the2),(w(ii).^2.*the2 - the1 + y(ii).^2.*the2));
                b(ii) = asin(tmp(ii));
            end
        end
    case 'ZXY'
        tmp = w.*x.*the2 + y.*z.*the2;
        tmp(tmp > the1) = the1;
        tmp(tmp < -the1) = -the1;
        for ii=1:numel(tmp)
            if (tmp(ii) > 0) && abs(tmp(ii) - 1) < 10*eps(the1)
                a(ii) = 2.*atan2(y(ii),w(ii));
                c(ii) = 0;
                b(ii) = cast(0.5.*pi, 'like', tmp);
            elseif (tmp(ii) < 0) && abs(tmp(ii) + 1) < 10*eps(the1)
                a(ii) = -2.*atan2(y(ii),w(ii));
                c(ii) = 0;
                b(ii) = cast(-0.5.*pi, 'like', tmp);
            else
                a(ii) = atan2((w(ii).*z(ii).*the2 - x(ii).*y(ii).*the2),(w(ii).^2.*the2 - the1 + y(ii).^2.*the2));
                c(ii) = atan2((w(ii).*y(ii).*the2 - x(ii).*z(ii).*the2),(w(ii).^2.*the2 - the1 + z(ii).^2.*the2));
                b(ii) = asin(tmp(ii));
            end
        end
    case 'XZY'
        tmp = x.*y.*the2 - w.*z.*the2;
        tmp(tmp > the1) = the1;
        tmp(tmp < -the1) = -the1;
        for ii=1:numel(tmp)
            if (tmp(ii) < 0) && abs(tmp(ii) + 1) < 10*eps(the1)
                a(ii) = 2.*atan2(x(ii),w(ii));
                c(ii) = 0;
                b(ii) = cast(0.5.*pi, 'like', tmp);
            elseif (tmp(ii) > 0) && abs(tmp(ii) - 1) < 10*eps(the1)
                a(ii) = 2.*atan2(x(ii),w(ii));
                c(ii) = 0;
                b(ii) = cast(-0.5.*pi, 'like', tmp);
            else
                a(ii) = atan2((w(ii).*x(ii).*the2 + y(ii).*z(ii).*the2),(w(ii).^2.*the2 - the1 + y(ii).^2.*the2));
                c(ii) = atan2((w(ii).*y(ii).*the2 + x(ii).*z(ii).*the2),(w(ii).^2.*the2 - the1 + x(ii).^2.*the2));
                b(ii) = -asin(tmp(ii));
            end
        end
    case 'ZYX'
        tmp = x.*z.*the2 - w.*y.*the2;
        tmp(tmp > the1) = the1;
        tmp(tmp < -the1) = -the1;
        for ii=1:numel(tmp)
            if (tmp(ii) < 0) && abs(tmp(ii) + 1) < 10*eps(the1)
                a(ii) = -2.*atan2(x(ii),w(ii));
                c(ii) = 0;
                b(ii) = cast(0.5.*pi, 'like', tmp);
            elseif (tmp(ii) > 0) && abs(tmp(ii) - 1) < 10*eps(the1)
                a(ii) = 2.*atan2(x(ii),w(ii));
                c(ii) = 0;
                b(ii) = cast(-0.5.*pi, 'like', tmp);
            else
                a(ii) = atan2((w(ii).*z(ii).*the2 + x(ii).*y(ii).*the2),(w(ii).^2.*the2 - the1 + x(ii).^2.*the2));
                c(ii) = atan2((w(ii).*x(ii).*the2 + y(ii).*z(ii).*the2),(w(ii).^2.*the2 - the1 + z(ii).^2.*the2));
                b(ii) = -asin(tmp(ii));
            end
        end
    case 'YXZ'
        tmp = y.*z.*the2 - w.*x.*the2;
        tmp(tmp > the1) = the1;
        tmp(tmp < -the1) = -the1;
        for ii=1:numel(tmp)
            if (tmp(ii) < 0) && abs(tmp(ii) + 1) < 10*eps(the1)
                a(ii) = 2.*atan2(y(ii),w(ii));
                c(ii) = 0;
                b(ii) = cast(0.5.*pi, 'like', tmp);
            elseif (tmp(ii) > 0) && abs(tmp(ii) - 1) < 10*eps(the1)
                a(ii) = 2.*atan2(y(ii),w(ii));
                c(ii) = 0;
                b(ii) = cast(-0.5.*pi, 'like', tmp);
            else
                a(ii) = atan2((w(ii).*y(ii).*the2 + x(ii).*z(ii).*the2),(w(ii).^2.*the2 - the1 + z(ii).^2.*the2));
                c(ii) = atan2((w(ii).*z(ii).*the2 + x(ii).*y(ii).*the2),(w(ii).^2.*the2 - the1 + y(ii).^2.*the2));
                b(ii) = -asin(tmp(ii));
            end
        end
    otherwise
        found = false;
        a = zeros(size(w), 'like', w);
        b = zeros(size(w), 'like', w);
        c = zeros(size(w), 'like', w);
end

ang = [a, b, c];