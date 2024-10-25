classdef test_import_pet_load < matlab.unittest.TestCase
    properties
        TmpDir
        GzFile
        DecompressedFile
        VolType
        FileFormat
        IsInteractive
    end
    
    methods (TestMethodSetup)
        function setupFiles(testCase)
            % Set up a temporary directory and a sample .gz file
            testCase.TmpDir = tempname;
            mkdir(testCase.TmpDir);
            testCase.GzFile = fullfile(testCase.TmpDir, 'sample_pet.nii.gz');
            testCase.DecompressedFile = fullfile(testCase.TmpDir, 'sample_pet.nii');
            
            % Create a sample .gz file to simulate PET data
            fid = fopen(testCase.GzFile, 'w');
            fwrite(fid, 'sample compressed data');
            fclose(fid);
            
            % Define parameters for loading
            testCase.VolType = 'PET';
            testCase.FileFormat = 'NIfTI';
            testCase.IsInteractive = false;
            
            % Mock bst_get to return the temporary directory for decompression
            addpath(testCase.TmpDir);
        end
    end
    
    methods (TestMethodTeardown)
        function cleanupFiles(testCase)
            % Clean up the temporary directory and files after tests
            rmdir(testCase.TmpDir, 's');
        end
    end
    
    methods (Test)
        function testLoadDecompressedFile(testCase)
            % Run import_pet_gunzip to decompress the file
            [PetFile, TmpDir, Comment, fBase, fPath] = import_pet_gunzip(testCase.GzFile);
            
            % Ensure the decompressed file path matches
            testCase.verifyEqual(PetFile, testCase.DecompressedFile);
            
            % Now call import_pet_load using the decompressed file
            sPet = import_pet_load({PetFile}, testCase.VolType, testCase.FileFormat, testCase.IsInteractive);
            
            % Check that sPet is loaded correctly (non-empty)
            testCase.verifyNotEmpty(sPet, 'Failed to load PET data structure');
            
            % Check that the history comment matches the expected file path
            expectedComment = ['Import from: ', PetFile];
            historyEntry = bst_history('get', sPet, 'import');
            testCase.verifyTrue(contains(historyEntry, expectedComment), ...
                'History entry should contain the decompressed file path');
        end
    end
end
