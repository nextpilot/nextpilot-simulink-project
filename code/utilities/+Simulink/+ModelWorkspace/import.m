function import(model, dfile)
arguments
    model (1,:) char {mustBeTextScalar} = bdroot
    dfile (1,:) char {mustBeTextScalar} = [model, '_model_workspace.mat']
end

if isempty(model)
    return;
end

is_model_loaded = bdIsLoaded(model);

if ~is_model_loaded
    try
        load_system(model)
    catch
    end
end

if ~bdIsLoaded(model)
    return;
end

is_model_dirty  = bdIsDirty(model);

hws = get_param(model, 'ModelWorkspace');

old_data_source = hws.DataSource;

if ~isempty(dfile)
    [~, ~, ext] = fileparts(dfile);
    if strcmpi(ext, '.mat')
        hws.DataSource =  'MAT-File';
        hws.FileName = dfile;
        hws.reload();
    elseif strcmpi(ext, '.m')
        hws.DataSource =  'MATLAB File';
        hws.FileName = dfile;
        hws.reload();
    else
    end
else
    matfile =  [fileparts(which(model)), '_model_workspace.mat'];
    if exist(matfile, 'file')
        hws.DataSource =  'MAT-File';
        hws.FileName = matfile;
        hws.reload();
    end

    mfile = [fileparts(which(model)), '_model_workspace.m'];
    if exist(mfile, 'file')
        hws.DataSource =  'MATLAB File';
        hws.FileName = mfile;
        hws.reload();
    end
end

hws.DataSource = old_data_source;

if ~is_model_dirty
    save_system(model);
end

if ~is_model_loaded
    bdclose(model);
end