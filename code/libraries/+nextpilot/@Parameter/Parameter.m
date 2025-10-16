%
%https://ww2.mathworks.cn/help/simulink/ug/simulink-data-class-extension-using-matlab-class-syntax.html
%
% 更多用法参见
% toolbox\simulink\simdemos\dataclasses
%
% 使用以下命令进行类的存储设计
% cscdesigner('nextpilot')
%
classdef Parameter < Simulink.Parameter

    % properties
    %     Decimal = [];
    % end
    % properties
    %     Increment = [];
    % end

    methods

        function obj = Parameter(varargin)
            p = inputParser;
            p.addOptional('Value', []);
            p.addParameter('Description', '');
            p.addParameter('DataType', 'auto');
            p.addParameter('Min', []);
            p.addParameter('Max', []);
            p.addParameter('Unit', '');
            p.addParameter('Complexity', 'real');
            p.addParameter('Dimensions', [0 0]);

            p.parse(varargin{:});

            obj.Value       = p.Results.Value;
            % obj.Dimensions  = p.Results.Dimensions;
            % obj.DataType    = p.Results.DataType;
            % obj.Complexity  = p.Results.Complexity;
            obj.Min         = p.Results.Min;
            obj.Max         = p.Results.Max;
            obj.Unit        = p.Results.Unit;
            obj.Description = p.Results.Description;

        end

        function setupCoderInfo(obj)
            useLocalCustomStorageClasses(obj, 'nextpilot');
            obj.CoderInfo.StorageClass = 'Custom';
        end
    end

end