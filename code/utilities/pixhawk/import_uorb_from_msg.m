function varargout = import_uorb_from_msg(varargin)
% import_uorb_message(uorb_files, save_target)
%
% uorb_files:  uorb消息文件，支持cellstr，char，string，string array等，字符串中可以有通配符
% save_target: 结构体和枚举类型保存文件，支持base工作空间和sldd文件格式
%
% Examples
%
%   msg = 'msg\commander_state.msg'
%   msg = 'msg\*.msg'
%   msg = 'msg\**\*msg'
%   msg = {'msg\commander_state.msg', 'msg\*.msg', 'msg\**\*msg'}
%
% 采用 Simulink.importExternalCTypes 函数能转换常规 C/C++ 数据类


%% 参数处理
args = inputParser;
addOptional(args, 'uorb_files','', @(x)ischar(x) || isstring(x) || iscellstr(x));
addOptional(args, 'save_target','base', @(x)ischar(x) || isstring(x));
parse(args, varargin{:})

msg_file_list = args.Results.uorb_files;
if isempty(msg_file_list)
    [filename, pathname] = uigetfile({'*.msg', 'uORB Msg Files (*.msg)'},'uORB Msg Files','MultiSelect','on');
    if isequal(pathname, 0)
        return;
    else
        msg_file_list = fullfile(pathname, filename);
    end
end

% 将char和string转为cell
if ischar(msg_file_list)
    msg_file_list = {msg_file_list};
elseif isstring(msg_file_list)
    msg_file_list = cellstr(msg_file_list);
end

%% 读取文件
idx = 0;
uorb_info_list = {};
for i = 1:length(msg_file_list)
    % fprintf('[%d/%d] %s\n',i,length(msg_files),msg_files{i});
    msg_dir_list = dir(msg_file_list{i});
    for j = 1:length(msg_dir_list)
        idx = idx + 1;
        file = fullfile(msg_dir_list(j).folder,msg_dir_list(j).name);
        fprintf('[%d]%s\n',idx, file);

        [~,~,exts] = fileparts(file);
        % elem = [name, type, size, desc]
        % enum = [name, type, value, decs]
        if strcmpi(exts, '.h')
            uorb_info_list{end+1} = read_uorb_from_header(file);
        elseif strcmpi(exts, '.msg')
            uorb_info_list{end+1} = read_uorb_from_msg(file);
        end
    end
end

%% 保存数据
[~,name,exts] = fileparts(args.Results.save_target);
if isempty(exts) && strcmpi(name,'base')
    save_uorb_to_ws(args.Results.save_target, uorb_info_list )
elseif strcmpi(exts, '.sldd')
    save_uorb_to_sldd(args.Results.save_target, uorb_info_list );
end


%% 输出列表
if nargout > 0
    varargout{1} = uorb_info_list ;
end


function info = read_uorb_from_msg(file)

[~,name]=fileparts(file);
name = camel2under(name);

info.file = file;
info.name = name;
info.topics = {};
info.fields = [];
info.consts = [];

fid=fopen(file);
while ~feof(fid)
    % 跳过空行或者注释行
    tline = strtrim(fgetl(fid));
    if isempty(tline)
        continue
    elseif startsWith(tline, '# TOPICS')
        info.topics = [info.topics, strsplit(strtrim(strrep(tline, '# TOPICS','')))];
        continue;
    elseif startsWith(tline ,'#')
        continue;
    end
    % 拆分注释和定义
    tokens = regexpi(tline,'([^#]+)(.*)','tokens','once');
    left = tokens{1};
    rght = tokens{2};
    if contains(left,'=')
        % 枚举类型
        % uint8 AIRSPD_MODE_MEAS = 0	# airspeed is measured airspeed from sensor
        tok = regexpi(left, '(\w+)\s+(\w+)\s*=\s*([-\d]+)','tokens','once');
        info.consts(end+1).name = tok{2};
        info.consts(end).type = tok{1};
        info.consts(end).value = str2num(tok{3});
        info.consts(end).comment=rght;
    else
        % 结构体字段
        % float32[3] vel_variance	# Variance in body velocity estimate
        tok=regexpi(tline,'(\w+)(\[\d+\])*\s+(\w+)','tokens','once');
        info.fields(end+1).name = tok{3};
        info.fields(end).type = tok{1};
        if isempty(tok{2})
            info.fields(end).dims = 1;
        else
            info.fields(end).dims=str2num(tok{2});
        end
        info.fields(end).comment = rght;
    end
end
fclose(fid);

if isempty(info.topics)
    info.topics = {name};
end


function info = read_uorb_from_header(file)

[~,name]=fileparts(file);
name = camel2under(name);

info.file = file;
info.name = name;
info.topics = {name};
info.fields = [];
info.consts = [];

% 打开文件
fid=fopen(file);
fskip(fid, 'struct __EXPORT');
fskip(fid, 3);

% 读取结构体
while ~feof(fid)
    tline = strtrim(fgetl(fid));
    if isempty(tline)
        continue;
    elseif contains(tline, '#ifdef __cplusplus')
        break;
    end
    % uint8_t _padding0[7]; // required for logger
    tokens = regexpi(tline, '(struct )*(.+) ([\d\w_]+)(\[\d+\])*;','tokens','once');
    info.fields(end+1).name=tokens{3};
    info.fields(end).type=tokens{2};
    if isempty(tokens{4})
        info.fields(end).dims = 1;
    else
        info.fields(end).dims = str2num(tokens{4});
    end
    info.fields(end).comment='';

