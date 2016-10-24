function affichageMoyenne(EMGInterp,SV)

NomdeFig=['E:\Projet_LeverCaisse\Landry_LeverCaisse\Resultats\FigureEMGmoyen\' SV(1:end-4) '.emf'];
EvenementEssai=[200 800];
a=figure;
%plot(DataViconFilt(:,Lg(2))); %Affichage d'un marqueur de la boite
set(a,'Name',SV, ...
    'Position',[50 50 1350 700]); %Met en titre de graph le nom de l'essai

% 1)Données Moy Deltoide
subplot(2,2,1); plot(EMGInterp(:,1:3)); ylim([0 100])
title('Deltoide');
hold on
plot([EvenementEssai(1) EvenementEssai(1)], ylim,'k:');
plot([EvenementEssai(:,2) EvenementEssai(:,2)], ylim,'k:')
% plot([EvenementEssai(:,3) EvenementEssai(:,3)], ylim,'k:')
% plot([IndPhase IndPhase], ylim,'g')



% 2)Données Moy Trapeze
subplot(2,2,2); plot(EMGInterp(:,6:8)); ylim([0 100])
title('Trapeze');
hold on
plot([EvenementEssai(:,1) EvenementEssai(:,1)], ylim,'k:')
plot([EvenementEssai(:,2) EvenementEssai(:,2)], ylim,'k:')
% plot([EvenementEssai(:,3) EvenementEssai(:,3)], ylim,'k:')
% plot([IndPhase IndPhase], ylim,'g')

% 3)Données Moy Lat et Pec
subplot(2,2,3); plot(EMGInterp(:,4:5)); ylim([0 100])
title('Lat et Pec');
hold on
plot([EvenementEssai(:,1) EvenementEssai(:,1)], ylim,'k:')
plot([EvenementEssai(:,2) EvenementEssai(:,2)], ylim,'k:')
% plot([EvenementEssai(:,3) EvenementEssai(:,3)], ylim,'k:')
% plot([IndPhase IndPhase], ylim,'g')

% 4)Données Moy Biceps Triceps SCM
subplot(2,2,4); plot(EMGInterp(:,9:11)); ylim([0 100])
title('Bic Tri SCM');
hold on
plot([EvenementEssai(:,1) EvenementEssai(:,1)], ylim,'k:')
plot([EvenementEssai(:,2) EvenementEssai(:,2)], ylim,'k:')
% plot([EvenementEssai(:,3) EvenementEssai(:,3)], ylim,'k:')
% plot([IndPhase IndPhase], ylim,'g')

print(a,'-dmeta',NomdeFig)