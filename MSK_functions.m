function MSK_functions
% local functions
pathtolocal = 'C:\Users\marti\Documents\Codes\MSK\functions';
if ~contains(path, pathtolocal)
    addpath(pathtolocal)
end

% S2M library
if ~contains(path, '\\10.89.24.15\e\Librairies\S2M_Lib\')
    loadS2MLib;
end