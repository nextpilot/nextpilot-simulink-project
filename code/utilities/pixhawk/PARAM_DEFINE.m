function PARAM_DEFINE(name, value, varargin)

[~, sobj] = nextpilot_project_dictionary();

if ~isempty(sobj)
    param = Simulink.Parameter(value);
    set(param, varargin{:});
    assignin(sobj, name, param);
end