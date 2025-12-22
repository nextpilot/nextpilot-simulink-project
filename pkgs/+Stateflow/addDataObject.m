function addDataObject(fullpath, properties)

% data，可以是cell，struct或者c代码
% name,scope,type,size
%

properties = {
    'a', 'Local', 'uint8', [1 1]
    'b', 'Local', 'uint8', [1 1]
    };

fullpath = 'untitled1/Chart';

%% 查找父对象

[filepath, filename] = fileparts(fullpath);

parent = find(sfroot(), ...
    'Path', filepath,...
    'Name', filename);

if isa(parent, 'Simulink.SubSystem')
    parent = find(sfroot(), ...
        'Path', fullpath,...
        'Name', filename);
end

% 检查是否允许添加data的对象
parent_for_data_object  = {
    'Stateflow.Box'
    'Stateflow.Chart'
    'Stateflow.EMFunction'
    'Stateflow.Function'
    'Stateflow.SLFunction'
    'Stateflow.State'
    'Stateflow.TruthTable'
    'Stateflow.Chart'
    };

if ~ismember(class(parent),parent_for_data_object)
    return;
end


%% 添加数据对象

%
% float abc[5]; // comment
if iscell(properties)
    for i = 1 : size(properties, 1)
        obj = Stateflow.Data(parent);
        obj.Name  = properties{i, 1};
        obj.Scope = properties{i, 2};
    end
elseif isstruct(properties)
    for i = 1 : length(properties)
        obj = Stateflow.Data(parent);
        obj.Name  = properties(i).Name;
        obj.Scope = properties(i).Scope;
    end
elseif isstring(properties) || ischar(properties)
end

sfsave();