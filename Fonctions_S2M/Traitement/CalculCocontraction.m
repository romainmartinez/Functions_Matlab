function [RatioTrap,RatioDeltoide,RatioCools,MaxRatioCools,MoyRatioCools,MaxRatioTrap,MoyRatioTrap,MaxRatioDeltoide,MoyRatioDeltoide,MoyRatioCoude]=CalculCocontraction(EMGmoy3essais,LgrPhase1et3,LgrPhase2)

%% RATIO SELECTIONNÉ
     Ratio_Coude= EMGmoy3essais(:,9)./EMGmoy3essais(:,10);         
     Ratio_DeltA_TrapU= EMGmoy3essais(:,1)./EMGmoy3essais(:,6);

%% RATIO TRAPEZE
% % Calcul du ratio trapeze avec methode _Unnithan VB et al. 1996
for i= 1:size(EMGmoy3essais,1)
Trap3(i,:)=[EMGmoy3essais(i,6) EMGmoy3essais(i,7) EMGmoy3essais(i,8)];
Ratio_Trapeze_Unnithan(i,:)= min(Trap3(i,:));
end

% % Calcul ratio avec methode _Cools et al.2005
Ratio_TrapU_TrapP_CoolsHuang = EMGmoy3essais(:,6)./EMGmoy3essais(:,8);
Ratio_TrapU_TrapM_CoolsHuang = EMGmoy3essais(:,6)./EMGmoy3essais(:,7);
% Ratio_TrapU_Serr = EMGmoy3essais(:,6)./EMGmoy3essais(:,11);

% % Calcul du ratio Trapeze avec methode Rudolph et al. 2001 adapté au trapèze
for i= 1:size(EMGmoy3essais,1)
MusclesEtudes1(i,:)=[EMGmoy3essais(i,6) EMGmoy3essais(i,8)];
MusclesEtudes2(i,:)=[EMGmoy3essais(i,6) EMGmoy3essais(i,7)];
SommeDesMuscles1(i,:)= sum(MusclesEtudes1(i,:));
SommeDesMuscles2(i,:)= sum(MusclesEtudes2(i,:));
EMGmin1(i,:)= min(MusclesEtudes1(i,:));EMGmax1(i,:)= max(MusclesEtudes1(i,:));
EMGmin2(i,:)= min(MusclesEtudes2(i,:));EMGmax2(i,:)= max(MusclesEtudes2(i,:));
Ratio_TrapU_I_Rudolph(i,:)= (EMGmin1(i,:)./EMGmax1(i,:)).*SommeDesMuscles1(i,:);
Ratio_TrapU_M_Rudolph(i,:)= (EMGmin2(i,:)./EMGmax2(i,:)).*SommeDesMuscles2(i,:);
end


%% RATIO DELTOIDE
 % Methode ratio avec simple division
Ratio_DeltA_DeltP= EMGmoy3essais(:,1)./EMGmoy3essais(:,3);
Ratio_DeltA_DeltM= EMGmoy3essais(:,1)./EMGmoy3essais(:,2);
Ratio_DeltM_DeltP= EMGmoy3essais(:,2)./EMGmoy3essais(:,3);
% % Calcul du ratio deltoide avec methode Rudolph et al. 2001 adapté
for i= 1:size(EMGmoy3essais,1)
MusclesEtudes1(i,:)=[EMGmoy3essais(i,1) EMGmoy3essais(i,3)];
MusclesEtudes2(i,:)=[EMGmoy3essais(i,1) EMGmoy3essais(i,2)];
MusclesEtudes3(i,:)=[EMGmoy3essais(i,2) EMGmoy3essais(i,3)];
SommeDesMuscles1(i,:)= sum(MusclesEtudes1(i,:));
SommeDesMuscles2(i,:)= sum(MusclesEtudes2(i,:));
SommeDesMuscles3(i,:)= sum(MusclesEtudes3(i,:));
EMGmin1(i,:)= min(MusclesEtudes1(i,:));EMGmax1(i,:)= max(MusclesEtudes1(i,:));
EMGmin2(i,:)= min(MusclesEtudes2(i,:));EMGmax2(i,:)= max(MusclesEtudes2(i,:));
EMGmin3(i,:)= min(MusclesEtudes3(i,:));EMGmax3(i,:)= max(MusclesEtudes3(i,:));
Ratio_DeltA_P_Rudolph(i,:)= (EMGmin1(i,:)./EMGmax1(i,:)).*SommeDesMuscles1(i,:);
Ratio_DeltA_M_Rudolph(i,:)= (EMGmin2(i,:)./EMGmax2(i,:)).*SommeDesMuscles2(i,:);
Ratio_DeltM_P_Rudolph(i,:)= (EMGmin3(i,:)./EMGmax3(i,:)).*SommeDesMuscles3(i,:);
end

