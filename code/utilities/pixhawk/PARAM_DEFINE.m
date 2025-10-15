function varargout = PARAM_DEFINE(varargin)
%
% param = PARAM_DEFINE(name, value), save param to sldd
% param = PARAM_DEFINE(value), return param to caller
%

if nargin == 0
    name   = "";
    value  = 0;
    option = [];
elseif nargin == 1
    name   = "";
    value  = varargin{1};
    option = [];
elseif nargin >= 1
    if ischar(varargin{1}) || isstring(varargin{1})
        name   = varargin{1};        
        value  = varargin{2};        
        option = varargin{3:end};
    else
        name   = "";
        value  = varargin{1};
        option = varargin{2:end};
    end
end

% 创建param
param = Simulink.Parameter(value);
if ~isempty(option)
    set(param, option);
end

% 保存到sldd
if strlength(name) > 0
    [~, sobj] = nextpilot_project_dictionary();
    if ~isempty(sobj)
        assignin(sobj, name, param);
    end
end

% 返回param
if nargin >= 1
    varargout{1} = param;
end