%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  ____                       _         __  __            _   _                  %
% |  _ \ ___  _ __ ___   __ _(_)_ __   |  \/  | __ _ _ __| |_(_)_ __   ___ ____  %
% | |_) / _ \| '_ ` _ \ / _` | | '_ \  | |\/| |/ _` | '__| __| | '_ \ / _ \_  /  %
% |  _ < (_) | | | | | | (_| | | | | | | |  | | (_| | |  | |_| | | | |  __// /   % 
% |_| \_\___/|_| |_| |_|\__,_|_|_| |_| |_|  |_|\__,_|_|   \__|_|_| |_|\___/___|  %
%                                                                                %  
% Auteur : Romain Martinez                                 Date : Juin 2016      %
% Description : Figure précédente                                                %
% Input : index ; matrice résultats                                              % 
% Output : Plot précédent                                                        %                                      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

    % Index
index=index-1;
    % Warning si on dépasse le nombre de fichiers
if index < 1
	disp('Index out of range (<0)')
else
    % Plot des données
plot(data(index).ntime,data(index).EMGcut,'LineWidth',2) ; hold on ; line([1 100],[100 100]) ; hold off
    % Titre
title(sprintf('Essai %d condition %d',index,condition(index)))
    % Légende
legend('1-delt ant','2-delt med','3-delt post','4-biceps','5-triceps','6-trap sup','7-trap inf','8-gd dent','9-supra','10-infra','11-subscap','12-pec','13-gd dors');
end