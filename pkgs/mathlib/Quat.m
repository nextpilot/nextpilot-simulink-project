classdef Quat < hgsetget
    %QUAT 此处显示有关此类的摘要
    %   此处显示详细说明

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

        function set.data(self, v)            
            self.data = v(:);
        end

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
            v = self.real;
        end

        function set.q0(self,v)
            self.real = v;
        end

        function v = get.q1(self)
            v = self.imag(1);
        end

        function set.q1(self, v)
            self.imag(1) = v;
        end

        function v = get.q2(self)
            v = self.imag(2);
        end

        function set.q2(self,v)
            self.imag(2) = v;
        end

        function v = get.q3(self)
            v = self.imag(3);
        end

        function set.q3(q, self)
            q.imag(3) = self;
        end

    end

    methods
        function obj = quat(varargin)
            % quat([q0, q1, q2, q3])
            % quat(q0, q1, q2, q3)
            if nargin == 1
            end
            %QUAT 构造此类的实例
            %   此处显示详细说明
            obj.Property1 = inputArg1 + inputArg2;
        end

        function outputArg = method1(obj,inputArg)
            %METHOD1 此处显示有关此方法的摘要
            %   此处显示详细说明
            outputArg = obj.Property1 + inputArg;
        end

        function FromDcm(self, dcm)
       
            t = trace(R);
            if (t > (0))
                t = sqrt((1) + t);
                self.q0 = (0.5) * t;
                t = (0.5) / t;
                self.q1 = (R(2,1) - R(1,2)) * t;
                self.q2 = (R(0,2) - R(2,0)) * t;
                self.q3 = (R(1,0) - R(0,1)) * t;
            elseif (R(0,0) > R(1,1) && R(0,0) > R(2,2)) {
                t = sqrt((1) + R(0,0) - R(1,1) - R(2,2));
                self.q1 = (0.5) * t;
                t = (0.5) / t;
                self.q0 = (R(2,1) - R(1,2)) * t;
                self.q2 = (R(1,0) + R(0,1)) * t;
                self.q3 = (R(0,2) + R(2,0)) * t;
            elseif (R(1,1) > R(2,2)) {
                t = sqrt((1) - R(0,0) + R(1,1) - R(2,2));
                self.q2 = (0.5) * t;
                t = (0.5) / t;
                self.q0 = (R(0,2) - R(2,0)) * t;
                self.q1 = (R(1,0) + R(0,1)) * t;
                self.q3 = (R(2,1) + R(1,2)) * t;
            else
                t = sqrt((1) - R(0,0) - R(1,1) + R(2,2));
                self.q3 = (0.5) * t;
                t = (0.5) / t;
                self.q0 = (R(1,0) - R(0,1)) * t;
                self.q1 = (R(0,2) + R(2,0)) * t;
                self.q2 = (R(2,1) + R(1,2)) * t;
            end
        end
    end
end

