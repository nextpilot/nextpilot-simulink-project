classdef Constant < nextpilot.Parameter
    methods
        function obj = Constant(varargin)
        obj@nextpilot.Parameter(varargin{:});
        obj.CoderInfo.StorageClass       = 'Custom';
        obj.CoderInfo.CustomStorageClass = 'Const';
        end
    end
end