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

index=index-1;
if index < 1
	disp('Index out of range (<0)')
else
plot(ScaledRMS{index,1},'LineWidth',2) ; hold on ; line([1 length(ScaledRMS{index,1})],[100 100]) ; hold off
title(sprintf('Essai %d condition %d',index,data(index).condition))
legend('1-delt ant','2-delt med','3-delt post','4-biceps','5-triceps','6-trap sup','7-trap inf','8-gd dent','9-supra','10-infra','11-subscap');
end