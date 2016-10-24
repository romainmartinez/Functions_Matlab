function [NormEMGinterp,EMGmoy3essais]=InterpolationPhase(InitiationTache,FindeTache,Phase1cadrage,Phase2cadrage,Phase3cadrage,NormEMGforMean,FreqEMG,FreqKin,NbreEssai,LgrPhase1et3,LgrPhase2);

 for i = 1:NbreEssai
     NormEMGforMean{i} = NormEMGforMean{i}(1:FreqEMG/FreqKin:end,:);
 end


for iEssai= 1:NbreEssai
LgPhase1(iEssai)=Phase1cadrage(iEssai)-InitiationTache(iEssai);
LgPhase3(iEssai)=FindeTache(iEssai)-Phase3cadrage(iEssai);
end

% RangerPhase2= max(Phase2cadrage);
% RangerLongeurDePhase3= max(LgPhase3);
% RangerLongeurDePhase1= max(LgPhase1);
% IndicedesPhases=[RangerLongeurDePhase1 RangerPhase2 RangerLongeurDePhase3];

% BON CHANGEMENT DANS LINTERPOLATION
% TOUT LES ESSAIS SONT RAMENÉS A 1000 POINTS
% AVEC 200 points pour les phases 1 et 3, puis 600 pour la phase 2


% INTERPOLATION DES 1ERE PHASES
for jEssai= 1:NbreEssai
    % Vecteur temps initial
x1 = 1:LgPhase1(jEssai);
    % Nouveaux vecteur temps desiré
A3=linspace(1,length(x1),LgrPhase1et3);
    % Nouvelles données
NormEMGinterpPhase1{jEssai}=interp1(x1,NormEMGforMean{jEssai}(InitiationTache(jEssai)+1:InitiationTache(jEssai)+LgPhase1(jEssai),:),A3,'spline');
end

% INTERPOLATION DES 2ND PHASES
for jEssai= 1:NbreEssai
    % Vecteur temps initial
x1 = 1:Phase2cadrage(jEssai);
    % Nouveaux vecteur temps desiré
A3=linspace(1,length(x1),LgrPhase2);
    % Nouvelles données
NormEMGinterpPhase2{jEssai}=interp1(x1,NormEMGforMean{jEssai}(InitiationTache(jEssai)+LgPhase1(jEssai)+1:InitiationTache(jEssai)+LgPhase1(jEssai)+Phase2cadrage(jEssai),:),A3,'spline');
end

% INTERPOLATION DES 3EME PHASES
for jEssai= 1:NbreEssai
    % Vecteur temps initial
x1 = 1:LgPhase3(jEssai);
    % Nouveaux vecteur temps desiré
A3=linspace(1,length(x1),LgrPhase1et3);
    % Nouvelles données
NormEMGinterpPhase3{jEssai}=interp1(x1,NormEMGforMean{jEssai}(InitiationTache(jEssai)+LgPhase1(jEssai)+Phase2cadrage(jEssai)+1:InitiationTache(jEssai)+LgPhase1(jEssai)+Phase2cadrage(jEssai)+LgPhase3(jEssai),:),A3,'spline');
end

% Raccordement des phases interpolées
for mEssai= 1:NbreEssai
NormEMGinterp{mEssai}=[NormEMGinterpPhase1{mEssai};NormEMGinterpPhase2{mEssai};NormEMGinterpPhase3{mEssai}];
end

EMGmoy3essais= (NormEMGinterp{1}+ NormEMGinterp{2}+ NormEMGinterp{3})/3;

