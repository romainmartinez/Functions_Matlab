% Fonction de traitement cinematique

function [DataViconFilt,ValImm,ValIC,ValDebut,ValFin,ValminDist,IminDist, IndPhase] = Kinematics(DataViconFilt,Freqech,OrigineBoite)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%% Découpe de l'éssai en différentes phases %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% 1-Debut phase de lift %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MzavGche=150; %Position su marqueur Avant Gauche de la boite dans le csv 
MyavGche=149;
MxavGche=148;

MavD=151:153;
MarrGche=157:159;
MavGche=148:150;
MarrD= 154:156;

M1=DataViconFilt(:,MavD)+DataViconFilt(:,MarrD)/2;
M2=DataViconFilt(:,MavGche)+DataViconFilt(:,MarrGche)/2;

T1=22:24;
T10=25:27;
MXIPH=28:30;
MSTER=13:15;

ValD= mean(DataViconFilt(1:50,MzavGche)); %6eme colonne= z de marqueur avant-gauche %%%Moyenne des 50 premieres valeurs sur la hauteur(z du Vicon)
Interval=0.25/1000; % Des que les data sont sup ou inf à ValD + ou - l'intervalle
T = DataViconFilt(:,MzavGche)>ValD+Interval | DataViconFilt(:,MzavGche)<ValD-Interval;
ValDebut=find(T,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% 2- Fin de phase de lift %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ValF= mean(DataViconFilt(end-50:end,MzavGche)); %Moyenne des 50 dernieres valeurs sur la hauteur
Interval=0.5/1000; % Des que les data sont comprises entre ValD + ou - l'interval
U = DataViconFilt(:,MzavGche)<ValF+Interval & DataViconFilt(:,MzavGche)>ValF-Interval;
ValFin=find(U,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%  3- Phase d'Immobilisation Boite  %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ValFy= mean(DataViconFilt(end-50:end,MyavGche)); % ValImm est lorsque le marqueur de la boite est immobile en x, y et z
ValFx= mean(DataViconFilt(end-50:end,MxavGche));

R = DataViconFilt(:,MyavGche)<ValFy+Interval & DataViconFilt(:,MyavGche)>ValFy-Interval;
ValFy=find(R,1);

S = DataViconFilt(:,MxavGche)<ValFx+Interval & DataViconFilt(:,MxavGche)>ValFx-Interval;
ValFx=find(S,1);

SValImm=[ValFin ValFy ValFx];
ValImm=max(SValImm);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%  4- Initiation des contraintes  %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Certains muscles sont activés avant le début du mouvement (Wickham et coll, 2009 et Day et coll, 2012) 
% La pré-activation peut débuter au moins 0.235s avant le mouvement selon les muscles et les mouvements
% Donc on détermine l'instant d'initiation des contraintes 0.75sec(TA) avant le mouvement de la caisse

TA=0.5*Freqech; %Obtenir TA en nombre de frame
ValIC= ValDebut-TA;   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%  5- Distance Caisse-Sujet  %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% On calcule ca en regardant la difference sur le y du vicon entre le
% marqueurs STER et le milieu la partie arriere de la boite (moyenne entre
% marqueurs Arriere gauche et Arr droit)

% Calcul distance MTRONC et Origine de la boite en Y (direction antero-post)
MTRONC= DataViconFilt(:,MSTER)-DataViconFilt(:,MXIPH);  %MTRONC est un marqueur virtuel situé entre le marqueurs XIPH et STER
%Dist=nan(DataViconFilt(:,MySTER),1);
Disty= MTRONC-OrigineBoite;

NO=nan(length(Disty),1);
for i=1:length(Disty)
NO(i)= sqrt(sum(Disty(i,1:3).^2));
end
% [ValminDisty,IminDisty] = min(NO);
distance= DistBetween2Segment2(M1, M2, DataViconFilt(:,T1), DataViconFilt(:,T10));

[ValminDist,IminDist] = min(distance);

 % Moitie de la hauteur verticale du marqueur MzAv gauche de la boite
 Interval=0.25/1000; % Des que les data sont sup ou inf à ValD + ou - l'intervalle

 H=ValD-ValF;
 if H>0
    ValPhase=ValD-(H/2); 
    W = DataViconFilt(:,MzavGche)<ValPhase;
    IndPhase=find(W,1);
 else 
    ValPhase=ValD+(abs(H)/2); 
    W = DataViconFilt(:,MzavGche)>ValPhase;
    IndPhase=find(W,1);
 end









