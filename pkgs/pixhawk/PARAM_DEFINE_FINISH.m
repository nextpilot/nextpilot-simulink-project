function PARAM_DEFINE_FINISH()

dobj = nextpilot_project_dictionary();

if ~isempty(dobj)
    dobj.saveChanges();
    % dobj.close();
end