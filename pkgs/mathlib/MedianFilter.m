classdef MedianFilter < handle
    methods
        % static_assert(WINDOW >= 3, "MedianFilter window size must be >= 3");
        % static_assert(WINDOW % 2, "MedianFilter window size must be odd"); // odd

        function self = MedianFilter(window)
            arguments
                window (1,1) {mustBeInteger, mustBePositive} = 3;
            end

            self.WINDOW = window;
            self.m_buffer = zeros(1,window);
        end

        function insert(self, sample)
            self.m_head = mod((self.m_head + 1), self.WINDOW);
            self.m_buffer(self.m_head) = sample;
        end

        function output = median(self)
            buffer_sorted = sort(self.m_buffer);
            output = buffer_sorted(floor(self.WINDOW / 2));
        end

        function output = apply(self, sample)
            insert(self, sample);
            output = median(self);
        end
    end

    properties (SetAccess=immutable)
        WINDOW = 3;
    end

    properties (SetAccess=private)
        m_buffer = [];
        m_head = 0;
    end
end