function [dobj, sobj] = nextpilot_project_dictionary()

persistent g_dict_obj g_sect_obj

if isempty(g_sect_obj) || isempty(g_dict_obj)
    file = 'nextpilot_data_dictionary.sldd';

    if exist(file,'file')
        g_dict_obj = Simulink.data.dictionary.open(file);
    else
        g_dict_obj = Simulink.data.dictionary.create(file);
    end
    g_sect_obj = getSection(g_dict_obj,'Design Data');
end

dobj = g_dict_obj;
sobj = g_sect_obj;