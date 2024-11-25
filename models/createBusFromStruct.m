function busObj = createBusFromStruct(inputStruct, busName)
% CREATEBUSFROMSTRUCT Recursively creates a Simulink.Bus object from a nested structure.
%
% Inputs:
%   inputStruct - The MATLAB structure to convert into a bus.
%   busName - (Optional) Name of the bus to be created. If not provided,
%             a default name 'BusObject' will be used.
%
% Output:
%   busObj - A Simulink.Bus object representing the input structure.

if nargin < 2
    busName = 'BusObject';  % Default name if none provided
end

% Get the field names of the structure
fieldNames = fieldnames(inputStruct);
busElements = repmat(Simulink.BusElement, numel(fieldNames), 1);  % Preallocate

% Loop through each field in the structure
for i = 1:numel(fieldNames)

    fieldName = fieldNames{i};
    fieldValue = inputStruct.(fieldName);
    if isa(fieldValue, 'function_handle')
        fieldValue = func2str(fieldValue);  % Convert to string
    end
    % Create a new BusElement for each field
    busElements(i) = Simulink.BusElement;
    busElements(i).Name = fieldName;

    % Determine the data type and dimensions
    if isempty(fieldValue)
        if isstruct(fieldValue)
            % Create a nested bus for empty nested structures
            nestedBus = createBusFromStruct(struct([]), fieldName);
            assignin('base', fieldName, nestedBus);
            busElements(i).DataType = ['Bus: ', fieldName];
            busElements(i).DimensionsMode = 'Variable';
        else
            % For empty non-structures, set as a scalar double with default value 0
            busElements(i).DataType = 'double';
            busElements(i).Dimensions = 1;
            busElements(i).DimensionsMode = 'Fixed';
        end
    elseif isobject(fieldValue)
        % If the field is an object, treat it as a double with a default value of 0
        busElements(i).DataType = 'double';
        busElements(i).Dimensions = 1;
        busElements(i).DimensionsMode = 'Fixed';
    elseif isstruct(fieldValue)
        % If the field is a nested structure, recursively create a bus
        nestedBus = createBusFromStruct(fieldValue, fieldName);
        assignin('base', fieldName, nestedBus);  % Assign the nested bus to the base workspace
        busElements(i).DataType = ['Bus: ', fieldName];
    elseif iscell(fieldValue)
        % Handle specific cell array cases
        if strcmp(fieldName, 'InitTransf') && numel(fieldValue) == 2
            % Handle InitTransf as a structured bus element
            initTransfStruct = struct('Label', fieldValue{1}, 'Matrix', fieldValue{2});
            nestedBus = createBusFromStruct(initTransfStruct, 'InitTransf');
            assignin('base', 'InitTransf', nestedBus);  % Assign the nested bus to the base workspace
            busElements(i).DataType = 'Bus: InitTransf';
        elseif iscellstr(fieldValue)
            %|| all(cellfun(@ischar, fieldValue))
            % Handle History or other homogeneous cell arrays of strings
            busElements(i).DataType = 'string';
            % busElements(i).Dimensions = -1;  % Variable dimensions to allow for a variable number of entries
            busElements(i).DimensionsMode = 'Variable';
        else
            error(['Unsupported cell array type for field ', fieldName]);
        end
    elseif isnumeric(fieldValue)
        % Handle numeric types
        if isa(fieldValue, 'double')
            busElements(i).DataType = 'double';
        elseif isa(fieldValue, 'single')
            busElements(i).DataType = 'single';
        elseif isa(fieldValue, 'int8')
            busElements(i).DataType = 'int8';
        elseif isa(fieldValue, 'uint8')
            busElements(i).DataType = 'uint8';
        elseif isa(fieldValue, 'int16')
            busElements(i).DataType = 'int16';
        elseif isa(fieldValue, 'uint16')
            busElements(i).DataType = 'uint16';
        elseif isa(fieldValue, 'int32')
            busElements(i).DataType = 'int32';
        elseif isa(fieldValue, 'uint32')
            busElements(i).DataType = 'uint32';
        elseif isa(fieldValue, 'int64')
            busElements(i).DataType = 'int64';
        elseif isa(fieldValue, 'uint64')
            busElements(i).DataType = 'uint64';
        end
    elseif islogical(fieldValue)
        % Handle logical types
        busElements(i).DataType = 'boolean';
    elseif ischar(fieldValue) || isstring(fieldValue)
        % Handle strings and character arrays
        busElements(i).DataType = 'string';
    else
        % For unsupported data types, throw an error
        error(['Unsupported data type for field ', fieldName]);
    end

    % Set variable dimensions for all elements
    % busElements(i).Dimensions = -1;
    busElements(i).DimensionsMode = 'Variable';

end

% Create the bus object
busObj = Simulink.Bus;
busObj.Elements = busElements;

% Assign the top-level bus object to the base workspace
assignin('base', busName, busObj);

end
