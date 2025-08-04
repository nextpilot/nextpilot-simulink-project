function import_param_from_mfile(varargin)


args = inputParser;
addOptional(args, 'param_files','', @(x)ischar(x) || isstring(x) || iscellstr(x));
addOptional(args, 'save_target','base', @(x)ischar(x) || isstring(x));
addOptional(args, 'csc_type','Simulink.Parameter', @(x)ischar(x) || isstring(x));
parse(args, varargin{:})

param_files = args.Results.param_files;

% 将char和string转为cell
if ischar(param_files)
    param_files = {param_files};
elseif isstring(param_files)
    param_files = cellstr(param_files);
end

mfiles = {};
for i = 1 : length(param_files)
    list = dir(param_files{i});
    mfiles = [mfiles, fullfile(list.folder, list.name)];
end

[~,name,exts] = fileparts(args.Results.save_target);
if isempty(exts) && strcmpi(name,'base')
    save_param_to_ws('base', mfiles);
elseif strcmpi(exts, '.sldd')
    save_param_to_sldd(args.Results.save_target, mfiles);
end

function info = read_vars_from_mfile(mfile)
info.file = mfile;
info.vars = [];

oldvar = who;
run(mfile);
newvar = who;
addvar = setdiff(oldvar, newvar);

for i = 1 : length(addvar)
    info.vars(end+1).name = addvar{i};
    info.vars(end).value = eval(addvar{i});
end

function save_param_to_ws(ws, mfile)

for i = 1:length(mfile)
    info = read_vars_from_mfile(mfile{i});
    for j = 1:length(info.vars)
        assignin(ws, info.vars(j).name, info.vars(j).value);
    end
end

function save_param_to_sldd(sldd, mfile)

% 打开sldd文件
if exist(sldd, 'file')
    dobj = Simulink.data.dictionary.open(sldd);
else
    dobj = Simulink.data.dictionary.create(sldd);
end
sobj = getSection(dobj,'Design Data');

% 从M文件中导入变量
for i = 1:length(mfile)
    importFromFile(sobj, mfile{i},'existingVarsAction','overwrite');
end


% 保存字典
saveChanges(dobj);
close(dobj);
