%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  ____                       _         __  __            _   _                  %
% |  _ \ ___  _ __ ___   __ _(_)_ __   |  \/  | __ _ _ __| |_(_)_ __   ___ ____  %
% | |_) / _ \| '_ ` _ \ / _` | | '_ \  | |\/| |/ _` | '__| __| | '_ \ / _ \_  /  %
% |  _ < (_) | | | | | | (_| | | | | | | |  | | (_| | |  | |_| | | | |  __// /   % 
% |_| \_\___/|_| |_| |_|\__,_|_|_| |_| |_|  |_|\__,_|_|   \__|_|_| |_|\___/___|  %
%                                                                                %                                       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%				  
                   
index = 1;
    % Figure
    S.fh = figure('units','pixels',...
                  'position',[500 500 500 500],...
                  'menubar','none',...
                  'numbertitle','off',...
                  'resize','off');
    % List
    S.ls = uicontrol('style','list',...
                     'unit','pix',...
                     'position',[10 70 200 400],...
                     'min',0,'max',1,...
                     'fontsize',14,...
                     'string',fields);
    % Bouton
    S.pb = uicontrol('style','push',...
                     'units','pix',...
                     'position',[230 430 180 40],...
                     'fontsize',14,...
                     'string',newlabel{index}.Text,...
                     'Callback','GUI_c3drename_Next'); 
    
    S.pc = uicontrol('style','push',...
                     'units','pix',...
                     'position',[230 380 100 40],...
                     'fontsize',14,...
                     'string','NaN',...
                     'Callback','GUI_c3drename_NaN');