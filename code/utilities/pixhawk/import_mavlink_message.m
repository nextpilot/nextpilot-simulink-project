function import_mavlink_message(varargin)

% 参数处理
args = inputParser;
addOptional(args, 'xml_file','', @(x)ischar(x) || isstring(x));
addOptional(args, 'save_target','base', @(x)ischar(x) || isstring(x));
parse(args, varargin{:})

xml_file = args.Results.xml_file;
if isempty(xml_file)
    [filename, pathname] = uigetfile({'*.xml', 'MavLink Msg Files (*.xml)'},'uORB Msg Files');
    if isequal(pathname, 0)
        return;
    else
        xml_file = fullfile(pathname, filename);
    end
end

% 导入mavlink
[~,name,exts] = fileparts(args.Results.save_target);
if isempty(exts) && strcmpi(name,'base')
    save_mavlink_to_ws(args.Results.save_target, xml_file)
elseif strcmpi(exts, '.sldd')
    save_mavlink_to_sldd(args.Results.save_target, xml_file);
end

function save_mavlink_to_ws(ws, xmlfile)
% 读取xml文件
mavlink = readstruct(xmlfile);

% 处理<include>
if isfield(mavlink, 'include')
    rootpath = fileparts(xmlfile);
    for i = 1 : length(mavlink.include)
        save_mavlink_to_ws(ws, fullfile(rootpath, mavlink.include(i)));
    end
end

% 处理<enums>
if isfield(mavlink, 'enums') && isfield(mavlink.enums, 'enum')
    for i = 1: length(mavlink.enums.enum)
        enum = mavlink.enums.enum(i);
        for j = 1 : length(enum.entry)
            if startsWith(enum.entry(j).nameAttribute, 'MAV_')
                entry_name = enum.entry(j).nameAttribute;
            else
                entry_name = "MAV_" + enum.entry(j).nameAttribute;
            end
            assignin(ws, entry_name, enum.entry(j).valueAttribute);
        end

    end
end

% 处理<messages>
if isfield(mavlink, 'messages') && isfield(mavlink.messages, 'message')
    for i = 1 : length(mavlink.messages.message)
        message = mavlink.messages.message(i);
        clear eobj
        bobj = Simulink.Bus;
        if ~ismissing(message.description)
            bobj.Description = message.description;
        end
        for j = 1 : length(message.field)
            eobj(j) = Simulink.BusElement;
            eobj(j).Name = message.field(j).nameAttribute;
            [type, dims] = get_simulink_datatype(message.field(j).typeAttribute);
            eobj(j).DataType = type;
            eobj(j).Description = message.field(j).Text;
            eobj(j).Dimensions = dims;
        end
        bobj.Elements = eobj;
        if ~startsWith(lower(message.nameAttribute), "mav_")
            bus_name = "mav_" + lower(message.nameAttribute) + "_s";
        else
            bus_name = lower(message.nameAttribute) + "_s";
        end
        assignin(ws, bus_name, bobj);
    end
end

function save_mavlink_to_sldd(sldd, xmlfile)
% 读取xml文件
mavlink = readstruct(xmlfile);

% 处理<include>
if isfield(mavlink, 'include')
    rootpath = fileparts(xmlfile);
    for i = 1 : length(mavlink.include)
        save_mavlink_to_sldd(sldd, fullfile(rootpath, mavlink.include(i)));
    end
end

% 打开数据字典
if exist(sldd,'file')
    dobj=Simulink.data.dictionary.open(sldd);
else
    dobj=Simulink.data.dictionary.create(sldd);
end
sobj = getSection(dobj,'Design Data');

% 处理<enums>
if isfield(mavlink, 'enums') && isfield(mavlink.enums, 'enum')
    % 创建常值参数
    p = Simulink.Parameter();
    p.CoderInfo.StorageClass='Custom';
    p.CoderInfo.CustomStorageClass='Const';
    for i = 1: length(mavlink.enums.enum)
        enum = mavlink.enums.enum(i);
        % 创建枚举类型
        nobj = Simulink.data.dictionary.EnumTypeDefinition;
        nobj.AddClassNameToEnumNames = true;
        if ~ismissing(enum.description)
            nobj.Description = enum.description;
        end
        for j = 1 : length(enum.entry)
            if startsWith(enum.entry(j).nameAttribute, enum.nameAttribute + "_")
                entry_name = genvarname(strrep(enum.entry(j).nameAttribute, enum.nameAttribute + "_", ""));
            else
                entry_name = enum.entry(j).nameAttribute;
            end
            if isfield(enum.entry(j), 'description') && ~ismissing(enum.entry(j).description)
                description = enum.entry(j).description;
            else
                description = '';
            end
            if enum.entry(j).valueAttribute < intmax('int32')
                appendEnumeral(nobj, entry_name, enum.entry(j).valueAttribute, description);
            end
            set(p,{'Value','Description'},{enum.entry(j).valueAttribute, description});
            if startsWith(enum.entry(j).nameAttribute, 'MAV_') 
                entry_name = enum.entry(j).nameAttribute;
            else
                entry_name = "MAV_" + enum.entry(j).nameAttribute;
            end
            assignin(sobj, entry_name, p);
        end
        removeEnumeral(nobj, 1)
        if startsWith(enum.nameAttribute, 'MAV_')
            enum_name = enum.nameAttribute;
        else
            enum_name = "MAV_" + enum.nameAttribute;
        end
        assignin(sobj, enum_name, nobj);
    end
end

% 处理<messages>
if isfield(mavlink, 'messages') && isfield(mavlink.messages, 'message')
    for i = 1 : length(mavlink.messages.message)
        message = mavlink.messages.message(i);
        clear eobj
        bobj = Simulink.Bus;
        if ~ismissing(message.description)
            bobj.Description = message.description;
        end
        for j = 1 : length(message.field)
            eobj(j) = Simulink.BusElement;
            eobj(j).Name = message.field(j).nameAttribute;
            [type, dims] = get_simulink_datatype(message.field(j).typeAttribute);
            eobj(j).DataType = type;
            eobj(j).Description = message.field(j).Text;
            eobj(j).Dimensions = dims;
        end
        bobj.Elements = eobj;
        if ~startsWith(lower(message.nameAttribute), "mav_")
            bus_name = "mav_" + lower(message.nameAttribute) + "_s";
        else
            bus_name = lower(message.nameAttribute) + "_s";
        end
        assignin(sobj, bus_name, bobj);
    end
end

% 保存数据字典
saveChanges(dobj);
close(dobj);


function [sltype, sldims] = get_simulink_datatype(oldtype)

if isnumeric(oldtype)
    oldtype = class(oldtype);
    sldims  = size(oldtype);
elseif ischar(oldtype) || isstring(oldtype)
    tokens  = regexp(oldtype,'([^\s\[]+)\s*(\[[\d, ]+\])*','tokens','once');
    oldtype = lower(tokens{1});
    if isempty(tokens{2})
        sldims = 1;
    else
        sldims = eval(tokens{2});
    end
else
    error('getdatatype:WrongInputDataType','Can''t Recognize DataType: %s', class(oldtype));
end

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
