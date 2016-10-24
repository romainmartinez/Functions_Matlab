function[Vm,Am,IdxMaxAcc,AmN,VmN]=CalcVitAcc(Ob, FreqKin)

Lg=size(Ob);
Tps=Lg(1)/FreqKin;


Temps=(0:1/FreqKin:Tps-1/FreqKin)'; 
dt = Temps(2)-Temps(1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%  Calcul  vitesse  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Vm = derive(dt, Ob);

% Calcul de la norme de la vitesse
VmN = nan(size(Vm,1),1);
VmN(~isnan(Vm(:,1))) = sqrt( sum( Vm(~isnan(Vm(:,1)),1:3).^2, 2) ); 
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%  Calcul  acceleration  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Am = derive(dt, Vm);

%Calcul du pic max de l'acceleration en y et on note l'indice
[~, IdxMaxAcc]= max(Am(:,2));
% MaxAcc = mean(Am(IdxMaxAcc-10:IdxMaxAcc+10,2));
% 
% % Calcul de la valeur de debut de la montee de l'acceleration
% Interval=0.15; % Des que les data sont sup ou inf à ValD + ou - l'intervalle
% ValDebutAcc = find(Am(:,2)>Interval,1); 
% 
% % Trouver 20% à 80% de la partie accélération
% Diff=IdxMaxAcc-ValDebutAcc;
% Diff20= Diff*0.2; Diff20=Diff20+ValDebutAcc; Diff20=round(Diff20);
% Diff80= Diff*0.8; Diff80= Diff80+ValDebutAcc; Diff80=round(Diff80);
% 
% y1= Am(Diff20,2);
% y2= Am(Diff80,2);
% PenteACC= (y2-y1)/(Diff80-Diff20);
% 
% Calculer la norme de l'accélération
AmN = nan(size(Am,1),1);
AmN(~isnan(Am(:,1))) = sqrt( sum( Am(~isnan(Am(:,1)),1:3).^2, 2) );
% 
% % Max de l'accélération
% [~, IAmN]= max(AmN);
% MaxAmN= mean(AmN(IAmN-10:IAmN+10,:));
