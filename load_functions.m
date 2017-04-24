function path2 = load_functions(varargin)
% |load S2M library       |
% |load personnal library |
% |load local functions   |

% input :
%   1: varargin{1} = OS ('linux', 'windows', 'perso')
%   2: varargin{2} = code directory (root folder where personnal functions are)


if varargin{1} == 'linux'
    path2.E = '/media/E';
    path2.F = '/media/F';
    path2.codes = '/home/romain/Documents/codes';
elseif varargin{1} == 'windows'
    path2.E = '//10.89.24.15/e';
    path2.F = '//10.89.24.15/f';
    path2.codes = 'C:/Users/marti/Documents/Codes';
else
    path2.E = uigetdir(matlabroot,'Choose the E drive');
    path2.F = uigetdir(matlabroot,'Choose the F drive');
    path2.F = uigetdir(matlabroot,'Choose the codes folder');
end

% S2M library
if ~contains(path, [path2.E '/Librairies/S2M_Lib/'])
    try
        run([path2.E '/Librairies/S2M_Lib/S2MLibPicker.m'])
    catch
        warning('cannot load S2M library');
    end
end

% personnal library
if ~contains(path, [path2.codes '/Functions_Matlab'])
    try
        addpath(genpath([path2.codes '/Functions_Matlab']))
    catch
        warning('cannot load personnal library');
    end
end

% local functions
cd([path2.codes '/' varargin{2} '/functions'])
