function [MaxPhaseEMGMoy,MeanPhaseEMGMoy] = CalcMaxEMGMoy(EMGmoy3essais,LgrPhase1et3,LgrPhase2);

IndicedesPhases=[LgrPhase1et3 LgrPhase2 LgrPhase1et3];
MaxPhase1=nanmax(EMGmoy3essais(1:IndicedesPhases(1),:));
MaxPhase2=nanmax(EMGmoy3essais(IndicedesPhases(1):IndicedesPhases(1)+IndicedesPhases(2),:));
MaxPhase3=nanmax(EMGmoy3essais(IndicedesPhases(1)+IndicedesPhases(2):end,:));
MaxPhaseEMGMoy=[MaxPhase1;MaxPhase2;MaxPhase3];
MeanPhase1=nanmean(EMGmoy3essais(1:IndicedesPhases(1),:));
MeanPhase2=nanmean(EMGmoy3essais(IndicedesPhases(1):IndicedesPhases(1)+IndicedesPhases(2),:));
MeanPhase3=nanmean(EMGmoy3essais(IndicedesPhases(1)+IndicedesPhases(2):end,:));
MeanPhaseEMGMoy=[MeanPhase1;MeanPhase2;MeanPhase3];

end

