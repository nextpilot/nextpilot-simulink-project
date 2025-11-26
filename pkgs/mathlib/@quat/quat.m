classdef quat
    % quat()                         创建一个空四元数[1 0 0 0]
    % quat(q)                        使用现有的四元数初始化
    % quat([q0, q1, q2, q3])         使用向量初始化四元数
    % quat([n1, n2, n3], sigma)      绕着轴[n1,n2,n3]旋转σ角度创建四元数
    % quat([ax, ay, az], [bx, by, bz]) 计算从矢量[ax,ay,az]旋转到[bx,by,bz]的四元数
    % quat(dcm)                      根据DCM矩阵创建四元数
    % quat(a1, a2, a3, ...,'xyz...') 根据单轴旋转创建四元数
    %

    properties
        data = [1; 0; 0; 0]
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

        function q = set.data(q, v)
            q.data = v(:);
        end

        function v = get.real(q)
            v = q.data(1);
        end

        function q = set.real(q, v)
            q.data(1) = v;
        end

        function v = get.imag(q)
            v = q.data(2:4);
        end

        function q = set.imag(q, v)
            q.data(2:4) = v;
        end

        function v = get.q0(q)
            v = q.real;
        end

        function q = set.q0(q,v)
            q.real = v;
        end

        function v = get.q1(q)
            v = q.imag(1);
        end

        function q = set.q1(q,v)
            q.imag(1) = v;
        end

        function v = get.q2(q)
            v = q.imag(2);
        end

        function q = set.q2(q,v)
            q.imag(2) = v;
        end

        function v = get.q3(q)
            v = q.imag(3);
        end

        function q = set.q3(q,v)
            q.imag(3) = v;
        end

    end
    methods
        function q = quat(varargin)
            if nargin == 0
                % do nothing
            elseif isa(varargin{1},'quat')
                q = varargin{1};
            elseif nargin == 1 && isscalar(varargin{1})
                q.real = varargin{1};
                q.imag = [0 0 0];
            elseif nargin == 1 && numel(varargin{1}) == 3
                q.real = 0;
                q.imag = varargin{1};
            elseif nargin == 1 && numel(varargin{1}) == 4
                % 使用矢量初始化四元数
                % data = varargin{1};
                % leng = sqrt(dot(data, data));
                % if leng > eps
                %     data = data / leng;
                % end
                q.data = varargin{1};
            elseif nargin == 1 && isequal(size(varargin{1}),[3 3])
                % 根据dcm创建quat
            elseif nargin == 2 && numel(varargin{1}) == 3 && isscalar(varargin{2})
                % 绕轴旋转σ角创建四元数
                % 绕着轴 n = [cosβ1,cosβ2,cosβ3] 旋转角度 σ，则构成四元素
                % q = cos(σ/2) + sin(σ/2)*[cosβ1*i + cosβ2*j + cosβ3*k]
                vect = varargin{1}(:)';
                leng = sqrt(dot(vect, vect));
                if leng > eps
                    vect = vect / leng;
                end
                sigma = varargin{2};
                q.data = [cos(sigma/2) sin(sigma/2) * vect];
            elseif nargin == 2 && numel(varargin{1}) == 3 && numel(varargin{2}) == 3
                a = varargin{1} / norm(varargin{1});
                b = varargin{2} / norm(varargin{2});
                v = cross(a, b); % 旋转轴
                s = dot(a, b);
                sigma = atan2(norm(v), s);
                q.real = cos(sigma/2);
                q.imag = v * sin(sigma/2);
            elseif ischar(varargin{end})
                act = varargin{end};
                tmp = cellfun(@(x)x(:), varargin(1:end-1), 'UniformOutput', false);
                ang = cat(1, tmp{:});
                if length(ang) ~= length(act)
                    warning('quat:FromAngle', '输入角度和转轴长度不一致!');
                end
                n = min(length(ang), length(act));
                for i = 1 : n
                    r = sig2quat(ang(i), act(i));
                    q = q * r;
                end
            else
                error('quat:InputArgs', '输入参数不符合要求!');
            end
        end
    end

    methods (Static)

        %q = setelem(varargin)
        %q = setdcm(dcm)
        %q = setvect(a,b)
        %q = setaxis(varargin)
        %q = seteuler(varargin)

        function help()
            disp('  quat()')
            disp('  quat(q)')
            disp('  quat([q0,q1,q2,q3])')
            disp('  quat(q0,[q1,q2,q3]')
        end
    end
end



function q = sig2quat(t, k)
s = sin(t/2);
c = cos(t/2);

switch k
    case {'x','X'}
        q = [c s 0 0];
    case {'y','Y'}
        q = [c 0 s 0];
    case {'z','Z'}
        q = [c 0 0 s];
end
end