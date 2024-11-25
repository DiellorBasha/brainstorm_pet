function userInputs = get_petsurfer_inputs()
    % GET_PETSURFER_INPUTS: Create a dialog box for entering PETSurfer inputs with a "Browse..." button for PET directory.

    % Define the HTML content for the dialog box
    dlgHtml = [...
        '<HTML><BODY>', ...
        '<H2>Enter PETSurfer Parameters</H2>', ...
        '<TABLE>', ...
        '<TR><TD><B>PET Directory:</B></TD>', ...
        '<TD><BUTTON ONCLICK="matlab.ui.FolderBrowserDialog()">Browse...</BUTTON></TD></TR>', ...
        '<TR><TD><B>Tracer Name:</B></TD><TD><INPUT TYPE="text" NAME="tracer" VALUE="18Fflortaucipir" SIZE="40"></TD></TR>', ...
        '<TR><TD><B>Reference Region:</B></TD><TD><INPUT TYPE="text" NAME="refregion" VALUE="Cerebellum-Cortex" SIZE="40"></TD></TR>', ...
        '<TR><TD><B>FWHM :</B></TD><TD><INPUT TYPE="text" NAME="fwhm" VALUE="2.8" SIZE="10"></TD></TR>', ...
        '<TR><TD><B>Number of Threads:</B></TD><TD><INPUT TYPE="text" NAME="threads" VALUE="1" SIZE="10"></TD></TR>', ...
        '</TABLE>', ...
        '<BR><I>Provide the necessary parameters for the PETSurfer process.<BR>Click OK to proceed or Cancel to abort.</I>', ...
        '</BODY></HTML>'];

    % Open the dialog box
    [result, isCancel] = java_dialog('input', dlgHtml, 'PETSurfer Inputs', [], '');
    
    % Handle cancellation
    if isCancel
        userInputs = [];
        return;
    end

    % Handle the folder selection for the PET directory
    PETDir = uigetdir('', 'Select PET Directory');
    if PETDir == 0  % User canceled folder selection
        userInputs = [];
        return;
    end

    % Parse the results for other inputs
    inputLines = strsplit(result, '\n'); % Each input is separated by a newline
    userInputs = struct();
    userInputs.petdir = PETDir; % Use the selected PET directory
    for i = 1:length(inputLines)
        line = strtrim(inputLines{i});
        if ~isempty(line)
            [key, value] = strtok(line, '=');
            value = strtrim(strrep(value, '=', ''));
            switch lower(strtrim(key))
                case 'tracer', userInputs.tracer = value;
                case 'refregion', userInputs.refregion = value;
                case 'fwhm', userInputs.fwhm = str2double(value);
                case 'threads', userInputs.threads = str2double(value);
            end
        end
    end
end
