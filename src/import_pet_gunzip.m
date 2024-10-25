function [PetFile, TmpDir, Comment, fBase, fPath] = import_pet_gunzip(PetFile)
    % Initialize temporary directory as empty
    TmpDir = [];
    
    % Check if PetFile is a single file (not a cell array)
    if ~iscell(PetFile)
        % Get file parts: path, base name, and extension
        [fPath, fBase, fExt] = bst_fileparts(PetFile);
        
        % If the file is gzipped
        if strcmpi(fExt, '.gz')
            % Get a temporary directory from Brainstorm for importpet
            TmpDir = bst_get('BrainstormTmpDir', 0, 'importpet');
            % Define the path for the unzipped file
            gunzippedFile = bst_fullfile(TmpDir, fBase);
            % Unzip the file
            res = org.brainstorm.file.Unpack.gunzip(PetFile, gunzippedFile);
            
            % Error if gunzipping fails
            if ~res
                error(['Could not gunzip file "' PetFile '" to:' 10 gunzippedFile]);
            end
            
            % Update PetFile to the path of the gunzipped file
            PetFile = gunzippedFile;
            % Update file parts for the gunzipped file
            [fPath, fBase, fExt] = bst_fileparts(PetFile);
        end
        
        % Set the comment based on the file base name
        Comment = fBase;
    else
        % If PetFile is a cell array, use default values
        Comment = 'PET';
        fBase = [];
        fPath = [];
    end
end
