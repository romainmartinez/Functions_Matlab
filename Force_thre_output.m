
function [Fnorm, FTA, f, g] = Force_thre_output(DataForceBrut)
% 	DataForceBrut = Force du capteur Nx6
% 	Etalonnage    = Matrice d'étalonnage (si 6xN)
% 	Fnorm         = Norm des forces filtrées
% 	FTA           = Force dans les 3 axes

%% Étalonnage de du capteur
    % Matrice d'étalonnage
EtalonnageForce=[15.7377 -178.4176 172.9822 7.6998 -192.7411 174.1840;
                 208.3629 -109.1685 -110.3583  209.3269 -104.9032 -103.5278;
                 227.6774 222.8613 219.1087 234.3732 217.1453 221.2831;
                 5.6472 -0.7266 -0.3242 5.4650 -8.9705 -8.4179;
                 5.7700 6.7466 -6.9682 -4.1899 1.5741 -2.4571;
                 -1.2722 1.6912 -3.0543 5.1092 -5.6222 3.3049];

    % Étalonnage de du capteur 
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