% % Calcul du ratio deltoide avec methode Winter et al. 
for i= 1:size(EMGmoy3essais,1)
MusclesEtudes1(i,:)=[EMGmoy3essais(i,1) EMGmoy3essais(i,3)];
MusclesEtudes3(i,:)=[EMGmoy3essais(i,2) EMGmoy3essais(i,3)];
SommeDesMuscles1(i,:)= sum(MusclesEtudes1(i,:));
SommeDesMuscles3(i,:)= sum(MusclesEtudes3(i,:));
EMGmin1(i,:)= min(MusclesEtudes1(i,:));EMGmax1(i,:)= max(MusclesEtudes1(i,:));
EMGmin3(i,:)= min(MusclesEtudes3(i,:));EMGmax3(i,:)= max(MusclesEtudes3(i,:));
Ratio_DeltA_P_Winter(i,:)= (2*EMGmoy3essais(i,3)./SommeDesMuscles1(i,:))*100;
Ratio_DeltM_P_Winter(i,:)= (2*EMGmoy3essais(i,3)./SommeDesMuscles3(i,:))*100;
end
for i= 1:size(EMGmoy3essais,1)
MusclesEtudes1(i,:)=[EMGmoy3essais(i,9) EMGmoy3essais(i,10)];
SommeDesMuscles1(i,:)= sum(MusclesEtudes1(i,:));
Ratio_Coude_Winter(i,:)= (2*EMGmoy3essais(i,3)./SommeDesMuscles1(i,:))*100;
end
%% Extraction des indices de co-contraction
% Sortie des ratios trapezes selon les differentes methodes
RatioTrap=[Ratio_Trapeze_Unnithan Ratio_TrapU_I_Rudolph Ratio_TrapU_M_Rudolph];
% Sortie ratio deltoide selon les differentes methodes
RatioDeltoide=[Ratio_DeltA_P_Rudolph Ratio_DeltM_P_Rudolph Ratio_DeltA_P_Winter Ratio_DeltM_P_Winter];
% Sortie des ratios simple division dans matrice (Ordre: Coude--Actionneurs--TrapUp/TrapInf--TrapUp/TrapM--DeltAnt/DeltPost)
RatioCools=[Ratio_Coude Ratio_DeltA_TrapU Ratio_TrapU_TrapP_CoolsHuang Ratio_TrapU_TrapM_CoolsHuang Ratio_DeltA_DeltP];

%% Extraction des maxs et moyennes par phase sur chacun des ratios
%%%% Ratio ''simple''
MaxRatioCoolsP1= nanmax(RatioCools(1:LgrPhase1et3,:));MaxRatioCoolsP2= nanmax(RatioCools(LgrPhase1et3:LgrPhase1et3+LgrPhase2,:));MaxRatioCoolsP3= nanmax(RatioCools(LgrPhase1et3+LgrPhase2:end,:));
MoyRatioCoolsP1= nanmean(RatioCools(1:LgrPhase1et3,:));MoyRatioCoolsP2= nanmean(RatioCools(LgrPhase1et3:LgrPhase1et3+LgrPhase2,:));MoyRatioCoolsP3= nanmean(RatioCools(LgrPhase1et3+LgrPhase2:end,:));
MaxRatioCools=[MaxRatioCoolsP1;MaxRatioCoolsP2;MaxRatioCoolsP3]; MoyRatioCools=[MoyRatioCoolsP1;MoyRatioCoolsP2;MoyRatioCoolsP3];
%%%% Ratio Trapeze
MaxRatioTrapP1= nanmax(RatioTrap(1:LgrPhase1et3,:));MaxRatioTrapP2= nanmax(RatioTrap(LgrPhase1et3:LgrPhase1et3+LgrPhase2,:));MaxRatioTrapP3= nanmax(RatioTrap(LgrPhase1et3+LgrPhase2:end,:));
MoyRatioTrapP1= nanmean(RatioTrap(1:LgrPhase1et3,:));MoyRatioTrapP2= nanmean(RatioTrap(LgrPhase1et3:LgrPhase1et3+LgrPhase2,:));MoyRatioTrapP3= nanmean(RatioTrap(LgrPhase1et3+LgrPhase2:end,:));
MaxRatioTrap=[MaxRatioTrapP1;MaxRatioTrapP2;MaxRatioTrapP3]; MoyRatioTrap=[MoyRatioTrapP1;MoyRatioTrapP2;MoyRatioTrapP3];
%%%% Ratio Deltoide
MaxRatioDeltoideP1= nanmax(RatioDeltoide(1:LgrPhase1et3,:));MaxRatioDeltoideP2= nanmax(RatioDeltoide(LgrPhase1et3:LgrPhase1et3+LgrPhase2,:));MaxRatioDeltoideP3= nanmax(RatioDeltoide(LgrPhase1et3+LgrPhase2:end,:));
MoyRatioDeltoideP1= nanmean(RatioDeltoide(1:LgrPhase1et3,:));MoyRatioDeltoideP2= nanmean(RatioDeltoide(LgrPhase1et3:LgrPhase1et3+LgrPhase2,:));MoyRatioDeltoideP3= nanmean(RatioDeltoide(LgrPhase1et3+LgrPhase2:end,:));
MaxRatioDeltoide=[MaxRatioDeltoideP1;MaxRatioDeltoideP2;MaxRatioDeltoideP3];MoyRatioDeltoide=[MoyRatioDeltoideP1;MoyRatioDeltoideP2;MoyRatioDeltoideP3];
%%%% Ratio Coude Winter
MoyRatioCoudeP1=nanmean(Ratio_Coude_Winter(1:LgrPhase1et3,:));MoyRatioCoudeP2=nanmean(Ratio_Coude_Winter(LgrPhase1et3:LgrPhase1et3+LgrPhase2,:));MoyRatioCoudeP3=nanmean(Ratio_Coude_Winter(LgrPhase1et3+LgrPhase2:end,:));
MoyRatioCoude=[MoyRatioCoudeP1;MoyRatioCoudeP2;MoyRatioCoudeP3];
end