end

% 读取枚举
while ~feof(fid)
    tline = strtrim(fgetl(fid));
    if isempty(tline)
        continue;
    elseif contains(tline, '#endif')
        break;
    end
    % static constexpr uint8_t MAIN_STATE_MANUAL = 0;
    tokens = regexpi(tline, 'static constexpr (.+) ([\d\w_]+) \= ([\-\d])+;','tokens','once');
   info.consts(end+1).name=tokens{2};
   info.consts(end).type=tokens{1};
   info.consts(end).value=tokens{3};
   info.consts(end).comment='';
end
% 关闭文件
fclose(fid);


%% 保存到base工作空间
function save_uorb_to_ws(ws, list)
for i = 1:length(list)
    % 结构体
    fields = list{i}.fields;
    topics = list{i}.topics;
    if ~isempty(fields)
        bobj = Simulink.Bus;
        clear eobj;
        for j=1:length(fields)
            eobj(j)             = Simulink.BusElement;
            eobj(j).Name        = fields(j).name;
            eobj(j).DataType    = get_simulink_datatype(fields(j).type);
            eobj(j).Dimensions  = fields(j).dims;
            eobj(j).Description = fields(j).comment;
        end
        bobj.Elements = eobj;

        for k=1:length(topics)
            assignin(ws, [topics{k},'_s'], bobj);
        end
    end

    % 枚举
    % name = upper(list{i}.name);
    consts = list{i}.consts;
    if ~isempty(consts)
        % Simulink.defineIntEnumType(name,{consts.name},[consts.value]);
        for j=1:length(consts)
            assignin(ws, consts(j).name, consts(j).value);
        end
    end
end

%% 保存到sldd数据字典
function save_uorb_to_sldd(file, list)
% 打开ssld文件
if exist(file,'file')
    dobj=Simulink.data.dictionary.open(file);
else
    dobj=Simulink.data.dictionary.create(file);
end
sobj = getSection(dobj,'Design Data');

% 定义总线类型
for i = 1:length(list)
   
    % 结构体
    fields = list{i}.fields;
    topics = list{i}.topics;
    if ~isempty(fields)
        bobj = Simulink.Bus;
        clear eobj

        for j=1:length(fields)
            eobj(j)=Simulink.BusElement;
            eobj(j).Name = fields(j).name;
            eobj(j).DataType = get_simulink_datatype(fields(j).type);
            eobj(j).Dimensions = fields(j).dims;
            eobj(j).Description = fields(j).comment;
        end
        bobj.Elements = eobj;

        for k =1:length(topics)
            assignin(sobj,[topics{k},'_s'],bobj);
        end
    end

    % 枚举类型
    name = upper(list{i}.name);
    consts = list{i}.consts;
    if ~isempty(consts)
        % 将枚举项定义为参数
        p = Simulink.Parameter();
        p.CoderInfo.StorageClass       = 'Custom';
        p.CoderInfo.CustomStorageClass = 'Const';

        nobj = Simulink.data.dictionary.EnumTypeDefinition;
        nobj.AddClassNameToEnumNames = true;
        for j=1:length(consts)
            % 增加枚举项
            appendEnumeral(nobj,consts(j).name,consts(j).value, consts(j).comment);
            % 保存为参数
            p.Value=[];
            set(p,{'DataType','Value','Description'},{get_simulink_datatype(consts(j).type), consts(j).value, consts(j).comment});
            assignin(sobj, upper(consts(j).name), p);
        end
        removeEnumeral(nobj,1)
        assignin(sobj,name,nobj);
    end
end

% 保存sldd文件
saveChanges(dobj);
close(dobj);

function [mltype, mldims] = get_simulink_datatype(oldtype)

if isnumeric(oldtype)
    oldtype = class(oldtype);
    mldims = size(oldtype);
elseif ischar(oldtype)
    tokens = regexp(oldtype, '(\w+)(\[\d+\])*', 'tokens', 'once');
    oldtype = lower(tokens{1});
    if isempty(tokens{2})
        mldims = 1;
    else
        mldims = eval(tokens{2});
    end
else
    error('get_simulink_datatype:WrongInputDataType', 'Can''t Recognize DataType: %s', class(oldtype));
end

switch lower(oldtype)
    case {'double', 'float64'}
        mltype = 'double';
    case {'single', 'float', 'float32'}
        mltype = 'single';
    case {'uint64', 'unsigned long long'}
        mltype = 'uint64';
    case {'uint32', 'unsigned long', 'ulong'}
        mltype = 'uint32';
    case {'uint16', 'unsigned short', 'ushort'}
        mltype = 'uint16';
    case {'uint8', 'unsigned char', 'uchar'}
        mltype = 'uint8';
    case {'int64', 'long long'}
        mltype = 'int64';
    case {'int32', 'long'}
        mltype = 'int32';
    case {'int16', 'short'}
        mltype = 'int16';
    case {'int8', 'char'}
        mltype = 'int8';
    case {'uint'}
        mltype = 'uint32';
    case {'int'}
        mltype = 'int32';
    case {'bool', 'boolean', 'logcial'}
        mltype = 'boolean';
    otherwise
        mltype = oldtype;
end

function under = camel2under(camel)
% camel2under 驼峰命名转下划线命名, 小写和大写紧挨一起的地方, 加上分隔符, 然后全部转小写
%
% Example:
%
% 'abcDefGh' ==> 'abc_def_gh'

under = lower(regexprep(camel, '([0-9a-z])([A-Z])', '$1_$2'));

