function CONST_DEFINE_DOUBLE(name, value)


const = Simulink.Parameter(double(value));
const.CoderInfo.StorageClass = 'Custom';
const.CoderInfo.CustomStorageClass = 'Const';

assignin('caller', name, const);