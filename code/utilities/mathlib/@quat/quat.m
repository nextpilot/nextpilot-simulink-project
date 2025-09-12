classdef quat
    % quat()                         ����һ������Ԫ��[1 0 0 0]
    % quat(q)                        ʹ�����е���Ԫ����ʼ��
    % quat([q0, q1, q2, q3])         ʹ��������ʼ����Ԫ��
    % quat([n1, n2, n3], sigma)      ������[n1,n2,n3]��ת�ҽǶȴ�����Ԫ��
    % quat([ax, ay, az], [bx, by, bz]) �����ʸ��[ax,ay,az]��ת��[bx,by,bz]����Ԫ��
    % quat(dcm)                      ����DCM���󴴽���Ԫ��
    % quat(a1, a2, a3, ...,'xyz...') ���ݵ�����ת������Ԫ��
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
                % ʹ��ʸ����ʼ����Ԫ��
                % data = varargin{1};
                % leng = sqrt(dot(data, data));
                % if leng > eps
                %     data = data / leng;
                % end
                q.data = varargin{1};
            elseif nargin == 1 && isequal(size(varargin{1}),[3 3])
                % ����dcm����quat
            elseif nargin == 2 && numel(varargin{1}) == 3 && isscalar(varargin{2})
                % ������ת�ҽǴ�����Ԫ��
                % ������ n = [cos��1,cos��2,cos��3] ��ת�Ƕ� �ң��򹹳���Ԫ��
                % q = cos(��/2) + sin(��/2)*[cos��1*i + cos��2*j + cos��3*k]
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
                v = cross(a, b); % ��ת��
                s = dot(a, b);
                sigma = atan2(norm(v), s);
                q.real = cos(sigma/2);
                q.imag = v * sin(sigma/2);
            elseif ischar(varargin{end})
                act = varargin{end};
                tmp = cellfun(@(x)x(:), varargin(1:end-1), 'UniformOutput', false);
                ang = cat(1, tmp{:});
                if length(ang) ~= length(act)
                    warning('quat:FromAngle', '����ǶȺ�ת�᳤�Ȳ�һ��!');
                end
                n = min(length(ang), length(act));
                for i = 1 : n
                    r = sig2quat(ang(i), act(i));
                    q = q * r;
                end
            else
                error('quat:InputArgs', '�������������Ҫ��!');
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