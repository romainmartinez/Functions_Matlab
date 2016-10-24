%%%% Fonction qui traite la Force et repere les index de debut et finn
%%%% d'application de force sur la poignée

function [FTA, f, g] = Force_thre(DataForceBrut, Etalonnage)
% Étalonne les données brutes
Feta= DataForceBrut*Etalonnage';

% Butterworth
[B,A]= butter(4,10/100);
Fetafilt= filtfilt(B,A,Feta);

% Sortir que les Fx, Fy, Fz
FTA=Fetafilt(:,1:3);
Fnorm = sqrt(sum(FTA.^2,2));
%figure;plot(Fnorm);
% Initiation des contraintes sur le capteur F diferents de 0
step=5;
f=1;
while Fnorm(f)<10; f=f+2*step; end
while Fnorm(f)-Fnorm(f-step)>0; f=f-step; end
step=2;
Fnorm=Fnorm(1:end-50,:);
g=length(Fnorm);
while Fnorm(g)<15; g=g-2*step; end
while Fnorm(g)-Fnorm(g-step)>0; g=g+step; end
end
% 
% 
% ValFmin= mean(FTA(1:250,:)); %Moyenne des 50 premieres valeurs de la force en x, y et z
% Interval=3; % Des que les data sont sup ou inf à ValFmin + ou - 3 Newtons
% 
% T = FTA(:,1)>ValFmin(:,1)+Interval | FTA(:,1)<ValFmin(:,1)-Interval;
% ValDForceX=find(T,1);
% 
% U= FTA(:,2)>ValFmin(:,2)+Interval | FTA(:,2)<ValFmin(:,2)-Interval;
% ValDForceY=find(U,1);
% 
% V=FTA(:,3)>ValFmin(:,3)+Interval | FTA(:,3)<ValFmin(:,3)-Interval;
% ValDForceZ=find(V,1);
% 
% SValDForce=[ValDForceX ValDForceY ValDForceZ];
% DebutForce=min(SValDForce)-20; % -20 frames, arbitrairement designé, c'est
% %pour debuter plus proche du vrai augmentation de force
% 
% 
% 
% % Calcul Frame ou le sujet lache la caisse F=0
% ValFinmin= mean(FTA(1:50,:));
% Interval=5;
% InvFTA = rot90(rot90(FTA));
% W =InvFTA(:,1)>ValFinmin(:,1)+Interval | InvFTA(:,1)<ValFinmin(:,1)-Interval;
% ValFForceX=find(W,1);
% 
% X=InvFTA(:,2)>ValFinmin(:,2)+Interval | InvFTA(:,2)<ValFinmin(:,2)-Interval;
% ValFForceY=find(X,1);
% 
% Y=InvFTA(:,3)>ValFinmin(:,3)+Interval | InvFTA(:,3)<ValFinmin(:,3)-Interval;
% ValFForceZ=find(Y,1);
% 
% SValFForce=[ValFForceX ValFForceY ValFForceZ];
% FinForceF=min(SValFForce);
% FinForce= length(FTA)-FinForceF+30; % 30frame ici car Intervalle à 5 Newton
