classdef Test_import_pet < matlab.unittest.TestCase
    methods(Test)
        
        
        function testDefaultInputs(testCase)
         
            % Check if Brainstorm is running
          if isempty(bst_get ('isGUI'))
              brainstorm
          end
          
          % Test 1: No inputs provided (except for required ones)
            iSubject = 1;
            PetFile = '';
            [BstPetFile, sPet, Messages] = import_pet(iSubject, PetFile);
            
            % Verify that default values are assigned
            testCase.verifyEqual(BstPetFile, [], 'BstPetFile should be empty');
            testCase.verifyEqual(sPet, [], 'sPet should be empty');
            testCase.verifyEqual(Messages, [], 'Messages should be empty');
        end
        
        function testPartialInputs(testCase)
           
                        % Check if Brainstorm is running
          if isempty(bst_get ('isGUI'))
              brainstorm
          end
            
            % Test 2: Some inputs provided, others missing
            iSubject = 1;
            PetFile = '';
            FileFormat = 'Nifti';
            isInteractive = 1;
            
            [BstPetFile, sPet, Messages] = import_pet(iSubject, PetFile, FileFormat, isInteractive);
            
            % Verify that the provided inputs are used and defaults are applied for missing inputs
            testCase.verifyEqual(BstPetFile, [], 'BstPetFile should be empty');
            testCase.verifyEqual(sPet, [], 'sPet should be empty');
            testCase.verifyEqual(Messages, [], 'Messages should be empty');
            testCase.verifyEqual(FileFormat, 'Nifti', 'FileFormat should be Nifti');
            testCase.verifyEqual(isInteractive, 1, 'isInteractive should be 1');
        end
        
        function testAllInputsProvided(testCase)
           
                        % Check if Brainstorm is running
          if isempty(bst_get ('isGUI'))
              brainstorm
          end
            
            % Test 3: All inputs provided
            iSubject = 1;
            PetFile = '';
            FileFormat = 'DICOM';
            isInteractive = 1;
            isAutoAdjust = 0;
            Comment = 'TestComment';
            Labels = {'Label1'};
            
            [BstPetFile, sPet, Messages] = import_pet(iSubject, PetFile, FileFormat, isInteractive, isAutoAdjust, Comment, Labels);
            
            % Verify that all provided inputs are used
            testCase.verifyEqual(BstPetFile, [], 'BstPetFile should be empty');
            testCase.verifyEqual(sPet, [], 'sPet should be empty');
            testCase.verifyEqual(Messages, [], 'Messages should be empty');
            testCase.verifyEqual(FileFormat, 'DICOM', 'FileFormat should be DICOM');
            testCase.verifyEqual(isInteractive, 1, 'isInteractive should be 1');
            testCase.verifyEqual(isAutoAdjust, 0, 'isAutoAdjust should be 0');
            testCase.verifyEqual(Comment, 'TestComment', 'Comment should be TestComment');
            testCase.verifyEqual(Labels, {'Label1'}, 'Labels should be {''Label1''}');
        end
    end
end
