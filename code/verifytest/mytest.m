% 请使用runtests('mytest')运行当前用测试用例

classdef mytest < matlab.unittest.TestCase
    % properties (TestParameter)
    % end
    % 
    % methods (TestMethodSetup)
    %     function create_temp_flolder(obj)
    %         % obj.Temp
    %     end
    % end

    methods (Test)
        function testAdd(obj)
            result = 2 + 3;
            obj.verifyEqual(result, 5);
        end
    end
end