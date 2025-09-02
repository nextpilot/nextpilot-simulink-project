function PARAM_DEFINE_FLOAT(name, value)

% persistent sobj
% 
% if isempty(sobj)
%     file = 'nextpilot_datadict.sldd';
%     if exist(file,'file')
%         dobj=Simulink.data.dictionary.open(file);
%     else
%         dobj=Simulink.data.dictionary.create(file);
%     end
%     sobj = getSection(dobj,'Design Data');
% end
% 
% assignin(sobj, name, value);

param = Simulink.Parameter(single(value));
param.CoderInfo.StorageClass = 'Custom';
param.CoderInfo.CustomStorageClass = 'Const';

assignin('caller', name, param);