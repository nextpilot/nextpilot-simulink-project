function PARAM_DEFINE_FLOAT(name, value)

% persistent sobj
% 
% if isempty(sobj)
%     file = 'L400_datadict.sldd';
%     if exist(file,'file')
%         dobj=Simulink.data.dictionary.open(file);
%     else
%         dobj=Simulink.data.dictionary.create(file);
%     end
%     sobj = getSection(dobj,'Design Data');
% end
% 
% assignin(sobj, name, value);

assignin('caller', name, single(value));