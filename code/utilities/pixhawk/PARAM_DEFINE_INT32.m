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
    param = Simulink.Parameter(uint32(value));
else
    param = Simulink.Parameter(int32(value));
end

assignin('caller', name, param);