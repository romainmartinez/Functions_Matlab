function new(fileType, filename)
%NEW - Open new m-file with both documented and dynamical headers
%   This function creates a new class/function/script following the same
%   behaviour as the "new file" desktop short-cut, except that headers are
%   dynamically implemented, customizable and adapted for further code
%   documentation.
%
%   The function comes with 3 default headers corresponding to 'class',
%   'function' and 'script' files. Feel free to adapt these header files to
%   your own needs. They have been implemented based on the template
%   headers proposed by Denis Gilbert, in order to facilitate the further
%   code documentation (using mtoc++/doxygen for example).
%
%   Even if the templates are customizable, some part is implemented
%   dynamically during the opening of the new class/function/script, such
%   as date of creation, file name, copyright year, etc.
%
%   Add command to Shortcut panel: 
%   - On the Home tab, click New, and then select Command Shortcut. Or
%   click on the "New Shortcut" in the quick access toolbar.
%   - In the Shortcut Editor, choose a "Label" (such as "new function"), an
%   Icon (such as "f") and fill the "Callback" edit text panel with the
%   corresponding command (such as "new('f')").
%   - Click "Save". That's all. Whenever you want to change the headers'
%   format, edit the corresponding file('default_function', 'default_class'
%   or 'default_script') and save changes.
%
%   That's all. Whenever you want to change the headers' format, edit the
%   corresponding files ('default_function', 'default_class' or
%   'default_script') and save changes.
%
%   Syntax:  
%       NEW()
%       NEW(fileType)
%       NEW(fileType, filename)
%
%   Description:
%       NEW() - creates a script buffer "UntitledN" using script template
%       NEW(fileType) - creates a function/class/script buffer using the 
%       corresponding fileType template
%       NEW(fileType, filename) - creates function/class/script file 
%       "filename.m" using the corresponding fileType template
%    
%   Inputs:
%       FILETYPE - string containing the file type ('function', 'class' or
%       'script')
%       FILENAME (optional) - string containing the file name (with or
%       without '.m' extension)
%
%   Examples: 
%       NEW('class') creates a new class buffer named "UntitledN" using the
%       corresponding class template
%       NEW('function', 'myfun.m') creates a new function "myfun.m" using
%       the corresponding function template
%
%   Other m-files required: none
%   Subfunctions: getMethodAmongAvailableMethods, getFileName
%   MAT-files required: none
%
%   See also: TEDIT, TEMPLATE_HEADER, NEWF, MTOC++ (DOXYGEN)

%   Author: Dr. Benjamin Pillot
%   Address: Universidade do Vale do Rio dos Sinos (Unisinos), São
%   Leopoldo, RS, Brazil
%   email: benjaminfp@unisinos.br
%   Website: http://www.
%   Date: 08-may-2016; Last revision: 11-may-2016
%
%   Copyright (c) 2016, Benjamin Pillot
%   All rights reserved.

narginchk(0, 2);

if nargin == 0
    fileType = 'script';
end

try
    fileType = getMethodAmongAvailableMethods(fileType, {'class', 'function', 'script'});
catch
    error('Invalid file type. Must be one of those : ''class'', ''function'', ''script''');
end

switch fileType
    
    case 'class'
        default_template = 'default_class';
        
    case 'function'
        default_template = 'default_function';
        
    case 'script'
        default_template = 'default_script';
        
end

file = matlab.desktop.editor.newDocument();
if nargin == 2
    file.saveAs(getFileName(filename));
end

try
    
    fid = fopen(default_template, 'r');
    line = fgetl(fid);
    header = [];
    [~, filename, ~] = fileparts(file.Filename);
    
    while ~feof(fid)
        
        if strfind(line, '$name')
            line = strrep(line, '$name', filename);
        elseif strfind(line, '$NAME')
            line = strrep(line, '$NAME', upper(filename));
        end
        
        if strfind(line, '$date')
            line = strrep(line, '$date', date);
        elseif strfind(line, '$year')
            line = strrep(line, '$year', num2str(year(date)));
        end
        
        header = [header line 10]; %#ok<AGROW>
        line = fgetl(fid);
    end
    
    file.appendText(header);
    fclose(fid);
    
catch exception
    
    throw(exception)
    
end



function method = getMethodAmongAvailableMethods( method, availableMethods )

method = availableMethods{strncmpi(method, availableMethods, length(method))};


function filename = getFileName(shortFilename)

dot = strfind(shortFilename, '.');
if ~isempty(dot)
    filename = shortFilename(1 : dot(1) - 1);
else
    filename = shortFilename;
end
filename = [pwd, filesep, matlab.lang.makeValidName(filename), '.m'];

    
