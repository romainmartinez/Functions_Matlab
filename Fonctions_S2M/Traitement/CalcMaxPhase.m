function [MaxPhase,MeanPhase]=CalcMaxPhaseEssai(NormEMG,DebutForce,FinForce,Phase1,Phase3)

%Pour faire fitter les indices avec l'EMG
IndiceDebutForce= DebutForce*10;
IndiceFinForce= FinForce*10;
IndiceP1= Phase1*10;
IndiceP3= Phase3*10;
% Determiner les max par phase et les stocker dans une variable MaxPhase
MaxPhase1=nanmax(NormEMG(IndiceDebutForce:IndiceP1,:));
MaxPhase2=nanmax(NormEMG(IndiceP1:IndiceP3,:));
MaxPhase3=nanmax(NormEMG(IndiceP3:IndiceFinForce,:));
MaxPhase=[MaxPhase1;MaxPhase2;MaxPhase3];
% Detreminer les moyennes par phase etles stocker dans une variable MeanPhase
MeanPhase1=nanmean(NormEMG(IndiceDebutForce:IndiceP1,:));
MeanPhase2=nanmean(NormEMG(IndiceP1:IndiceP3,:));
MeanPhase3=nanmean(NormEMG(IndiceP3:IndiceFinForce,:));
MeanPhase=[MeanPhase1;MeanPhase2;MeanPhase3];

end