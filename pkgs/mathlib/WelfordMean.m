classdef WelfordMean < handle
    % Welford's online algorithm for computing mean and variance.
    properties (SetAccess=private)
        m_mean = 0;
        m_M2 = 0;
        m_count = 0;
    end

    methods
        % For a new value, compute the new count, new mean, the new M2.
        function update(self, new_value)
            if (self.m_count == 0)
                self.m_mean = new_value;
            end

            self.m_count = self.m_count + 1;

            % mean accumulates the mean of the entire dataset
            delta = new_value - self.m_mean;
            self.m_mean = self.m_mean + delta / self.m_count;

            % M2 aggregates the squared distance from the mean
            % count aggregates the number of samples seen so far
            self.m_M2 =  self.m_M2 + delta * (new_value - self.m_mean);
        end

        function value = valid(self)
            value = self.m_count > 2;
        end

        function value =  count(self)
            value = self.m_count;
        end

        function reset(self)
            self.m_count = 0;
            self.m_mean = 0;
            self.m_M2 = 0;
        end

        % Retrieve the mean, variance and sample variance
        function value = mean(self)
            value = self.m_mean;
        end

        function value =  variance(self)
            value = self.m_M2 / self.m_count;
        end

        function value = sample_variance(self)
            value =  self.m_M2 / (self.m_count - 1);
        end
    end
end