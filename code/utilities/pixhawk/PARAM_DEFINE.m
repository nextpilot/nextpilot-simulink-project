function varargout = PARAM_DEFINE(name, value, varargin)
% PARAM_DEFINE(value, type, min, max, unit, desc)
p = inputParser;
% p.addOptional('type', class(value), @(x)isempty(x, {}))

obj = Simulink.Parameter(value);


if nargout == 0
    assignin('caller', name, obj);
else
    varargout{1} = obj;
end