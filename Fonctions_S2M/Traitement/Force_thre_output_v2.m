%%%% Fonction qui traite la Force et repere les index de debut et finn
%%%% d'application de force sur la poignï¿½e

function [FTA, f, g] = Force_thre_output_v2(DataForceBrut, Etalonnage)
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

% Initiation des contraintes sur le capteur F diferents de 0
step=10;
f=11;
if mean(Fnorm(1:100))>10
figure;
plot(Fnorm); hold on;title('DEBUT');
[x y] = ginput(1); 
f = round(x);
clear y; clear x; close; 	
elseif Fnorm(1)-min(Fnorm(1:100))==0
	f=1;
% while Fnorm(f)<20; f=f+step; end
% while Fnorm(f)-Fnorm(f-step)>0;f=f-5;end
end


step=10;
g=length(Fnorm);
if mean(Fnorm(end-100:end))>15
figure;
plot(Fnorm); hold on;title('FIN');
[x y] = ginput(1); 
g = round(x);
clear y; clear x; close; 
else 
while Fnorm(g)<20; g=g-2*step; end
while Fnorm(g)-Fnorm(g+step)>0; g=g+step; end
end


end
% 
