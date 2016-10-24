function [ActModinterp,FMModinterp,ActMaxPhase,ActMoyPhase,FMMaxPhase,FMMoyPhase]=InterpolationPhaseModele(InitiationTache,FindeTache,DATAFiltAct,noTrial,DATAFiltFM,LgrPhase1et3,LgrPhase2,Instant)					
LgTotale=1000;

LgTrialModel=length(DATAFiltAct);
InsDebutInterpolation_tmp=(InitiationTache(noTrial)*LgTrialModel)/Instant(noTrial);
InsDebutInterpolation=round(InsDebutInterpolation_tmp);
InsFinInterpolation_tmp=(FindeTache(noTrial)*LgTrialModel)/Instant(noTrial);
InsFinInterpolation=round(InsFinInterpolation_tmp);
LgPhase=InsFinInterpolation-InsDebutInterpolation;
% INTERPOLATION DES PHASES SUR LES 3 ESSAIS
    % Vecteur temps initial
x1 = 1:LgPhase;
    % Nouveaux vecteur temps desiré
A3=linspace(1,length(x1),LgTotale);
    % Nouvelles données
ActModinterp=interp1(x1,DATAFiltAct(InsDebutInterpolation+1:InsFinInterpolation,:),A3,'spline');
FMModinterp=interp1(x1,DATAFiltFM(InsDebutInterpolation+1:InsFinInterpolation,:),A3,'spline');

MaxActP1=max(ActModinterp(1:LgrPhase1et3,:));MaxActP2=max(ActModinterp(LgrPhase1et3:LgrPhase1et3+LgrPhase2,:));MaxActP3=max(ActModinterp(LgrPhase1et3+LgrPhase2:end,:));
MoyActP1=mean(ActModinterp(1:LgrPhase1et3,:));MoyActP2=mean(ActModinterp(LgrPhase1et3:LgrPhase1et3+LgrPhase2,:));MoyActP3=mean(ActModinterp(LgrPhase1et3+LgrPhase2:end,:));
ActMaxPhase=[MaxActP1;MaxActP2;MaxActP3]; ActMoyPhase=[MoyActP1;MoyActP2;MoyActP3];
MaxFMP1=max(FMModinterp(1:LgrPhase1et3,:));MaxFMP2=max(FMModinterp(LgrPhase1et3:LgrPhase1et3+LgrPhase2,:));MaxFMP3=max(FMModinterp(LgrPhase1et3+LgrPhase2:end,:));
MoyFMP1=mean(FMModinterp(1:LgrPhase1et3,:));MoyFMP2=mean(FMModinterp(LgrPhase1et3:LgrPhase1et3+LgrPhase2,:));MoyFMP3=mean(FMModinterp(LgrPhase1et3+LgrPhase2:end,:));
FMMaxPhase=[MaxFMP1;MaxFMP2;MaxFMP3];FMMoyPhase=[MoyFMP1;MoyFMP2;MoyFMP3];
end