function [DataButeeTH,DataButeeGH,DataST1,InterpTH1,InterpGH1,InterpST1]=JointSpeed_MODIF(DataAngleBrut,DebutForce,FinForce,DataTH1Brut,DataST1Brut)
 
%% Data TH
DataTH1Filtunwrap= unwrap(DataTH1Brut);
% DataTH1Filt=filtreDonneesBrutesAngle(DataTH1Filtunwrap*180/pi);

    %figure(1); hold on
    X=[1:length(DataTH1Filtunwrap)]/length(DataTH1Filtunwrap)*100;
    %plot(X,DataTH1Filtpi(:,1),X,DataTH1Filtpi(:,2),X,DataTH1Filtpi(:,3))
	
seq='zyzz'; REF=2; % REF= 1 pourGH et REF different de 1 TH
DataButeeTH = AjusButee(DataTH1Filtunwrap,seq,REF,X);

%% DAta ST
DataST1Filtpi=unwrap(DataST1Brut,pi/2);
DataST1=unwrap(DataST1Filtpi)*180/pi;

%% Data GH
DataAngleBrut= DataAngleBrut.Q1';
% DataAngleFilt = filtreDonneesBrutesAngle(DataAngleBrut*180/pi);
DataAngleFiltpi= unwrap(DataAngleBrut);
    %figure(2); hold on
    X=[1:length(DataAngleFiltpi)]/length(DataAngleFiltpi)*100;
    %plot(X,DataAngleFiltpi(:,1),X,DataAngleFiltpi(:,2),X,DataAngleFiltpi(:,3))
	
seq='zyzz'; REF=1;
DataButeeGH = AjusButee(DataAngleFiltpi(:,22:24),seq,REF,X);

%% Interpolation essai
LgPhase=FinForce-DebutForce;
LgTotale=1000;
    % Vecteur temps initial
x1 = 1:LgPhase;
    % Nouveaux vecteur temps desir�
A3=linspace(1,length(x1),LgTotale);
    % Nouvelles donn�es

InterpTH1=interp1(x1,DataButeeTH(DebutForce+1:FinForce,:),A3,'spline');
InterpGH1=interp1(x1,DataButeeGH(DebutForce+1:FinForce,:),A3,'spline');
% InterpQ1=interp1(x1,DataButee(DebutForce+1:FinForce,[1:14]),A3,'spline');
% InterpQ11=interp1(x1,DataButee(DebutForce+1:FinForce,[16:18]),A3,'spline');
% InterpQ111=interp1(x1,DataButee(DebutForce+1:FinForce,[22:end]),A3,'spline');
InterpST1=interp1(x1,DataST1(DebutForce+1:FinForce,:),A3,'spline'); 
% Vec=NaN(1000,1);
% InterpQ1=[InterpQ1 Vec InterpQ11 Vec Vec Vec InterpQ111];


end