classdef test_import_pet_gunzip < matlab.unittest.TestCase
    properties (Constant)
        TestDataDir = fullfile(pwd, 'test_data', 'test_pet_nifti');  % Directory containing all test NIfTI files
    end
    
    properties
        TestFiles  % Stores all test files retrieved from the directory
    end
    
    methods (TestMethodSetup)
        function loadTestFiles(testCase)
            % Load all .nii and .nii.gz files in the TestDataDir
            files = dir(fullfile(testCase.TestDataDir, '*.gz*'));
            testCase.TestFiles = arrayfun(@(f) fullfile(f.folder, f.name), files, 'UniformOutput', false);
        end
    end
    
    methods (Test)
        function testGunzippingFunction(testCase)
            % Test import_pet_gunzip on each file in TestFiles
            for i = 1:numel(testCase.TestFiles)
                PetFile = testCase.TestFiles{i};
                [~, ~, ext] = fileparts(PetFile);
                
                try
                    % Run the import_pet_gunzip function
                    [unzippedFile, TmpDir, Comment, fBase, fPath] = import_pet_gunzip(PetFile);
                    
                    % Check if the file was handled correctly based on its type
                    if strcmpi(ext, '.gz')
                        % .nii.gz files should be decompressed
                        testCase.verifyNotEmpty(TmpDir, 'Expected TmpDir to be non-empty for .gz file');
                        testCase.verifyTrue(exist(unzippedFile, 'file') == 2, 'Decompressed file does not exist');
                        testCase.verifyEqual(Comment, fBase, 'Comment should match the base file name');
                    elseif strcmpi(ext, '.nii')
                        % .nii files should pass through without decompression
                        testCase.verifyEmpty(TmpDir, 'Expected TmpDir to be empty for .nii file');
                        testCase.verifyEqual(unzippedFile, PetFile, 'Expected file path to be unchanged for .nii file');
                    end
                    
                catch ME
                    if exist(PetFile, 'file') == 0
                        % Verify error is thrown for non-existent files
                        testCase.verifyError(@() import_pet_gunzip(PetFile), 'MATLAB:nonExistentFile', ...
                            ['Expected error for missing file: ', PetFile]);
                    else
                        % Rethrow any unexpected errors
                        rethrow(ME);
                    end
                end
            end
        end
    end
end
