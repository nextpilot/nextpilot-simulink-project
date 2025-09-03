function CONST_DEFINE_FLOAT(name, value)


const = Simulink.Parameter(single(value));
const.CoderInfo.StorageClass = 'Custom';
const.CoderInfo.CustomStorageClass = 'Const';

assignin('caller', name, const);