function sProcess = define_petsurfer_process()
% Define options and metadata for the PETSurfer process
sProcess.Comment = 'Run PETSurfer Pipeline';
sProcess.Category = 'Custom';
sProcess.SubGroup = {'Preprocess', 'PET Analysis'};
sProcess.Index = 50;

% Input/output types
sProcess.InputTypes = {'import'};
sProcess.OutputTypes = {'import'};
sProcess.nInputs = 1;
sProcess.nMinFiles = 0;

% Options
sProcess.options.subjectname.Comment = 'Subject name:';
sProcess.options.subjectname.Type = 'subjectname';
sProcess.options.subjectname.Value = '';

sProcess.options.petdir.Comment = 'PET directory:';
sProcess.options.petdir.Type = 'file';
sProcess.options.petdir.Value = '';

sProcess.options.tracer.Comment = 'Tracer name:';
sProcess.options.tracer.Type = 'text';
sProcess.options.tracer.Value = '18Fflortaucipir';

sProcess.options.refregion.Comment = 'Reference region (SUVR):';
sProcess.options.refregion.Type = 'text';
sProcess.options.refregion.Value = 'Cerebellum-Cortex';

sProcess.options.fwhm.Comment = 'FWHM for smoothing:';
sProcess.options.fwhm.Type = 'value';
sProcess.options.fwhm.Value = {2.8, 'mm', 0};

sProcess.options.threads.Comment = 'Number of threads:';
sProcess.options.threads.Type = 'value';
sProcess.options.threads.Value = {1, '', 0};
end
