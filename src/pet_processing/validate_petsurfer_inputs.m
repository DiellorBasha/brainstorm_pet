function isValid = validate_petsurfer_inputs(SubjectName, PETDir, Tracer)
isValid = true;
if isempty(SubjectName) || isempty(PETDir) || isempty(Tracer)
    bst_report('Error', [], [], 'Subject name, PET directory, and tracer are required.');
    isValid = false;
end
if isempty(getenv('FREESURFER_HOME')) || isempty(getenv('SUBJECTS_DIR'))
    bst_report('Error', [], [], ...
        'FreeSurfer environment variables are not set. Ensure FREESURFER_HOME and SUBJECTS_DIR are configured.');
    isValid = false;
end
end
