%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  ____                       _         __  __            _   _                  %
% |  _ \ ___  _ __ ___   __ _(_)_ __   |  \/  | __ _ _ __| |_(_)_ __   ___ ____  %
% | |_) / _ \| '_ ` _ \ / _` | | '_ \  | |\/| |/ _` | '__| __| | '_ \ / _ \_  /  %
% |  _ < (_) | | | | | | (_| | | | | | | |  | | (_| | |  | |_| | | | |  __// /   % 
% |_| \_\___/|_| |_| |_|\__,_|_|_| |_| |_|  |_|\__,_|_|   \__|_|_| |_|\___/___|  %
%                                                                                %  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   

%% Interface graphique de suppresion des essais
set(figure,'units','normalized','outerposition',[0 0 1 1]);
% ex.ax = axes('Units','normalized','Position',[0.02 0.1 0.8 0.8],'NextPlot','replacechildren');
index = 0;
% legend('1-delt ant','2-delt med','3-delt post','4-biceps','5-triceps','6-trap sup','7-trap inf','8-gd dent','9-supra','10-infra','11-subscap','12-pec','13-gd dors');
ex.but(1) = uicontrol('Units','normalized','Position',[0.89 0.5 0.05 0.05],'String','0','Style','edit');
ex.but(2) = uicontrol('Units','normalized','Position',[0.94 0.5 0.05 0.05],'String','Next','Callback','Next');
ex.but(3) = uicontrol('Units','normalized','Position',[0.84 0.5 0.05 0.05],'String','Previous','Callback','Previous');
ex.but(4) = uicontrol('Units','normalized','Position',[0.89 0.45 0.05 0.05],'String','Store','Callback','Store');

    % Fenetre de l'interface en grand écran
h = set(figure,'units','normalized','outerposition',[0 0 1 1]);
    % Panneau pour les boutons
ex.ax1 = axes('Units','normalized',...
              'Position',[0.02 0.1 0.8 0.8],...
              'NextPlot','replacechildren');


