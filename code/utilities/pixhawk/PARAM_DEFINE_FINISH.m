function PARAM_DEFINE_FINISH()
[~, dobj] = nextpilot_get_sldd();

if ~isempty(sobj)
    dobj.saveChanges();
    dobj.close();
end