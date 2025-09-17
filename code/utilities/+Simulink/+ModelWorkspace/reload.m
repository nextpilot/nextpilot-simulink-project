function reload(varargin)

if nargin == 0
    model = bdroot;
else
    model = varargin{1};
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

hws.reload();

if ~is_model_dirty
    save_system(model);
end

if ~is_model_loaded
    bdclose(model);
end

