function data = importABfile(filename, startRow, endRow)
%IMPORTFILE Import numeric data from a text file as a matrix.
%   DAVOH12H1 = IMPORTFILE(FILENAME) Reads data from text file FILENAME for
%   the default selection.
%
%   DAVOH12H1 = IMPORTFILE(FILENAME, STARTROW, ENDROW) Reads data from rows
%   STARTROW through ENDROW of text file FILENAME.
%
% Example:
%   DavOH12H1 = importfile('DavOH12H2_1.txt', 38, 685);

%% Initialize variables.
delimiter = ' ';
if nargin<=2
    startRow = 38;
    endRow = inf;
end

%% Format string for each line of text:
formatSpec = '%*q%f%f%f%f%f%f%f%f%f%f%f%f%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'HeaderLines', startRow(1)-1, 'ReturnOnError', false);
for block=2:length(startRow)
    frewind(fileID);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'HeaderLines', startRow(block)-1, 'ReturnOnError', false);
    for col=1:length(dataArray)
        dataArray{col} = [dataArray{col};dataArrayBlock{col}];
    end
end

%% Close the text file.
fclose(fileID);

%% Create output variable
data = [dataArray{1:end-1}];