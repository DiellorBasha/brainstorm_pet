classdef test_import_pet_gunzip < matlab.unittest.TestCase
    properties (TestParameter)
        % Define test cases for different types of PetFile inputs
        PetFile = {
            'valid_pet.nii.gz',  % A valid gzipped file
            'non_gzipped_pet.nii',  % A valid non-gzipped file
            'invalid_file.nii.gz'  % An invalid/nonexistent gzipped file
        }
        ExpectedComment = {'valid_pet', 'non_gzipped_pet', ''};
        ShouldThrowError = {false, false, true};  % Expected behavior for error handling
    end
    
    methods (Test, ParameterCombination='sequential')
        function testGunzipFile(testCase, PetFile, ExpectedComment, ShouldThrowError)
            % Set up: Create temp directory and prepare files
            tmpDir = tempname;
            mkdir(tmpDir);
            addpath(tmpDir);
            
            try
                % Create valid gzipped file or non-gzipped file if applicable
                if strcmp(PetFile, 'valid_pet.nii.gz')
                    gzFile = fullfile(tmpDir, PetFile);
                    fid = fopen(gzFile, 'w');
                    fwrite(fid, 'sample gzipped data');
                    fclose(fid);
                elseif strcmp(PetFile, 'non_gzipped_pet.nii')
                    nonGzFile = fullfile(tmpDir, PetFile);
                    fid = fopen(nonGzFile, 'w');
                    fwrite(fid, 'sample non-gzipped data');
                    fclose(fid);
                end
                
                % Run the import_pet_gunzip function and handle expectations
                if ShouldThrowError
                    testCase.verifyError(@() import_pet_gunzip(fullfile(tmpDir, PetFile)), ...
                        'MATLAB:nonExistentFile');
                else
                    [PetFileOut, TmpDir, Comment, fBase, fPath] = import_pet_gunzip(fullfile(tmpDir, PetFile));
                    
                    % Verify TmpDir for gzipped files
                    if contains(PetFile, '.gz')
                        testCase.verifyNotEmpty(TmpDir, 'Expected TmpDir to be non-empty for .gz file');
                    else
                        testCase.verifyEmpty(TmpDir, 'Expected TmpDir to be empty for non-.gz file');
                    end
                    
                    % Verify the output Comment matches expected
                    testCase.verifyEqual(Comment, ExpectedComment, 'Unexpected comment returned');
                    
                    % Verify PetFileOut exists and is as expected
                    testCase.verifyTrue(exist(PetFileOut, 'file') == 2, 'Output file does not exist');
                end
            catch ex
                % Rethrow error if unexpected
                if ~ShouldThrowError
                    rethrow(ex);
                end
            end
            
            % Teardown: Remove temp directory and files
            rmdir(tmpDir, 's');
        end
    end
end
