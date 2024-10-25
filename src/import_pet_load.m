function sPet = import_pet_load(PetFile, volType, FileFormat, isInteractive)
    % Initialize the output
    sPet = [];
    
    % Check if a progress bar is already visible
    isProgress = bst_progress('isVisible');
    if ~isProgress
        % Start a new progress bar
        bst_progress('start', ['Import ', volType], ['Loading ', volType, ' file...']);
    end
    
    % Load the PET file without normalization
    isNormalize = 0;
    sPet = in_pet(PetFile{1}, FileFormat, isInteractive, isNormalize);
    
    % If loading failed, stop progress and return
    if isempty(sPet)
        bst_progress('stop');
        return;
    end
    
    % Add history entry with the source file name
    if iscell(PetFile)
        sPet = bst_history('add', sPet, 'import', ['Import from: ', PetFile{1}]);
    else
        sPet = bst_history('add', sPet, 'import', ['Import from: ', PetFile]);
    end
end
