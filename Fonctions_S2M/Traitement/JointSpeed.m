function [MaxAmpl,MaxVit,MoyVit,DataButee,DataButeeGH]=JointSpeed(DataAngleBrut,Phase1,Phase3,DebutForce,FinForce,DataTH1Brut)
 
DataTH1Brut=DataTH1Brut.TH1;
DataTH1Filt=filtreDonneesBrutesAngle(DataTH1Brut*180/pi);
DataTH1Filtpi= unwrap(DataTH1Filt);
seq='zyzz'; REF=2; % REF= 1 pourGH et REF different de 1 TH
% [DataButee] = AjusButee(DataTH1Filtpi,seq,REF);
DataButee=DataTH1Filtpi;

DataAngleBrut= DataAngleBrut.Q1';
DataAngleFilt = filtreDonneesBrutesAngle(DataAngleBrut*180/pi);
DataAngleFiltpi= unwrap(DataAngleFilt);
seq='zyzz'; REF=1;
% [DataButeeGH] = AjusButee(DataAngleFiltpi,seq,REF);
DataButeeGH=DataAngleFiltpi;
Vitesse= diff(DataButeeGH);
Amplitude= DataButeeGH;
NbreDofs=size(Amplitude,2);
for iDof=1:NbreDofs;
SigneAmplPhase1=sign(Amplitude(DebutForce:Phase1,iDof));
SigneAmplPhase2=sign(Amplitude(Phase1:Phase3,iDof));
SigneAmplPhase3=sign(Amplitude(Phase3:FinForce,iDof));
SigneVitPhase1=sign(Vitesse(DebutForce:Phase1,iDof));
SigneVitPhase2=sign(Vitesse(Phase1:Phase3,iDof));
SigneVitPhase3=sign(Vitesse(Phase3:FinForce,iDof));
SigneAmplPhase1=mean(SigneAmplPhase1);SigneAmplPhase2=mean(SigneAmplPhase2);SigneAmplPhase3=mean(SigneAmplPhase3);
SigneVitPhase1=mean(SigneVitPhase1);SigneVitPhase2=mean(SigneVitPhase2);SigneVitPhase3=mean(SigneVitPhase3);

if SigneAmplPhase1 > 0;
MaxAmplPhase1(:,iDof)= nanmax(Amplitude(DebutForce:Phase1,iDof));
elseif SigneAmplPhase1 < 0;
MaxAmplPhase1(:,iDof)= nanmin(Amplitude(DebutForce:Phase1,iDof));
elseif SigneAmplPhase1 == 0 | isnan(SigneAmplPhase1);	
MaxAmplPhase1(:,iDof)= nan;
end

if SigneAmplPhase2 > 0;
	MaxAmplPhase2(:,iDof)= nanmax(Amplitude(Phase1:Phase3,iDof));
elseif SigneAmplPhase2 < 0;
	MaxAmplPhase2(:,iDof)= nanmin(Amplitude(Phase1:Phase3,iDof));
elseif SigneAmplPhase2 == 0 | isnan(SigneAmplPhase2);
	MaxAmplPhase2(:,iDof)= nan;
end
if SigneAmplPhase3 > 0;
	MaxAmplPhase3(:,iDof)= nanmax(Amplitude(Phase3:FinForce,iDof));
elseif SigneAmplPhase3 < 0;
	MaxAmplPhase3(:,iDof)= nanmin(Amplitude(Phase3:FinForce,iDof));
elseif SigneAmplPhase3 == 0 | isnan(SigneAmplPhase3);
	MaxAmplPhase3(:,iDof)= nan;
end

if SigneVitPhase1 > 0;
	MaxVitPhase1(:,iDof)= nanmax(Vitesse(DebutForce:Phase1,iDof));
elseif SigneVitPhase1 < 0;
	MaxVitPhase1(:,iDof)= nanmin(Vitesse(DebutForce:Phase1,iDof));
elseif SigneVitPhase1 == 0 | isnan(SigneVitPhase1);
	MaxVitPhase1(:,iDof)= nan;
end

if SigneVitPhase2 > 0;
	MaxVitPhase2(:,iDof)= nanmax(Vitesse(Phase1:Phase3,iDof));
elseif SigneVitPhase2 < 0;
	MaxVitPhase2(:,iDof)= nanmin(Vitesse(Phase1:Phase3,iDof));
elseif SigneVitPhase2 == 0 | isnan(SigneVitPhase2);
	MaxVitPhase2(:,iDof)= nan;
end

if SigneVitPhase3 > 0;
	MaxVitPhase3(:,iDof)= nanmax(Vitesse(Phase3:FinForce,iDof));
elseif SigneVitPhase3 < 0;
	MaxVitPhase3(:,iDof)= nanmin(Vitesse(Phase3:FinForce,iDof));
elseif SigneVitPhase3 == 0 | isnan(SigneVitPhase3);
	MaxVitPhase3(:,iDof)= nan;
end

end

MoyVitPhase1= nanmean(Vitesse(DebutForce:Phase1,:));
MoyVitPhase2= nanmean(Vitesse(Phase1:Phase3,:));
MoyVitPhase3= nanmean(Vitesse(Phase3:FinForce,:));

MaxAmpl=[MaxAmplPhase1;MaxAmplPhase2;MaxAmplPhase3];
MaxVit=[MaxVitPhase1;MaxVitPhase2;MaxVitPhase3];
MoyVit=[MoyVitPhase1;MoyVitPhase2;MoyVitPhase3];
end