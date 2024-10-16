function fs_suvr (subjectsDir, sourceSubject, inputVolume)

% calculate the mean uptake in the cerebellum
cmd = ['mri_segstats ' ...
    '-- i ' inputVolume ...
    '--seg ' gtmseg ...
    '--id ' 7 8 46 45 ...
    '--avgwf ' avg_reference_region.txt];

% calculate voxel-wise SUVR

reference_mean=  avg_reference_region.txt;

cmd = ['mri_calculate ' ...
    '-in ' inputVolume ...
    '--out' suvr.mgz ...
    '--div ' reference_mean]
end