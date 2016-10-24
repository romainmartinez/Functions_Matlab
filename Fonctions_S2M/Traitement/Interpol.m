function [NormEMGinterpPhase,EMGmoy3essais,TH1moy3essais,Q1moy3essais,ST1moy3essais]=Interpol(InitiationTache,FindeTache,NormEMGforMean,FreqEMG,FreqKin,NbreEssai,CinematiqueTH1,CinematiqueGHQ1,CinematiqueST1)
% TOUT LES ESSAIS SONT RAMENÉS A 1000 POINTS
% AVEC 200 points pour les phases 1 et 3, puis 600 pour la phase 2
LgTotale=1000;
for i = 1:NbreEssai
     NormEMGforMean{i} = NormEMGforMean{i}(1:FreqEMG/FreqKin:end,:);
 end

for iEssai= 1:NbreEssai
LgPhase(iEssai)=FindeTache(iEssai)-InitiationTache(iEssai);
end

% INTERPOLATION DES PHASES SUR LES 3 ESSAIS
for jEssai= 1:NbreEssai
    % Vecteur temps initial
x1 = 1:LgPhase(jEssai);
    % Nouveaux vecteur temps desiré
A3=linspace(1,length(x1),LgTotale);
    % Nouvelles données
NormEMGinterpPhase{jEssai}=interp1(x1,NormEMGforMean{jEssai}(InitiationTache(jEssai)+1:FindeTache(jEssai),:),A3,'spline');
InterpTH1{jEssai}=interp1(x1,CinematiqueTH1{jEssai}(InitiationTache(jEssai)+1:FindeTache(jEssai),:),A3,'spline');
CinematiqueInterpQ1{jEssai}=interp1(x1,CinematiqueGHQ1{jEssai}(InitiationTache(jEssai)+1:FindeTache(jEssai),:),A3,'spline');
InterpST1{jEssai}=interp1(x1,CinematiqueST1{jEssai}(InitiationTache(jEssai)+1:FindeTache(jEssai),:),A3,'spline');

end
EMGmoy3essais= (NormEMGinterpPhase{1}+ NormEMGinterpPhase{2}+ NormEMGinterpPhase{3})/3;
TH1moy3essais=(InterpTH1{1}+InterpTH1{2}+InterpTH1{3})/3;
Q1moy3essais=(CinematiqueInterpQ1{1}+CinematiqueInterpQ1{2}+CinematiqueInterpQ1{3})/3;
ST1moy3essais=(InterpST1{1}+InterpST1{2}+InterpST1{3})/3;
end