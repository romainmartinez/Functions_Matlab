function [EvenementEssai, EMGmaxP1,EMGmaxP2, EMGInterp, EMGmeanP1, EMGmeanP2]= InterPhase(Phase1,Phase2,Phase3,PhaseF, InitiationTache, FindeTache, NormEMG, VmN,maxtab, FreqEMG, FreqKin, IndicePhase);


for i = 1:length(NormEMG)
    NormEMG{i} = NormEMG{i}(1:FreqEMG/FreqKin:end,:);
end

% for i=1:3
% PrePhase(i)=IndicePhase(i)-InitiationTache(i);
PrePhase=IndicePhase-InitiationTache;
% end

P1ranger= sort(Phase1);
P2ranger= sort(Phase2);
P3ranger= sort(Phase3);
Pranger= sort(PrePhase);
P4ranger= sort(PhaseF);

% %%%%%%%%%%%
% % PHASE 1 %
% %%%%%%%%%%%
% 
% for jEssai= 1:3
%     % Vecteur temps initial
% x1 = 1:Phase1(jEssai);
% 
%     % Nouveaux vecteur temps desiré
% A3=linspace(1,length(x1),P1ranger(3));
% 
%     % Nouvelles données
% VmNinterpP1{jEssai}=interp1(x1,VmN{jEssai}(InitiationTache(jEssai)+1:InitiationTache(jEssai)+Phase1(jEssai)),A3,'spline');
% NormEMGinterpP1{jEssai}=interp1(x1,NormEMG{jEssai}(InitiationTache(jEssai)+1:InitiationTache(jEssai)+Phase1(jEssai),:),A3,'spline');
% end
% 
% %%%%%%%%%%%
% % PHASE 2 %
% %%%%%%%%%%%
% for kEssai= 1:3
% % Vecteur temps initial
% x1 = 1:Phase2(kEssai)+1;
% % Nouveaux vecteur temps desiré
% A1=linspace(1,length(x1),P2ranger(3));
% 
% % Nouvelles données
% VmNinterpP2{kEssai}=interp1(x1,VmN{kEssai}(InitiationTache(kEssai)+Phase1(kEssai):InitiationTache(kEssai)+Phase1(kEssai)+Phase2(kEssai)),A1,'spline');
% NormEMGinterpP2{kEssai}=interp1(x1,NormEMG{kEssai}(InitiationTache(kEssai)+Phase1(kEssai):InitiationTache(kEssai)+Phase1(kEssai)+Phase2(kEssai),:),A1,'spline');
% 
% end
% 
% %%%%%%%%%%%
% % PHASE 3 %
% %%%%%%%%%%%
% for mEssai= 1:3
% % Vecteur temps initial
% x1 = 1:Phase3(mEssai)+1;
% % Nouveaux vecteur temps desiré
% A1=linspace(1,length(x1),P3ranger(3));
% % Nouvelles données
% VmNinterpP3{mEssai}=interp1(x1,VmN{mEssai}(InitiationTache(mEssai)+Phase1(mEssai)+Phase2(mEssai):InitiationTache(mEssai)+Phase1(mEssai)+Phase2(mEssai)+Phase3(mEssai)),A1,'spline');
% NormEMGinterpP3{mEssai}=interp1(x1,NormEMG{mEssai}(InitiationTache(mEssai)+Phase1(mEssai)+Phase2(mEssai):InitiationTache(mEssai)+Phase1(mEssai)+Phase2(mEssai)+Phase3(mEssai),:),A1,'spline');
% end

% BONNES Phases Debut
for jEssai= 1:3
    % Vecteur temps initial
x1 = 1:PrePhase(jEssai);

    % Nouveaux vecteur temps desiré
A3=linspace(1,length(x1),Pranger(3));

    % Nouvelles données
NormEMGinterpPD{jEssai}=interp1(x1,NormEMG{jEssai}(InitiationTache(jEssai)+1:InitiationTache(jEssai)+PrePhase(jEssai),:),A3,'spline');
end
% BONNES Phases Fin
for jEssai= 1:3
    % Vecteur temps initial
x1 = 1:PhaseF(jEssai);
    % Nouveaux vecteur temps desiré
A3=linspace(1,length(x1),P4ranger(3));
% Nouvelles données
NormEMGinterpPF{jEssai}=interp1(x1,NormEMG{jEssai}(InitiationTache(jEssai)+PrePhase(jEssai)+1:InitiationTache(jEssai)+PrePhase(jEssai)+PhaseF(jEssai),:),A3,'spline');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% Concaténation du nvx vecteur  %%%%%%%
% On raccorde tout les morceaux de vecteur

for iEssai= 1:3
% VmNInt{iEssai}= [VmN{iEssai}(InitiationTache(iEssai),:)  VmNinterpP1{iEssai} VmNinterpP2{iEssai} VmNinterpP3{iEssai}];
% NormEMGinterp{iEssai}= [NormEMG{iEssai}(InitiationTache(iEssai),:)  ;NormEMGinterpP1{iEssai} ;NormEMGinterpP2{iEssai} ;NormEMGinterpP3{iEssai}];
NormEMGinterp{iEssai}= [NormEMG{iEssai}(InitiationTache(iEssai),:)  ;NormEMGinterpPD{iEssai} ;NormEMGinterpPF{iEssai}];
end

% Moyennage des 3 essais
% EvenementEssai=[P1ranger(3) P1ranger(3)+P2ranger(3) P1ranger(3)+P2ranger(3)+P3ranger(3)];
EvenementEssai=[Pranger(3) Pranger(3)+P4ranger(3)];

% VV=[VmNInt{1}; VmNInt{2}; VmNInt{3}];
% VitNormInterp=mean(VV);


for p=1:3
    Michel(:,:,p) = NormEMGinterp{p} ;
end
EMGInterp = mean(Michel,3);

EMGmaxP1= max(EMGInterp(1:EvenementEssai(:,1),:));
EMGmeanP1= mean(EMGInterp(1:EvenementEssai(:,1),:));
EMGmaxP2= max(EMGInterp(EvenementEssai(:,1):EvenementEssai(:,2),:));
EMGmeanP2= mean(EMGInterp(EvenementEssai(:,1):EvenementEssai(:,2),:));
% EMGmaxP3= max(EMGInterp(EvenementEssai(:,2):end,:));
