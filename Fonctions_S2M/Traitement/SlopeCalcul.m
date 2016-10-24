function SlopeCalcul(FTNorm)

% UTILISE PEAKDET
plot(FTNorm(:,1))
hold on

%Calcul du pic max de l'acceleration en y et on note l'indice
[~, IdxMaxF]= max(FTNorm);
MaxF = mean(FTNorm(IdxMaxF-10:IdxMaxF+10,2));
plot([IdxMaxF IdxMaxF], ylim,'k:')
% Calcul de la valeur de debut de la montee de l'acceleration
Interval=0.15; % Des que les data sont sup ou inf à ValD + ou - l'intervalle
ValDebutAcc = find(Am(:,2)>Interval,1); 

% Trouver 20% à 80% de la partie accélération
Diff=IdxMaxF-ValDebutAcc;
Diff20= Diff*0.2; Diff20=Diff20+ValDebutAcc; Diff20=round(Diff20);
Diff80= Diff*0.8; Diff80= Diff80+ValDebutAcc; Diff80=round(Diff80);

y1= Am(Diff20,2);
y2= Am(Diff80,2);
PenteACC= (y2-y1)/(Diff80-Diff20);