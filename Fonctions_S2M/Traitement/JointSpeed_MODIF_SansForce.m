function [DataButeeTH,DataButee,DataST1Filtpi,DataButeeGH]=JointSpeed_MODIF(DataAngleBrut,DataTH1Brut,DataST1Brut)
 
DataTH1Filtunwrap= unwrap(DataTH1Brut);
% DataTH1Filt=filtreDonneesBrutesAngle(DataTH1Filtunwrap*180/pi);

    %figure(1); hold on
    X=[1:length(DataTH1Filtunwrap)]/length(DataTH1Filtunwrap)*100;
    %plot(X,DataTH1Filtpi(:,1),X,DataTH1Filtpi(:,2),X,DataTH1Filtpi(:,3))
	
seq='zyzz'; REF=2; % REF= 1 pourGH et REF different de 1 TH
DataButeeTH = AjusButee(DataTH1Filtunwrap,seq,REF,X);

% DataST1Filt=filtreDonneesBrutesAngle(DataST1Brut*180/pi);
DataST1Filtpi= unwrap(DataST1Brut);


DataAngleBrut= DataAngleBrut.Q1';
% DataAngleFilt = filtreDonneesBrutesAngle(DataAngleBrut*180/pi);
DataAngleFiltpi= unwrap(DataAngleBrut);
    %figure(2); hold on
    X=[1:length(DataAngleFiltpi)]/length(DataAngleFiltpi)*100;
    %plot(X,DataAngleFiltpi(:,1),X,DataAngleFiltpi(:,2),X,DataAngleFiltpi(:,3))
	
seq='zyzz'; REF=1;
DataButeeGH = AjusButee(DataAngleFiltpi(:,22:24),seq,REF,X);
DataButee=DataAngleFiltpi;
DataButee(:,22:24)=DataButeeGH;

% figure;
% plot(DataAngleBrut(:,24)*180/pi,'b');hold on;
% % plot(DataAngleFiltpi(:,22)*180/pi,'r');
% plot(DataButee(:,24),'g');
% plot([DebutForce DebutForce], ylim,'k:');
% plot([FinForce FinForce], ylim,'k:');


end