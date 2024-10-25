%  scripts/RunTestsWithCoverage.m
% 
%  Invoke MATLAB unit tests for this project while logging code coverage
%  Generate a coverage report after completing all tests

% Copyright 2021 The MathWorks, Inc.

import matlab.unittest.TestRunner
import matlab.unittest.plugins.CodeCoveragePlugin
import matlab.unittest.plugins.codecoverage.CoberturaFormat

testFile = 'test_import_pet_gunzip.m';
sourceCodeFile = which('import_pet_gunzip.m');
suite = testsuite(testFile);

% Check if brainstorm is running before doing tests
% Start Brainstorm if not already open

    % Check if Brainstorm is running
          if isempty(bst_get ('isGUI'))
              brainstorm
          end

runner = TestRunner.withTextOutput;
runner.addPlugin(CodeCoveragePlugin.forFile(sourceCodeFile))
result = runner.run(suite);


