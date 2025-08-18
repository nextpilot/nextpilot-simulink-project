function results = run_project_tests()

prj = slproject.getCurrentProject;
lst = {};
for k=1:length(prj.Files)
    if ~isempty(prj.Files(k).findLabel('Classification','Test'))
        lst = [{prj.Files(k).Path};lst]; %#okAGROW
    end
end
results = runtests(lst);