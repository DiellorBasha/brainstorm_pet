function interactive_petsurfer(iSubject) %#ok<DEFNU>
    % Check subject input
    if nargin < 1 || isempty(iSubject)
        bst_error('Subject is required for the PETSurfer process.', 'PETSurfer', 0);
        return;
    end
    
    % Ask for PET directory
    PETDir = java_dialog('input', ...
        '<HTML>Path to PET Directory:<BR><FONT color="#707070">Provide the path to the directory containing the PET files.</FONT>', ...
        'PET Directory', [], '');
    if isempty(PETDir)
        return;
    end
    
    % Ask for tracer name
    Tracer = java_dialog('input', ...
        '<HTML>Tracer name:<BR><FONT color="#707070">Provide the tracer name (e.g., 18Fflortaucipir).</FONT>', ...
        'Tracer Name', [], '18Fflortaucipir');
    if isempty(Tracer)
        return;
    end
    
    % Ask for reference region
    RefRegion = java_dialog('input', ...
        '<HTML>Reference region for SUVR:<BR><FONT color="#707070">Default is "Cerebellum-Cortex".</FONT>', ...
        'Reference Region', [], 'Cerebellum-Cortex');
    if isempty(RefRegion)
        return;
    end
    
    % Ask for FWHM value
    FWHM = java_dialog('input', ...
        '<HTML>FWHM for smoothing:<BR><FONT color="#707070">Provide the full-width at half maximum (default is 2.8).</FONT>', ...
        'FWHM', [], '2.8');
    if isempty(FWHM)
        return;
    end
    FWHM = str2double(FWHM);
    if isnan(FWHM) || FWHM <= 0
        bst_error('Invalid FWHM value.', 'PETSurfer', 0);
        return;
    end
    
    % Ask for the number of threads
    Threads = java_dialog('input', ...
        '<HTML>Number of threads:<BR><FONT color="#707070">Default is 1.</FONT>', ...
        'Threads', [], '1');
    if isempty(Threads)
        return;
    end
    Threads = str2double(Threads);
    if isnan(Threads) || Threads <= 0
        bst_error('Invalid number of threads.', 'PETSurfer', 0);
        return;
    end
    
    % Open progress bar
    bst_progress('start', 'PETSurfer', 'Running PETSurfer pipeline...');
    
    % Execute the PETSurfer process
    try
        petsurferScript = '/path/to/petsurfer.sh';
        SubjectName = bst_get('Subject', iSubject).Name;  % Get subject name from Brainstorm
        cmd = sprintf('%s -s %s -p "%s" -t %s -r "%s" -f %.2f -n %d', ...
            petsurferScript, SubjectName, PETDir, Tracer, RefRegion, FWHM, Threads);
        
        % Execute the shell command
        disp(['Executing command: ' cmd]);
        [status, cmdOutput] = system(cmd);
        
        % Handle errors
        if status ~= 0
            bst_error(['PETSurfer pipeline failed: ' cmdOutput], 'PETSurfer', 0);
        else
            java_dialog('msgbox', 'PETSurfer pipeline completed successfully.', 'PETSurfer');
        end
    catch ME
        bst_error(['Error during PETSurfer execution: ' ME.message], 'PETSurfer', 0);
    end
    
    % Close progress bar
    bst_progress('stop');
end
