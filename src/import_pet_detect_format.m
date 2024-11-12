function FileFormat = import_pet_detect_format(PetFile, FileFormat)
%IMPORT_PET_DETECT_FORMAT 

[fPathTmp, fBase, fExt] = bst_fileparts(PetFile);

%% ===== DETECT FILE FORMAT =====

if ismember(FileFormat, {'ALL'})
    % Switch between file extensions
    switch (lower(fExt))
        case {'.img','.hdr','.nii'},   FileFormat = 'Nifti1';
                case '.mat',                   FileFormat = 'BST';
        case {'.mgz','.mgh'},          FileFormat = 'MGH';
        case {'.mnc','.mni'},          FileFormat = 'MINC';

        otherwise,                    error('File format could not be detected, please specify a file format.');
    end
end
end

