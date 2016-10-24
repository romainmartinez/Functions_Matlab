%%%% Fonction qui traite la Force et repere les index de debut et finn
%%%% d'application de force sur la poignï¿½e

function [FTA_Offset, f, g] = Force_thre_output_v3(DataForceBrut, Etalonnage)
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
FTA_Offset(:,1)=FTA(:,1)-nanmean(FTA(1:100,1));
FTA_Offset(:,2)=FTA(:,2)-nanmean(FTA(1:100,2));
FTA_Offset(:,3)=FTA(:,3)-nanmean(FTA(1:100,3));

Fnorm = sqrt(sum(FTA_Offset.^2,2));

FenetreRMS=250;
RMS = nan(size(Fnorm));
    for j = FenetreRMS:size(Fnorm,1)-FenetreRMS-1
        RMS(j,:) = rms(Fnorm(j-FenetreRMS+1:j+FenetreRMS,:));
	end
Fnorm=RMS(FenetreRMS:end-FenetreRMS-1);	


figure;
plot(Fnorm); hold on;title('DEBUT ET FIN');
[x y] = ginput(2); 
f = round(x(1,:)); g = round(x(2,:));
clear y; clear x; close; 	


end
% 
