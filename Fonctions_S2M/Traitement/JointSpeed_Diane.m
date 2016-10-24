function [MaxAmpl,MaxVit,MoyVit,DataButeeTH,DataButee,DataST1Filtpi,InterpTH1,InterpQ1,InterpST1]=JointSpeed_Diane(DataAngleBrut,Phase1,Phase3,DebutForce,FinForce,DataTH1Brut,DataST1Brut)
 
DataTH1Brut=DataTH1Brut.TH1;
DataTH1Filt=filtreDonneesBrutesAngle(DataTH1Brut*180/pi);
DataTH1Filtpi= unwrap(DataTH1Filt);
    %figure(1); hold on
    X=[1:length(DataTH1Filtpi)]/length(DataTH1Filtpi)*100;
    %plot(X,DataTH1Filtpi(:,1),X,DataTH1Filtpi(:,2),X,DataTH1Filtpi(:,3))
seq='zyzz'; REF=2; % REF= 1 pourGH et REF different de 1 TH
DataButeeTH = AjusButee(DataTH1Filtpi,seq,REF,X);
%DataButeeTH=DataTH1Filtpi;

DataST1Brut=DataST1Brut.ST1;
DataST1Filt=filtreDonneesBrutesAngle(DataST1Brut*180/pi);
DataST1Filtpi= unwrap(DataST1Filt);


DataAngleBrut= DataAngleBrut.Q1';
DataAngleFilt1 = filtreDonneesBrutesAngle(DataAngleBrut(:,7:9)*180/pi);
DataAngleFilt2 = filtreDonneesBrutesAngle(DataAngleBrut(:,13:21)*180/pi);
DataAngleFilt3 = filtreDonneesBrutesAngle(DataAngleBrut(:,25:28)*180/pi);
DataAngleFilt=[DataAngleBrut(:,1:6) DataAngleFilt1 DataAngleBrut(:,10:12) DataAngleFilt2 DataAngleBrut(:,22:24) DataAngleFilt3];

DataAngleFiltpi= unwrap(DataAngleFilt);
    %figure(2); hold on
    X=[1:length(DataAngleFiltpi)]/length(DataAngleFiltpi)*100;
    %plot(X,DataAngleFiltpi(:,1),X,DataAngleFiltpi(:,2),X,DataAngleFiltpi(:,3))
seq='zyzz'; REF=1;
DataButeeGH = AjusButee(DataAngleFiltpi(:,19:21),seq,REF,X);
DataButee=DataAngleFiltpi;
DataButee(:,19:21)=DataButeeGH;
Vitesse= diff(DataButee);
Amplitude= DataButee;
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

%% Interpolation essai
LgPhase=FinForce-DebutForce;
LgTotale=1000;
    % Vecteur temps initial
x1 = 1:LgPhase;
    % Nouveaux vecteur temps desiré
A3=linspace(1,length(x1),LgTotale);
    % Nouvelles données
InterpTH1=interp1(x1,DataButeeTH(DebutForce+1:FinForce,:),A3,'spline');
InterpQ1=interp1(x1,DataButee(DebutForce+1:FinForce,:),A3,'spline');
InterpST1=interp1(x1,DataST1Filtpi(DebutForce+1:FinForce,:),A3,'spline');




end