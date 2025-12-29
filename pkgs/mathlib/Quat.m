classdef Quat < handle
    properties
        data = [1 0 0 0];
    end

    properties (Dependent)
        real
        imag
        q0
        q1
        q2
        q3
    end

    methods

        % function set.data(self, v)
        %     self.data = v(:);
        % end

        function v = get.real(self)
            v = self.data(1);
        end

        function set.real(self, v)
            self.data(1) = v;
        end

        function v = get.imag(self)
            v = self.data(2:4);
        end

        function set.imag(self, v)
            self.data(2:4) = v;
        end

        function v = get.q0(self)
            v = self.data(1);
        end

        function set.q0(self,v)
            self.data(1) = v;
        end

        function v = get.q1(self)
            v = self.data(2);
        end

        function set.q1(self, v)
            self.data(2) = v;
        end

        function v = get.q2(self)
            v = self.data(3);
        end

        function set.q2(self,v)
            self.data(3) = v;
        end

        function v = get.q3(self)
            v = self.data(4);
        end

        function set.q3(q, self)
            q.data(4) = self;
        end

    end

    methods
        function obj = quat(varargin)
            % quat([q0, q1, q2, q3])
            % quat(q0, q1, q2, q3)
            if nargin == 1
            end
        end

        function FromDcm(self, R)
            t = trace(R);
            if (t > (0))
                t = sqrt(1 + t);
                self.q0 = 0.5 * t;
                t = 0.5 / t;
                self.q1 = (R(3,2) - R(2,3)) * t;
                self.q2 = (R(1,3) - R(3,1)) * t;
                self.q3 = (R(2,1) - R(1,2)) * t;
            elseif (R(1,1) > R(2,2) && R(1,1) > R(3,3))
                t = sqrt(1 + R(1,1) - R(2,2) - R(3,3));
                self.q1 = 0.5 * t;
                t = 0.5 / t;
                self.q0 = (R(3,2) - R(2,3)) * t;
                self.q2 = (R(2,1) + R(1,2)) * t;
                self.q3 = (R(1,3) + R(3,1)) * t;
            elseif (R(2,2) > R(3,3))
                t = sqrt(1 - R(1,1) + R(2,2) - R(3,3));
                self.q2 = 0.5 * t;
                t = 0.5 / t;
                self.q0 = (R(1,3) - R(3,1)) * t;
                self.q1 = (R(2,1) + R(1,2)) * t;
                self.q3 = (R(3,2) + R(2,3)) * t;
            else
                t = sqrt(1 - R(1,1) - R(2,2) + R(3,3));
                self.q3 = 0.5 * t;
                t = 0.5 / t;
                self.q0 = (R(2,1) - R(1,2)) * t;
                self.q1 = (R(1,3) + R(3,1)) * t;
                self.q2 = (R(3,2) + R(2,3)) * t;
            end
        end

        function FromEluer(self, phi, theta, psi)
            cosphi_2 = cos(phi / 2);
            costheta_2 = cos(theta / 2);
            cospsi_2 = cos(psi / 2);
            sinphi_2 = sin(phi / 2);
            sintheta_2 = sin(theta / 2);
            sinpsi_2 = sin(psi / 2);
            self.q0 = cosphi_2 * costheta_2 * cospsi_2 + sinphi_2 * sintheta_2 * sinpsi_2;
            self.q1 = sinphi_2 * costheta_2 * cospsi_2 - cosphi_2 * sintheta_2 * sinpsi_2;
            self.q2 = cosphi_2 * sintheta_2 * cospsi_2 + sinphi_2 * costheta_2 * sinpsi_2;
            self.q3 = cosphi_2 * costheta_2 * sinpsi_2 - sinphi_2 * sintheta_2 * cospsi_2;
        end

        function FromAxisAngle(self, axis, angle)
            axis = axis ./ sqrt(dot(axis, axis));
            if (angle < 1e-10)
                self.q0 = 1;
                self.q1 = 0;
                self.q2 = 0;
                self.q3 = 0;
            else
                magnitude = sin(angle / (2));
                self.q0 = cos(angle / (2));
                self.q1 = axis(1) * magnitude;
                self.q2 = axis(2) * magnitude;
                self.q3 = axis(3) * magnitude;
            end
        end

        function FromTwoVectors(self, src, dst)
            cr = cros(src, dst);
            dt = dot(src, dst);

            if norm(cr) < eps && dt < 0
                cr = abs(abs);
                if (cr(1) < cr(2))
                    if (cr(1) < cr(3))
                        cr = [1, 0, 0];
                    else
                        cr = [0, 0, 1];
                    end
                else
                    if (cr(2) < cr(3))
                        cr = [0, 1, 0];
                    else
                        cr = [0, 0, 1];
                    end
                end
                self.q0 = 0;
                cr = cross(src, cr);
            else
                self.q0 = dt + sqrt(dot(src, src) * dot(dst, dst));
            end

            self.q1 = cr(1);
            self.q2 = cr(2);
            self.q3 = cr(3);
            q.Normalize();
        end

        function self = Normalize(self)
            self.data = self.data ./ sqrt(dot(self.data, self.data));
        end

        function plus(self, q)
        end

        function minus(self, q)
        end

        function uminus(self)
        end

        function uplus(self)
        end

        function disp(self)
            disp(self.data)
        end
    end
end

