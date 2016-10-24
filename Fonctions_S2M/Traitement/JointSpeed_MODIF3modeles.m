function [InterpTH1,InterpST1,InterpTH1M3,InterpST1M3,InterpTH1M13,InterpST1M13]=JointSpeed_MODIF3modeles(DataAngleBrut,DataTH1Brut,DataST1Brut,DataTH1BrutM3,DataST1BrutM3,DataTH1BrutM13,DataST1BrutM13)
 
% DataTH1Brut=DataTH1Brut.TH1;
DataTH1Filt=filtreDonneesBrutesAngle(DataTH1Brut*180/pi);
DataTH1Filtpi= unwrap(DataTH1Filt);
    %figure(1); hold on
    X=[1:length(DataTH1Filtpi)]/length(DataTH1Filtpi)*100;
    %plot(X,DataTH1Filtpi(:,1),X,DataTH1Filtpi(:,2),X,DataTH1Filtpi(:,3))
seq='zyzz'; REF=2; % REF= 1 pourGH et REF different de 1 TH
InterpTH1 = AjusButee(DataTH1Filtpi,seq,REF,X);
%DataButeeTH=DataTH1Filtpi;

DataTH1FiltM3=filtreDonneesBrutesAngle(DataTH1BrutM3*180/pi);
DataTH1FiltpiM3= unwrap(DataTH1FiltM3);
    %figure(1); hold on
    X=[1:length(DataTH1FiltpiM3)]/length(DataTH1FiltpiM3)*100;
    %plot(X,DataTH1Filtpi(:,1),X,DataTH1Filtpi(:,2),X,DataTH1Filtpi(:,3))
seq='zyzz'; REF=2; % REF= 1 pourGH et REF different de 1 TH
InterpTH1M3 = AjusButee(DataTH1FiltpiM3,seq,REF,X);
%%
DataTH1FiltM13=filtreDonneesBrutesAngle(DataTH1BrutM13*180/pi);
DataTH1FiltpiM13= unwrap(DataTH1FiltM13);
    %figure(1); hold on
    X=[1:length(DataTH1FiltpiM13)]/length(DataTH1FiltpiM13)*100;
    %plot(X,DataTH1Filtpi(:,1),X,DataTH1Filtpi(:,2),X,DataTH1Filtpi(:,3))
seq='zyzz'; REF=2; % REF= 1 pourGH et REF different de 1 TH
InterpTH1M13 = AjusButee(DataTH1FiltpiM13,seq,REF,X);

%%
% DataST1Brut=DataST1Brut.ST1;
DataST1Filt=filtreDonneesBrutesAngle(DataST1Brut*180/pi);
InterpST1= unwrap(DataST1Filt);

DataST1FiltM3=filtreDonneesBrutesAngle(DataST1BrutM3*180/pi);
InterpST1M3= unwrap(DataST1FiltM3);

DataST1FiltM13=filtreDonneesBrutesAngle(DataST1BrutM13*180/pi);
InterpST1M13= unwrap(DataST1FiltM13);


end