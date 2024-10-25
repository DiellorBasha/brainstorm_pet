function [BstPetFile, sPet, Messages] = import_pet(iSubject, PetFile, FileFormat, isInteractive, isAutoAdjust, Comment, Labels)
% IMPORT_PET: Import a PET volume file in a subject of the Brainstorm database
% 
% USAGE: [BstPetFile, sPet, Messages] = import_pet(iSubject, PetFile, FileFormat='ALL', isInteractive=0, isAutoAdjust=1, Comment=[], Labels=[])
%               BstPetFiles = import_pet(iSubject, PetFiles, ...)   % Import multiple volumes at once
%
% INPUT:
%    - iSubject  : Indice of the subject where to import the PET
%                  If iSubject=0 : import PET in default subject
%    - PetFile   : Full filename of the PET to import (format is autodetected)
%                  => if not specified : file to import is asked to the user
%    - FileFormat : String, one on the file formats in in_pet
%    - isInteractive : If 1, importation will be interactive (PET is displayed after loading)
%    - isAutoAdjust  : If isInteractive=0 and isAutoAdjust=1, relice/resample automatically without user confirmation
%    - Comment       : Comment of the output file
%    - Labels        : Labels attached to this file (cell array {Nlabels x 3}: {index, text, RGB})
% OUTPUT:
%    - BstPetFile : Full path to the new file if success, [] if error
%    - sPet       : Brainstorm PET structure
%    - Messages   : String, messages reported by this function

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
%
% Authors: 

%% ===== PARSE INPUTS =====

if (nargin < 3) || isempty(FileFormat)
    FileFormat = 'ALL';
end
if (nargin < 4) || isempty(isInteractive)
    isInteractive = 0;
end
if (nargin < 5) || isempty(isAutoAdjust)
    isAutoAdjust = 1;
end
if (nargin < 6) || isempty(Comment)
    Comment = [];
end
if (nargin < 7) || isempty(Labels)
    Labels = [];
end

% Initialize returned variables
BstMriFile = [];
sMri = [];
Messages = [];
% Get Protocol information
ProtocolInfo     = bst_get('ProtocolInfo');
ProtocolSubjects = bst_get('ProtocolSubjects');
% Default subject
if (iSubject == 0)
	sSubject = ProtocolSubjects.DefaultSubject;
% Normal subject 
else
    sSubject = ProtocolSubjects.Subject(iSubject);
end
% Volume type
volType = 'MRI';
if ~isempty(strfind(Comment, 'CT'))
    volType = 'CT';
end
% Get node comment from filename
if ~isempty(strfind(Comment, 'Import'))
    Comment = [];
end


%% ===== SELECT PET FILE =====

%% ===== EXTRACT PET FRAMES =====

%% ===== DICOM CONVERTER =====

%% ===== LOOP ON MULTIPLE PET =====

%% ===== LOAD PET FILE =====

%% ===== DELETE TEMPORARY FILES =====

%% ===== MANAGE MULTIPLE PET =====

   %% ===== SAVE PET IN BRAINSTORM FORMAT =====

   %% ===== SAVE FILE =====

   %% ===== REFERENCE NEW PET IN DATABASE ======

   %% ===== UPDATE GUI =====

   %% ===== PET VIEWER =====