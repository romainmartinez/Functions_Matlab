%%%% Fonction qui traite la Force et repere les index de debut et finn
%%%% d'application de force sur la poignï¿½e

function [Fnorm, FTA, f, g] = Force_thre_output(DataForceBrut, Etalonnage)
	% DataForceBrut = Force du capteur Nx6
	% Etalonnage = Matrice d'étalonnage (si 6xN)
	% Fnorm = Norm des forces filtrées
	% FTA = Force dans les 3 axes
	
% ï¿½talonne les donnï¿½es brutes
Feta= DataForceBrut*Etalonnage';

% Butterworth
[B,A]= butter(4,10/100);
Fetafilt= filtfilt(B,A,Feta);

% Sortir que les Fx, Fy, Fz
FTA=Fetafilt(:,1:3);
Fnorm = sqrt(sum(FTA.^2,2));

% Initiation des contraintes sur le capteur F diferents de 0
step=5;
f=1;
while Fnorm(f)<15; f=f+2*step; end
while Fnorm(f)-Fnorm(f-step)>0; f=f-step; end
step=2;
Fnorm=Fnorm(1:end-50,:);
g=length(Fnorm);
while Fnorm(g)<15; g=g-2*step; end
while Fnorm(g)-Fnorm(g-step)>0; g=g+step; end
end
% 
