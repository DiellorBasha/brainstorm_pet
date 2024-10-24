classdef Test_import_pet < matlab.unittest.TestCase
    methods(Test)
        function testDefaultInputs(testCase)
            % Test 1: No inputs provided (except for required ones)
            iSubject = 1;
            MriFile = '';
            [BstMriFile, sMri, Messages] = import_pet(iSubject, MriFile);
            
            % Verify that default values are assigned
            testCase.verifyEqual(BstMriFile, [], 'BstMriFile should be empty');
            testCase.verifyEqual(sMri, [], 'sMri should be empty');
            testCase.verifyEqual(Messages, [], 'Messages should be empty');
        end
        
        function testPartialInputs(testCase)
            % Test 2: Some inputs provided, others missing
            iSubject = 1;
            MriFile = '';
            FileFormat = 'Nifti';
            isInteractive = 1;
            
            [BstMriFile, sMri, Messages] = import_pet(iSubject, MriFile, FileFormat, isInteractive);
            
            % Verify that the provided inputs are used and defaults are applied for missing inputs
            testCase.verifyEqual(BstMriFile, [], 'BstMriFile should be empty');
            testCase.verifyEqual(sMri, [], 'sMri should be empty');
            testCase.verifyEqual(Messages, [], 'Messages should be empty');
            testCase.verifyEqual(FileFormat, 'Nifti', 'FileFormat should be Nifti');
            testCase.verifyEqual(isInteractive, 1, 'isInteractive should be 1');
        end
        
        function testAllInputsProvided(testCase)
            % Test 3: All inputs provided
            iSubject = 1;
            MriFile = '';
            FileFormat = 'DICOM';
            isInteractive = 1;
            isAutoAdjust = 0;
            Comment = 'TestComment';
            Labels = {'Label1'};
            
            [BstMriFile, sMri, Messages] = import_pet(iSubject, MriFile, FileFormat, isInteractive, isAutoAdjust, Comment, Labels);
            
            % Verify that all provided inputs are used
            testCase.verifyEqual(BstMriFile, [], 'BstMriFile should be empty');
            testCase.verifyEqual(sMri, [], 'sMri should be empty');
            testCase.verifyEqual(Messages, [], 'Messages should be empty');
            testCase.verifyEqual(FileFormat, 'DICOM', 'FileFormat should be DICOM');
            testCase.verifyEqual(isInteractive, 1, 'isInteractive should be 1');
            testCase.verifyEqual(isAutoAdjust, 0, 'isAutoAdjust should be 0');
            testCase.verifyEqual(Comment, 'TestComment', 'Comment should be TestComment');
            testCase.verifyEqual(Labels, {'Label1'}, 'Labels should be {''Label1''}');
        end
    end
end
