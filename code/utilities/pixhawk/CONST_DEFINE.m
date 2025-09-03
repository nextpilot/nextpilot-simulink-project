function CONST_DEFINE(name, value)


const = Simulink.Parameter(value);
const.CoderInfo.StorageClass = 'Custom';
const.CoderInfo.CustomStorageClass = 'Const';

assignin('caller', name, const);