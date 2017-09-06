clear variables ; close all ; clc
f = figure('units', 'normalized',...
    'outerposition', [.25 .25 .3 .8],...
    'MenuBar', 'none',...
    'Toolbar', 'none');

layout = uix.HBox( 'Parent', f ); 
% layout comes in 3 forms
    % 1) panels (Panel, CardPanel, BoxPanel, TabPanel and ScrollingPanel)
    % 2) boxes (HBox, VBox, HBoxFlex and VBoxFlex)
    % 3) grids (Grid and GridFlex)
    
% We don't need to set the position with layout
% but we can control the size of the components with a sizing property:
    % HBox: 'Widths'
    % VBox: 'Heights'
    % Grids: 'Widths' and 'Heights'
% they all obey the same convention:
    % positive numbers: size in pixels (similar to 'pixel')
    % negative numbers: indicate a weighting for variable sizing (similar to 'normalized')
    % default value: -1

uicontrol( 'String', 'emg', 'Parent', layout );
uicontrol( 'String', 'force', 'Parent', layout );
uicontrol( 'String', 'markers', 'Parent', layout );

layout.Widths = [-3 -1 -2]

%%%
clear variables ; close all ; clc
f = figure('units', 'normalized', 'outerposition', [.25 .25 .3 .8]);

vbox = uix.VBox('Parent', f);
button1 = uicontrol('String', 'top', 'Parent', vbox);
%---%
hbox = uix.HButtonBox('Parent', vbox, 'Padding', 10);
uicontrol('Parent', hbox,...
    'String', 'Button 1');
uicontrol('Parent', hbox,...
    'String', 'Button 2')
%---%
vbox.Heights = [-1 -.25]


