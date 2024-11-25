function OutputFiles = run_petsurfer_process(sProcess)
OutputFiles = {};

% Extract options
SubjectName = sProcess.options.subjectname.Value;
PETDir = sProcess.options.petdir.Value;
Tracer = sProcess.options.tracer.Value;
RefRegion = sProcess.options.refregion.Value;
FWHM = sProcess.options.fwhm.Value{1};
Threads = sProcess.options.threads.Value{1};

% Validate inputs
if ~validate_inputs(SubjectName, PETDir, Tracer)
    return;
end

% Prepare and execute command
petsurferScript = 'petsurfer.sh';
cmd = prepare_petsurfer_command(petsurferScript, SubjectName, PETDir, Tracer, RefRegion, FWHM, Threads);
run_shell_command(cmd, sProcess);

% Optionally import results into Brainstorm
% import_petsurfer_results(sProcess, SubjectName);

end
