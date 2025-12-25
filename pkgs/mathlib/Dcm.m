classdef Dcm < matlab.mixin.SetGet
    % Dcm()
    % Dcm(dcm) or Dcm(R33)
    % Dcm(quat) or Dcm([q0, q1, q2 q3])
    % Dcm(ang1, ang2, ang3, seq="ZYX")
    % Dcm([n1, n2, n2], sigma)
    %

    properties
        data = eye(3)
    end

    methods
        function disp(self)
            disp(self.data)
        end
    end

    methods
        function obj = Dcm(varargin)

            if nargin == 1
                if isa(varargin{1}, 'Quat')
                    obj.FromQuat(varargin{1}.data);
                elseif isa(varargin{1}, 'Dcm')
                    obj.data = varargin{1}.data;
                elseif isnumeric(varargin{1})
                    if numel(varargin{1}, 4) % 四元数
                        obj.FromQuat(varargin{1});
                    elseif isequal(size(varargin{1}),[3 3]) % 方向余弦
                        obj.data = varargin{1};
                    end
                else
                end

             
            end

            function outputArg = method1(obj,inputArg)
                %METHOD1 此处显示有关此方法的摘要
                %   此处显示详细说明
                outputArg = obj.Property1 + inputArg;
            end

        end
    end

        methods
            function FromQuat(self, q)
                arguments
                    self (1, 1) Dcm {}
                    q (1, 4)  {mustBeNumeric} = [1 0 0 0]
                end
                a = q(1); b = q2; c = q(3); d = q(4);
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
                R = eye(3);
                R(1, 1) = aa + bb - cc - dd;
                R(1, 2) = 2 * (bc - ad);
                R(1, 3) = 2 * (ac + bd);
                R(2, 1) = 2 * (bc + ad);
                R(2, 2) = aa - bb + cc - dd;
                R(2, 3) = 2 * (cd - ab);
                R(3, 1) = 2 * (bd - ac);
                R(3, 2) = 2 * (ab + cd);
                R(3, 3) = aa - bb - cc + dd;

                self.data = R;
            end

            function FromPhiThetaPsi(self, phi, theta, psi)
                % 从机体到地面的方向余弦
                cosphi = cos(phi);
                sinphi = sin(phi);
                costhe = cos(theta);
                sinthe = sin(theta);
                cospsi = cos(psi);
                sinpsi = sin(psi);

                R = eye(3);

                R(1, 1) = costhe * cospsi;
                R(1, 2) = -cosphi * sinpsi + sinphi * sinthe * cospsi;
                R(1, 3) = sinphi * sinpsi + cosphi * sinthe * cospsi;

                R(2, 1) = costhe * sinpsi;
                R(2, 2) = cosphi * cospsi + sinphi * sinthe * sinpsi;
                R(2, 3) = -sinphi * cospsi + cosphi * sinthe * sinpsi;

                R(3, 1) = -sinthe;
                R(3, 2) = sinphi * costhe;
                R(3, 3) = cosphi * costhe;

                self.data = R;
            end


            function FromEuler(self, eul, seq, usedeg)
                arguments
                    self (1, 1) Dcm {}
                    eul (1,:) {mustBeNumeric} = [0 0 0]
                    seq (1,:) char = 'ZYX'
                    usedeg (1, 1) logical = false
                end
                if usedeg
                    eul = eul * pi / 180;
                end
                n = min(length(eul), length(seq));
                R = eye(3);
                for i = 1 : n
                    R = sig2dcm(eul(i), seq(i)) * R;
                end
                self.data = R;
            end
        end
    end

    function r = sig2dcm(t, k)
    s = sin(t);
    c = cos(t);
    switch k
        case {'x','X'}
            r = [1, 0, 0; ...
                0, c, s; ...
                0, -s, c];
        case {'y','Y'}
            r = [c, 0, -s; ...
                0, 1, 0; ...
                s, 0, c];
        case {'z','Z'}
            r = [c, s, 0; ...
                -s, c, 0; ...
                0, 0, 1];
    end

    end