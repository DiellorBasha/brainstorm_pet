classdef Test_db_template < matlab.unittest.TestCase

    properties
        TextToDisplay= "Structure under test"
    end

    methods(TestClassSetup)
        % Shared setup for the entire test class
    end

    methods(TestMethodSetup)
        % Setup for each test
    end

    methods(Test)
        % Test methods
        function testPetMatCreation(testCase)

            actual=db_template("petmat");

            expected = struct(...
                'Comment',     '', ...
                'Cube',        [], ...
                'Voxsize',     [], ...
                'Tracer',      [], ...
                'Frames',      [], ...
                'NCS',         [], ...
                'SCS',         [], ...
                'Header',      [], ...
                'Histogram',   [], ...
                'InitTransf',  [], ...   % Cell-array Nx2: {label, transf4x4}, label={'vox2ras', 'permute', 'flipdim', 'reg'}
                'Labels',      [], ...
                'History',     []);

            diagnostic = [testCase.TextToDisplay ...
                "petmat"];

            % Check if Brainstorm is running
            testCase.assertTrue(bst_get('isGUI'));
            testCase.verifyEqual(actual, expected);
            testCase.verifyEmpty(actual, diagnostic);

        end
    end

end