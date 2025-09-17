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