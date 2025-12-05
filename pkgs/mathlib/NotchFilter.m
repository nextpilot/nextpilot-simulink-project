classdef NotchFilter < handle

    properties (SetAccess=private)
        m_delay_element_1 = 0;
        m_delay_element_2 = 0;
        m_delay_element_output_1 = 0;
        m_delay_element_output_2 = 0;

        % All the coefficients are normalized by a0, so a0 becomes 1 here
        m_a1 = 0;
        m_a2 = 0;

        m_b0 = 1;
        m_b1 = 0;
        m_b2 = 0;

        m_notch_freq = 0;
        m_bandwidth = 0;
        m_sample_freq = 0;
    end


    methods

        function output = apply(self, sample)
            % Direct Form I implementation
            output = self.m_b0 * sample + self.m_b1 * self.m_delay_element_1 + self.m_b2 * self.m_delay_element_2 ...
                - self.m_a1 * self.m_delay_element_output_1 - self.m_a2 * self.m_delay_element_output_2;

            % shift inputs
            self.m_delay_element_2 = self.m_delay_element_1;
            self.m_delay_element_1 = sample;

            % shift outputs
            self.m_delay_element_output_2 = self.m_delay_element_output_1;
            self.m_delay_element_output_1 = output;
        end

        function applyArray(self, samples, num_samples)
            for i = 1:  num_samples
                samples(i) = apply(self, samples(i));
            end
        end

        function freq = getNotchFreq(self)
            freq = self.m_notch_freq;
        end

        function band = getBandwidth(self)
            band = self.m_bandwidth;
        end

        function [a, b] = getCoefficients(self)
            a = [1, self.m_a1, self.m_a2];
            b = [self.m_b0, self.m_b1, self.m_b2];
        end

        function output = getMagnitudeResponse(self, frequency)

            w = 2. * pi * frequency / self.m_sample_freq;

            numerator = self.m_b0 * self.m_b0 + self.m_b1 * self.m_b1 + self.m_b2 * self.m_b2 ...
                + 2. * (self.m_b0 * self.m_b1 + self.m_b1 * self.m_b2) * cos(w) + 2. * self.m_b0 * self.m_b2 * cos(2. * w);

            denominator = 1. + self.m_a1 * self.m_a1 + self.m_a2 * self.m_a2 + 2. * (self.m_a1 + self.m_a1 * self.m_a2) * cos(w) + 2. * self.m_a2 * cos(2. * w);

            output = sqrt(numerator / denominator);
        end

        function setCoefficients(self, a, b)
            self.m_a1 = a(1);
            self.m_a2 = a(2);
            self.m_b0 = b(1);
            self.m_b1 = b(2);
            self.m_b2 = b(3);
        end

        function reset(self, sample)

            if isfinite(sample)
                input = sample;
            else
                input = 0;
            end

            self.m_delay_element_1 = input;
            self.m_delay_element_2 = input;
            self.m_delay_element_output_1 =  input * (self.m_b0 + self.m_b1 + self.m_b2) / (1 + self.m_a1 + self.m_a2);
            self.m_delay_element_output_2 = self.m_delay_element_output_1;

            if (~isfinite(self.m_delay_element_1) || ~isfinite(self.m_delay_element_2))
                self.m_delay_element_output_1 = 0;
                self.m_delay_element_output_2 = 0;
            end
        end

        function disable(self)

            % no filtering
            self.m_notch_freq = 0;
            self.m_bandwidth = 0;
            self.m_sample_freq = 0;

            self.m_delay_element_1 = 0;
            self.m_delay_element_2 = 0;
            self.m_delay_element_output_1 = 0;
            self.m_delay_element_output_2 = 0;

            self.m_b0 = 1.;
            self.m_b1 = 0;
            self.m_b2 = 0;

            self.m_a1 = 0;
            self.m_a2 = 0;
        end

        function setParameters(self, sample_freq, notch_freq, bandwidth)

            if ((sample_freq <= 0) || (notch_freq <= 0) || (bandwidth <= 0) || (notch_freq >= sample_freq / 2) ...
                    || ~isfinite(sample_freq) || ~isfinite(notch_freq) || ~isfinite(bandwidth))
                disable();
                return;
            end

            self.m_notch_freq = constrain(notch_freq, 5, sample_freq / 2); % TODO: min based on actual numerical limit
            self.m_bandwidth = constrain(bandwidth, 5, sample_freq / 2);
            self.m_sample_freq = sample_freq;

            alpha = tan(pi * self.m_bandwidth / self.m_sample_freq);
            beta = -cos(2 * pi * self.m_notch_freq / self.m_sample_freq);
            a0_inv = 1 / (alpha + 1);

            self.m_b0 = a0_inv;
            self.m_b1 = 2 * beta * a0_inv;
            self.m_b2 = a0_inv;

            self.m_a1 = self.m_b1;
            self.m_a2 = (1 - alpha) * a0_inv;

            if (~isfinite(self.m_b0) || ~isfinite(self.m_b1) || ~isfinite(self.m_b2) || ~isfinite(self.m_a1) || ~isfinite(self.m_a2))
                disable();
            end
        end
    end
end