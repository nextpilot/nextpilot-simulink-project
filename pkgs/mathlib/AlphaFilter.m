classdef AlphaFilter < handle
    properties
        m_alpha = 0;
        m_state = 0;
    end

    methods
        function self = AlphaFilter(alpha, state)
            arguments
                alpha (1,1) {mustBeNumeric, mustBeGreaterThanOrEqual(alpha, 0), mustBeLessThanOrEqual(alpha, 1)} = 0
                state (1,1) {mustBeNumeric} = 0
            end
            self.m_alpha = alpha;
            self.m_state = state;
        end

        function setParameters(self, sample_interval, time_constant)        
             denominator = time_constant + sample_interval;
             if denominator > eps
                 setAlpha(self, sample_interval / denominator);
             end
        end

        function setAlpha(self, alpha)
            self.m_alpha = alpha;
        end

        function reset(self, sample)
            self.m_state = sample;
        end

        function state = getState(self)
            state = self.m_state;
        end

        function state = update(self, sample)
            state = (1. - self.m_alpha) * self.m_state + self.m_alpha * sample;
            self.m_state = state;
        end
    end
end