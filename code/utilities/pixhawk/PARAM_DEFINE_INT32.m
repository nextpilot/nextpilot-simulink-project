function PARAM_DEFINE_INT32(name, value)

[~, sobj] = nextpilot_get_sldd();

if ~isempty(sobj)
    if value > intmax('int32')
        param = Simulink.Parameter(uint32(value));
    else
        param = Simulink.Parameter(int32(value));
    end
    param.CoderInfo.StorageClass = 'Custom';
    param.CoderInfo.CustomStorageClass = 'Struct';
    param.CoderInfo.Identifier = '';
    param.CoderInfo.Alignment = -1;
    % param.CoderInfo.CustomAttributes.StructName = '';
    assignin(sobj, name, param);
end