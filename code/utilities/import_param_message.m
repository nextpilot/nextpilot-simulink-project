function varargout = import_param_message(varargin)
% ssld/base/mat文件支持的数据类型dtype有variable, mpt等
% import_param_from_json(json_file, save_target='base', csc_type='Simulink.Paramter')
% 
% 从json文件中导入param，并保存到save_file文件，save_file可以是'base'或实际的'sldd'文件
%
% Examples
%
%     import_param_from_json('parameters.json', 'base', 'auto')
%     import_param_from_json('parameters.json', 'param.sldd', 'Simulink.Parameter')
%

% 参数处理
args = inputParser;
addOptional(args, 'json_file','', @(x)ischar(x) || isstring(x));
addOptional(args, 'save_target','base', @(x)ischar(x) || isstring(x));
addOptional(args, 'csc_type','Simulink.Parameter', @(x)ischar(x) || isstring(x));
parse(args, varargin{:})

json_file = args.Results.json_file;
if isempty(json_file)
    [filename, pathname] = uigetfile({'*.json', 'Param json Files (*.json)'},'uORB Msg Files');
    if isequal(pathname, 0)
        return;
    else
        json_file = fullfile(pathname, filename);
    end
end

% 导入param
save_target = args.Results.save_target;
csc_type = args.Results.csc_type;
[~,name,exts] = fileparts(save_target);
if isempty(exts) && strcmpi(name, 'base')
    save_param_to_ws(save_target, json_file, csc_type)
elseif strcmpi(exts, '.sldd')
    save_param_to_sldd(save_target, json_file, csc_type)
end

%% 输出列表
if nargout > 0
    varargout{1} = param;
end


function save_param_to_ws(ws, json, csc)
% 读取json文件
param = jsondecode(fileread(json));

% 创建参数
for i = 1:length(param.parameters)
    meta = param.parameters{i};
    value = create_single_param(csc, meta);
    assignin(ws, genvarname(meta.name), value);
end


function save_param_to_sldd(sldd, json, csc)

% 读取json文件
param = jsondecode(fileread(json));

% 打开sldd文件
if exist(sldd, 'file')
    dobj = Simulink.data.dictionary.open(sldd);
else
    dobj = Simulink.data.dictionary.create(sldd);
end
sobj = getSection(dobj,'Design Data');

% 创建参数
for i = 1:length(param.parameters)
    meta = param.parameters{i};
    value = create_single_param(csc, meta);
    assignin(sobj, name, value);
end

% 保存字典
saveChanges(dobj);
close(dobj);


function obj = create_single_param(csc, meta)
type = get_simulink_datatype(meta.type);
value = cast(meta.default, type);

if strcmpi(csc, 'auto')
    obj = value;
else
    obj = feval(csc, value);
    obj.DataType = type;
    if isfield(meta, 'min')
        obj.Min = meta.min;
    end
    if isfield(meta,'max')
        obj.Max = meta.max;
    end
    if isfield(meta, 'unit')
        obj.Unit = meta.unit;
    end
    if isfield(meta, 'longDesc')
        obj.Description = meta.longDesc;
    end
end


function sltype = get_simulink_datatype(oldtype)

switch lower(oldtype)
    case {'double','float64'}
        sltype = 'double';
    case {'single','float','float32','real_t'}
        sltype = 'single';
    case {'uint64','unsigned long long','uint64_t'}
        sltype = 'fixdt(0,64,0)';
    case {'uint32','unsigned long','ulong','uint32_t'}
        sltype = 'uint32';
    case {'uint16','unsigned short','ushort','uint16_t'}
        sltype = 'uint16';
    case {'uint8','unsigned char','uchar','uint8_t'}
        sltype = 'uint8';
    case {'int64','long long','int64_t'}
        sltype = 'fixdt(1,64,0)';
    case {'int32','long','int32_t'}
        sltype = 'int32';
    case {'int16','short','int16_t'}
        sltype = 'int16';
    case {'int8','char','int5_t'}
        sltype = 'int8';
    case {'uint'}
        sltype = 'uint32';
    case {'int'}
        sltype='int32';
    case {'bool','boolean','logcial'}
        sltype = 'boolean';
    otherwise
        sltype = oldtype;
end