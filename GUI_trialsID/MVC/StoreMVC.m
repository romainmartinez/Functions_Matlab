%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  ____                       _         __  __            _   _                  %
% |  _ \ ___  _ __ ___   __ _(_)_ __   |  \/  | __ _ _ __| |_(_)_ __   ___ ____  %
% | |_) / _ \| '_ ` _ \ / _` | | '_ \  | |\/| |/ _` | '__| __| | '_ \ / _ \_  /  %
% |  _ < (_) | | | | | | (_| | | | | | | |  | | (_| | |  | |_| | | | |  __// /   % 
% |_| \_\___/|_| |_| |_|\__,_|_|_| |_| |_|  |_|\__,_|_|   \__|_|_| |_|\___/___|  %
%                                                                                %  
% Auteur : Romain Martinez                                 Date : Juin 2016      %
% Description : Obtenir la colonne du muscle à supprimer et le remplacer par NaN %
% Input : index ; matrice résultats                                              % 
% Output : NaN sur la colonne sélectionnée                                       %                                      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   

trialdeteled = str2num(get(ex.but(1),'String'));

essai(trialdeteled).RMS(:,index) = nan;
Maxdesmuscles(trialdeteled,index) = nan;

MAX2 = max(Maxdesmuscles);   
    for j=1:length(C3dfiles)
subplot(5,6,j),plot(essai(j).RMS(:,index),'r'),title(sprintf('%d (%s)\n', j, C3dfiles(j).name)), axis([0 inf 0 MAX2(1,index)]);
if max(essai(j).RMS(:,index)) == MAX2(1,index)
    set(subplot(5,6,j),'color',[0.4 0.6 0.4])
end
    end

% delete(subplot(5,6,trialdeteled));
   
set(gcf,'name',num2str(index),'numbertitle','off')
