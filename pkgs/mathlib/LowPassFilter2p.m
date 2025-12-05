classdef LowPassFilter2p < handle
    methods
        function self = LowPassFilter2p(sample_freq,  cutoff_freq)
            arguments
                sample_freq (1,1) {} =0
                cutoff_freq (1,1) {} =0
            end
            self.m_cutoff_freq = 0;
            self.m_sample_freq = 0;
            % set initial parameters
            set_cutoff_frequency(self, sample_freq, cutoff_freq);
        end

        % Change filter parameters
        function set_cutoff_frequency(self, sample_freq, cutoff_freq)

            if ((sample_freq <= 0.0) || (cutoff_freq <= 0.0) || (cutoff_freq >= sample_freq / 2)...
                    || ~isfinite(sample_freq) || ~isfinite(cutoff_freq))

                disable(self);
                return;
            end

            % reset delay elements on filter change
            self.m_delay_element_1 = 0.0;
            self.m_delay_element_2 = 0.0;

            self.m_cutoff_freq = constrain(cutoff_freq, 5, sample_freq / 2); % TODO: min based on actual numerical limit
            self.m_sample_freq = sample_freq;

              fr = self.m_sample_freq / self.m_cutoff_freq;
              ohm = tanf(pi / fr);
              c = 1 + 2 * cos(pi / 4) * ohm + ohm * ohm;

            self.m_b0 = ohm * ohm / c;
            self.m_b1 = 2 * self.m_b0;
            self.m_b2 = self.m_b0;

            self.m_a1 = 2 * (ohm * ohm - 1) / c;
            self.m_a2 = (1 - 2 * cos(pi / 4) * ohm + ohm * ohm) / c;

            if (~isfinite(self.m_b0) || ~isfinite(self.m_b1) || ~isfinite(self.m_b2) || ~isfinite(self.m_a1) || ~isfinite(self.m_a2))
                disable(self);
            end
        end


        function output = apply(self, sample)

            % Direct Form II implementation
            delay_element_0 = sample - self.m_delay_element_1 *self.m_a1 - self.m_delay_element_2 * self.m_a2;

            output = delay_element_0 *self.m_b0 + self.m_delay_element_1 *self.m_b1 + self.m_delay_element_2 * self.m_b2;

            self.m_delay_element_2 = self.m_delay_element_1;
            self.m_delay_element_1 = delay_element_0;

        end

        % Filter array of samples in place using the Direct form II.
        function applyArray(self, samples, num_samples)
            for n = 1 :  num_samples
                samples(n) = apply(self, samples(n));
            end
        end

        % Return the cutoff frequency
        function freq = get_cutoff_freq(self)
            freq = self.m_cutoff_freq;
        end

        % Return the sample frequency
        function freq = get_sample_freq(self)
            freq = self.m_sample_freq;
        end

        % function output = getMagnitudeResponse(self, frequency)

        % Reset the filter state to this value
        function output = reset(self, sample)
            if isfinite(sample)
                input =   sample;
            else
                input = 0;
            end

            if (abs(1 + self.m_a1 + self.m_a2) > eps)
                self.m_delay_element_1 = input / (1 + self.m_a1 + self.m_a2);
                self.m_delay_element_2 = self.m_delay_element_1;
                if (~isfinite(self.m_delay_element_1) || ~isfinite(self.m_delay_element_2))
                    self.m_delay_element_1 = input;
                    self.m_delay_element_2 = input;
                end

            else
                self.m_delay_element_1 = input;
                self.m_delay_element_2 = input;
            end

            output =  apply(self, input);
        end

        function disable(self)
            % no filtering
            self.m_sample_freq = 0;
            self.m_cutoff_freq = 0;

            self.m_delay_element_1 = 0.0;
            self.m_delay_element_2 = 0.0;

            self.m_b0 = 1;
            self.m_b1 = 0;
            self.m_b2 = 0;

            self.m_a1 = 0;
            self.m_a2 = 0;
        end
    end

    properties
        m_delay_element_1 = 0.0; % buffered sample -1
        m_delay_element_2 = 0.0; % buffered sample -2

        % All the coefficients are normalized by a0, so a0 becomes 1 here
        m_a1 = 0.0;
        m_a2 = 0.0;

        m_b0 = 1.0;
        m_b1 = 0.0;
        m_b2 = 0.0;

        m_cutoff_freq = 0.0;
        m_sample_freq = 0.0;
    end
end