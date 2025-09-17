classdef Parameter < Simulink.Parameter

    properties
        Decimal = [];
    end
    properties
        Increment = [];
    end

    methods
    

        function setupCoderInfo(obj)
            useLocalCustomStorageClasses(obj, 'nextpilot');

            obj.CoderInfo.StorageClass = 'Custom';
        end
    end

end