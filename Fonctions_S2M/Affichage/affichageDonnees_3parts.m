function affichageDonnees_3parts(Vm, ValDebutS, ValFinS, ValImm, Am, ValIC, IA, SV, FT, CaissePoids, SaveBool, NomdeFig, DebutForce, FinForce, NormEMG, VmN, maxtab, AnglesReconstruits, IndPhase, DataViconFilt)

PC=(CaissePoids*9.81)/2;%Poids de la caisse 6.75kg en Newtons divisé par 2(car 2 mains) pour affichage graphique

i=[46:49]*3-1;
Avant = DataViconFilt(:,i);
Avant = mean(Avant,2);

j=[52:53]*3-1;
Arriere = DataViconFilt(:,j);
Arriere_t0 =DataViconFilt(1:100,j);
Arriere_t0 =mean(Arriere_t0(:));
f=1;            while Avant(f)<Arriere_t0,    f=f+1;end %% la caisse est sortie
g=length(Avant);while Avant(g)<Arriere_t0,    g=g-1; end %% la caisse rentre
[val,h] = max(Avant);


a=figure;
%plot(DataViconFilt(:,Lg(2))); %Affichage d'un marqueur de la boite
set(a,'Name',SV, ...
    'Position',[50 100 1350 700]); %Met en titre de graph le nom de l'essai





% 1)Données Vitesses
subplot(3,3,1); plot(Vm); %Affiche vitesse de la boite en Ob
title('Vitesse (m/s-1)');
plotDELIM()

% 2)Données Acceleration
subplot(3,3,2); plot(Am);
title('Acceleration (m/s^-2)');
plotDELIM()


%3) Données de Force filtrées
subplot(3,3,3); plot(FT(:,1:3))% Affiche la force totale appliquée à la poignée
title('Force (N)');
plotDELIM()


if AnglesReconstruits
%4) Données Angulaire du Coude et differents evenement(Max amplitude articulaire coude, Dist Boite-Sujet Normée et en Y la plus faible au cours de l'essai)
    subplot(3,3,4);plot(DataAngleFilt(:,25));
    title('Amplitude articualire Coude(°)');
    plotDELIM()
else
    subplot(3,3,4);plot(DataViconFilt(:,150));    
    title('Position dun marqueurs boite sur z vertical');
    plotDELIM()
end

% 5) EMG (1)
subplot(3,3,5);plot(NormEMG(:,1:3));
title('NRMS(%) DELTOIDE');
plotDELIM()

% 6) EMG (2)
subplot(3,3,6);plot(NormEMG(:,6:8));
title('NRMS(%) TRAPEZE');
plotDELIM()

% 7) EMG (3)
subplot(3,3,7);plot(NormEMG(:,9:10));
title('NRMS(%) Biceps Triceps');
plotDELIM()

% 8) EMG (4)
subplot(3,3,8);plot(NormEMG(:,4:5));hold on;plot(NormEMG(:,11),'g');
title('NRMS(%) LAT PEC STR');
plotDELIM()

% 9) Norme Vitesse de la boite
subplot(3,3,9);plot(VmN)
title('Norme Vitesse');
plotDELIM()


if SaveBool
    print(a,'-dpng',NomdeFig)
end

    function plotDELIM()
        hold on;
        plot([DebutForce DebutForce], ylim,'k')
        plot([FinForce FinForce], ylim,'k')
        plot([IndPhase IndPhase], ylim,'k:')
        plot([f f], ylim,'k--')
        plot([g g], ylim,'k--')
        plot([h-100 h-100], ylim,'m-.')
        plot([h+100 h+100], ylim,'m-.')
        
        % plot([maxtab(1,1) maxtab(1,1)], ylim,'k:')
        % plot([maxtab(2,1) maxtab(2,1)], ylim,'k:')
    end



end