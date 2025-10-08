function PARAM_DEFINE(name, value, varargin)

[~, sobj] = nextpilot_get_sldd();

if ~isempty(sobj)
    param = Simulink.Parameter(value);
    set(param, varargin{:});
    assignin(sobj, name, param);
end