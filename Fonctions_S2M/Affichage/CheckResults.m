close all; clc

%  AFFICHAGE DE NRMS MOY(3essais)DES 11 MUSCLES         
a=figure;
%plot(DataViconFilt(:,Lg(2))); %Affichage d'un marqueur de la boite
set(a,'Name','NrmsMoyenne', ...
    'Position',[50 100 1350 700]); %Met en titre de graph le nom de l'essai 


for iMouv=1:6;
    for iMuscle=1:11;
       
subplot(3,4,iMuscle); plot(EMGmoy{iMouv}(:,iMuscle));
title(iMouv);
hold on
plot([EvenementdesEssai{iMouv}(:,1) EvenementdesEssai{iMouv}(:,1)], ylim,'k:')

    end
close all
    
end

