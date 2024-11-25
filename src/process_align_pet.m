function varargout = process_align_pet( varargin )
% PROCESS_ALIGN_PET: Align PET frames to a selected reference frame .

% @=============================================================================
% This function is part of the Brainstorm software:
% https://neuroimage.usc.edu/brainstorm
%
% Copyright (c) University of Southern California & McGill University
% This software is distributed under the terms of the GNU General Public License
% as published by the Free Software Foundation. Further details on the GPLv3
% license can be found at http://www.gnu.org/copyleft/gpl.html.
%
% FOR RESEARCH PURPOSES ONLY. THE SOFTWARE IS PROVIDED "AS IS," AND THE
% UNIVERSITY OF SOUTHERN CALIFORNIA AND ITS COLLABORATORS DO NOT MAKE ANY
% WARRANTY, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO WARRANTIES OF
% MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, NOR DO THEY ASSUME ANY
% LIABILITY OR RESPONSIBILITY FOR THE USE OF THIS SOFTWARE.
%
% For more information type "brainstorm license" at command prompt.
% =============================================================================@

%% ===== GET DESCRIPTION =====

%% ===== FORMAT COMMENT =====

%% ===== RUN =====

% ===== GET OPTIONS =====

% ===== GET SUBJECT =====

nFrames = size(sMri.Cube, 4);
RegMethod = 'SPM';


s_width = 7;
s_sigma = 1;

kernel = fspecial3("gaussian",s_width,s_sigma);

% Smooth each PET Frame
for k = 1:nFrames
    sMri.Cube(:,:,:,k) = convn(sMri.Cube(:,:,:,k), kernel, "same");
end

petSum = sum(sMri.Cube,4);

%Load anatomical MRI

[sMriNew, Transf, errMsg] = mri_resample(MriFile, CubeDim, Voxsize, Method);
[MriFileReg, errMsg, fileTag, sMriReg] = mri_reslice(MriFileSrc, MriFileRef, TransfSrc, TransfRef, isAtlas)


[Labels, AtlasName] = mri_getlabels(MriFile, sMri, isForced)



