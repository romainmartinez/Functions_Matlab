function [oldlabel] = GUI_renameforce(field, channel)
%   Description:
%       GUI_renameforce is used get the proper analog channel for the force
%       sensor
%   Output:
%       GUI_renameforce give label of force analog channel
%   Functions:
%       GUI_renameforce uses functions present in \\10.89.24.15\e\Project_IRSST_LeverCaisse\Codes\Functions_Matlab
%
%   Author:  Romain Martinez
%   email:   martinez.staps@gmail.com
%   Website: https://github.com/romainmartinez
%   Date:    26-Nov-2016; Last revision: 28-Nov-2016
%_____________________________________________________________________________
index    = 1;
oldlabel = [];
% Figure
handles(1) = figure('units','pixels',...
    'position',[500 500 500 500],...
    'menubar','none',...
    'numbertitle','off',...
    'resize','off');
% List
handles(2) = uicontrol('style','list',...
    'unit','pix',...
    'position',[10 70 200 400],...
    'min',0,'max',1,...
    'fontsize',14,...
    'string',field);
% Bouton
handles(3) = uicontrol('style','push',...
    'units','pix',...
    'position',[230 430 180 40],...
    'fontsize',14,...
    'string',channel{index});

set(handles(3),'Callback',@(event,obj)GUI_c3drename_Next(event,obj));

allParam.index    = index;
allParam.handles  = handles;
allParam.field   = field;
allParam.oldlabel = oldlabel;
allParam.channel = channel;
set(handles(1), 'userdata', allParam);
%
end


function GUI_c3drename_Next(event, obj)
if allParam.index > 6
    close all
else
    % Get the current value
    allParam = get(gcf, 'userdata');
    L  = get(allParam.handles(2),{'string','value'});

    % Write the current value
    allParam.oldlabel{1,allParam.index} = L{1}(L{2}(:));

    % Hide current name for the next itiration
    current = find(strcmp(allParam.field, L{1}(L{2}(:))));
    allParam.field(current) = [];

    % Next channel
    allParam.index = allParam.index+1;

    % Set the next fieldname
    set(allParam.handles(2),'string',allParam.field);

    % Set the next channel
    set(allParam.handles(3),'string',allParam.channel{allParam.index});
    
%     allParam.oldlabel = oldlabel;

    set(allParam.handles(1), 'userdata', allParam);
end
end