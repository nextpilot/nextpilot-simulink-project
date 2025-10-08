%
%https://ww2.mathworks.cn/help/simulink/ug/simulink-data-class-extension-using-matlab-class-syntax.html
%
% 更多用法参见
% toolbox\simulink\simdemos\dataclasses
%
% 使用以下命令进行类的存储设计
% cscdesigner('nextpilot')
%
classdef CustomStorageClassAttributes < Simulink.CustomStorageClassAttributes
    properties(PropertyType = 'char')
        AlternateName = '';
    end

    properties(PropertyType = 'logical scalar')
        IsAlternateNameInstanceSpecific = true;
    end

    methods
        function retVal = isAddressable(hObj, hCSCDefn, hData)
            retVal = false;
        end
    end % methods
end % classdef