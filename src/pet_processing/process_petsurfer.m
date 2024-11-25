function varargout = process_petsurfer(varargin)
% PROCESS_PETSURFER: Execute the PETSurfer pipeline for PET data processing.

% Call macro method
eval(macro_method);
end

%% ===== GET DESCRIPTION =====
function sProcess = GetDescription()
    % Process description
    sProcess.Comment     = 'Run PETSurfer Pipeline';
    sProcess.Category    = 'Custom';
    sProcess.SubGroup    = {'Preprocess', 'PET Analysis'};
    sProcess.Index       = 50;
    % Input/output types
    sProcess.InputTypes  = {'import'};
    sProcess.OutputTypes = {'import'};
    sProcess.nInputs     = 1;
    sProcess.nMinFiles   = 0;
    % Options
    % Subject name
    sProcess.options.subjectname.Comment = 'Subject name:';
    sProcess.options.subjectname.Type    = 'subjectname';
    sProcess.options.subjectname.Value   = '';
    % PET directory
    sProcess.options.petdir.Comment = 'PET directory:';
    sProcess.options.petdir.Type    = 'file';
    sProcess.options.petdir.Value   = '';
    % Tracer name
    sProcess.options.tracer.Comment = 'Tracer name:';
    sProcess.options.tracer.Type    = 'text';
    sProcess.options.tracer.Value   = '18Fflortaucipir';
    % Reference region
    sProcess.options.refregion.Comment = 'Reference region (SUVR):';
    sProcess.options.refregion.Type    = 'text';
    sProcess.options.refregion.Value   = 'Cerebellum-Cortex';
    % FWHM
    sProcess.options.fwhm.Comment = 'FWHM for smoothing:';
    sProcess.options.fwhm.Type    = 'value';
    sProcess.options.fwhm.Value   = {2.8, 'mm', 0};
    % Threads
    sProcess.options.threads.Comment = 'Number of threads:';
    sProcess.options.threads.Type    = 'value';
    sProcess.options.threads.Value   = {1, '', 0};
end

%% ===== FORMAT COMMENT =====
function Comment = FormatComment(sProcess)
    Comment = sProcess.Comment;
end

%% ===== RUN =====
function OutputFiles = Run(sProcess, sInputs)
    OutputFiles = {};

    % Extract options
    SubjectName = sProcess.options.subjectname.Value;
    PETDir = sProcess.options.petdir.Value;
    Tracer = sProcess.options.tracer.Value;
    RefRegion = sProcess.options.refregion.Value;
    FWHM = sProcess.options.fwhm.Value{1};
    Threads = sProcess.options.threads.Value{1};

    % Validate inputs
    if isempty(SubjectName) || isempty(PETDir) || isempty(Tracer)
        bst_report('Error', sProcess, [], 'Subject name, PET directory, and tracer are required.');
        return;
    end

    % Verify FreeSurfer setup
    if isempty(getenv('FREESURFER_HOME')) || isempty(getenv('SUBJECTS_DIR'))
        bst_report('Error', sProcess, [], ...
            'FreeSurfer environment variables are not set. Please ensure FREESURFER_HOME and SUBJECTS_DIR are configured.');
        return;
    end

    % Prepare command
    petsurferScript = '/path/to/petsurfer.sh';
    cmd = sprintf('%s -s %s -p "%s" -t %s -r "%s" -f %.2f -n %d', ...
        petsurferScript, SubjectName, PETDir, Tracer, RefRegion, FWHM, Threads);

    % Execute script
    bst_progress('text', 'Running PETSurfer pipeline...');
    disp(['Executing command: ' cmd]);
    [status, cmdOutput] = system(cmd);

    % Handle errors
    if status ~= 0
        bst_report('Error', sProcess, [], ['PETSurfer pipeline failed: ' cmdOutput]);
        return;
    end

    % Optionally: Import results into Brainstorm (e.g., PET overlays)
    % This step can be added to integrate PET data into Brainstorm.

    bst_report('Info', sProcess, [], 'PETSurfer pipeline completed successfully.');
end
