function PARAM_DEFINE_FINISH()

[~, dobj] = nextpilot_project_dictionary();

if ~isempty(sobj)
    dobj.saveChanges();
    dobj.close();
end