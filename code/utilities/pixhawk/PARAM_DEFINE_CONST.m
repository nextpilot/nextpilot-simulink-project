function PARAM_DEFINE_CONST(name, value)

[~, sobj] = nextpilot_get_sldd();

if ~isempty(sobj)
    const = Simulink.Parameter(value);
    const.CoderInfo.StorageClass = 'Custom';
    const.CoderInfo.CustomStorageClass = 'Const';
    assignin(sobj, name, const);
end