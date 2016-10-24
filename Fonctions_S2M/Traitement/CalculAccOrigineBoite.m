function [Vm,AccelerationLineaireBoite]=CalculAccOrigineBoite(DataViconBrut,onoff_force,FreqKin)

 % Filtre des données brutes
 DataViconFilt = filtreDonneesKinematicBrutes(DataViconBrut)/1000;

% Creer le repere boite
 AvG= DataViconFilt(:,148:150);
 AvD= DataViconFilt(:,151:153);
 ArrG= DataViconFilt(:,157:159);
 ArrD= DataViconFilt(:,154:156);

q=size(ArrD);
Ob = nan(size(ArrD));

for i= 1:q(1)
	 Ob(i,:) = (((AvG(i,:)+ArrD(i,:))/2)+(AvD(i,:)+ArrG(i,:))/2)/2;	
end

Lg=size(Ob);
Tps=Lg(1)/FreqKin;
Temps=(0:1/FreqKin:Tps-1/FreqKin)'; 
dt = Temps(2)-Temps(1);
for j=1:length(Ob)-2
Vm(j,:) = (Ob(j+1,:)-Ob(j,:))/dt;
AccelerationLineaireBoite(j,:) =(((Ob(j+2,:)-Ob(j+1,:))/dt)-((Ob(j+1,:)-Ob(j,:))/dt))/dt;
end
% for k=1:length(Vm)-1
% Am(k,:) = (Vm(k+1,:)-Vm(k,:))/dt;
% end

% AccOb=diff(diff(Ob));
% % Lg=size(Ob);
% % Tps=Lg(1)/FreqKin;
% % Temps=(0:1/FreqKin:Tps-1/FreqKin)'; 
% % dt = Temps(2)-Temps(1);
% % Vm = derive(dt, Ob);
% % AccelerationLineaireBoite = derive(dt, Vm);
%% Tu veux la norme de l'acceleration?
% AmN = nan(size(AccelerationLineaireBoite,1),1);
% AmN(~isnan(AccelerationLineaireBoite(:,1))) = sqrt( sum( AccelerationLineaireBoite(~isnan(AccelerationLineaireBoite(:,1)),1:3).^2, 2) );
end