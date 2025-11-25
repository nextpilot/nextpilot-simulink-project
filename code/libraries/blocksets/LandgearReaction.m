classdef (StrictDefaults)LandgearReaction < matlab.System
%LandgearReaction Applies gain to the bus input.

    %#codegen
    properties
        % Location
        Location = [];

        % Axes
        
    end

    properties (Nontunable)        
       
    end

    

    methods (Access = protected)
        function y = stepImpl(obj,brakecmd,turncmd, euler, vb, cog, reaction)
            % Implement algorithm. Calculate y as a function of input u and
            % internal states.
            y = u;
        end
    end
end