classdef NumericFormatFixture < matlab.unittest.fixtures.Fixture
    properties (SetAccess=immutable)
        Format (1,1) string
    end

    properties (Access=private)
        OriginalFormat
    end

    methods
        function fixture = NumericFormatFixture(fmt)  
            fixture.Format = fmt;
        end

        function setup(fixture)
            fixture.OriginalFormat = format().NumericFormat;
            format(fixture.Format)
            fixture.SetupDescription = "Set the numeric format to " + ...
                fixture.Format + ".";
        end

        function teardown(fixture)
            format(fixture.OriginalFormat)
            fixture.TeardownDescription =  ...
                "Restored the numeric format to " + ...
                fixture.OriginalFormat + ".";
        end
    end

    methods (Access=protected)
        function tf = isCompatible(fixture1,fixture2)
            tf = fixture1.Format == fixture2.Format;
        end
    end
end