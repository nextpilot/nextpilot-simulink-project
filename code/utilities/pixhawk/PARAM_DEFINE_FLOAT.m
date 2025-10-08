function PARAM_DEFINE_FLOAT(name, value)

[~, sobj] = nextpilot_get_sldd();

if ~isempty(sobj)
    param = Simulink.Parameter(single(value));
    param.CoderInfo.StorageClass = 'Custom';
    param.CoderInfo.CustomStorageClass = 'Struct';
    param.CoderInfo.Identifier = '';
    param.CoderInfo.Alignment = -1;
    % param.CoderInfo.CustomAttributes.StructName = '';
    assignin(sobj, name, param);
end