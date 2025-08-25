function PARAM_DEFINE_INT32(name, value)

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

if value > intmax('int32')
    assignin('caller', name, uint32(value));
else
    assignin('caller', name, int32(value));
end