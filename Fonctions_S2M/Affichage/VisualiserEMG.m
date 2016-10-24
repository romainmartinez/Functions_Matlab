%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script qui permet de verifier 1 fichier à la fois%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%close all, clc, clear all

% addpath('E:\Personnel\Frank\Automne 2012\Antoine_EMG\Force-EMG')
% addpath('E:\Personnel\Frank\Automne 2012\Antoine_EMG\MVC')
% addpath('E:\Personnel\Frank\Automne 2012\Antoine_EMG\Prgm')
addpath('F:\Data\Epaule_manutention\LanD\MVC')
addpath('F:\Projet_LeverCaisse\Landry_LeverCaisse\Resultats\LanD')

DataEMG=uigetfile('*.*','Quel fichier tu veux regarder Michel?');
DataMVCBrut=dlmread(DataEMG,',',5,8); % Lecture du fichier EMG choisi

% Variables Pré-recquise
Fa=2000;     %Frequence d'acquisition de l'EMG
fenetre = 250; % fenetre de la rms en ms
fclp = 5;    %Frequence de coupure du filtre low pass


   % band pass filter
DataT = bandfilter(DataMVCBrut(:,:),15,500,Fa,'damped');
   
   % rectification des envellope d'EMGs
DataEMGfilt= abs(DataT);

%    % filtrage des signaux EMGs avec passe bas à 5Hz 
% DataEMGfilt = lpfilter(DataR,fclp,Fa,'damped');
   
   % Calcul de la RMS avec fenetre de 250ms
 Taille= size(DataEMGfilt);
 RMS=nan(Taille);
 
 for k = fenetre:Taille(1)-fenetre-1;
     RMS(k,:)= rms(DataEMGfilt(k-fenetre+1:k+fenetre,:));
 end
 Maxessai= max(RMS);
 
%  MatMVCMat=uigetfile('*.*','Quel fichier tu veux regarder Michel?');
%  load MatMVCMat

  
% AFFICHAGE en subplot avec 3 figure par subplot 1-Bruté 2-filtré 3-RMSé 
%%% 1) LES DELTOIDES
figure
subplot(3,1,1); %plot(DataMVCBrut(:,1),'r');
title('DeltoidsBrute');
% hold on
% plot(DataMVCBrut(:,2),'g')
plot(DataMVCBrut(:,3))
 
subplot(3,1,2); %plot(DataEMGfilt(:,1),'r');
title('DeltoidsFiltre');
% hold on
%  plot(DataEMGfilt(:,2),'g')
 plot(DataEMGfilt(:,3))

subplot(3,1,3); %plot(RMS(:,1)/MatMVCMat(:,1)*100,'r'); 
title('DeltoidsRMS');
%  hold on
%  plot(RMS(:,2)/MatMVCMat(:,2)*100,'g')
  plot(RMS(:,3)/MatMVCMat(:,3)*100)





%%% 2) LATISSIMUS DORSI ET PECTORALIS
figure
subplot(3,1,1); %plot(DataMVCBrut(:,4),'r');
title('Latissimus_et_Pectoralis_Brute');
% hold on
 plot(DataMVCBrut(:,5),'g')
 
subplot(3,1,2); %plot(DataEMGfilt(:,4),'r');
title('Latissimus_et_Pectoralis_Filtre');
% hold on
 plot(DataEMGfilt(:,5),'g')

subplot(3,1,3); %plot(RMS(:,4)/MatMVCMat(:,4)*100,'r'); 
title('Latissimus_et_Pectoralis_RMS');
% hold on
 plot(RMS(:,5)/MatMVCMat(:,5)*100,'g')

%%% 3) LES TRAPEZES
figure
subplot(3,1,1); %plot(DataMVCBrut(:,6),'r');
title('TrapezeBrute');
% hold on
%  plot(DataMVCBrut(:,7),'g')
%  hold on
 plot(DataMVCBrut(:,8))
 
subplot(3,1,2); %plot(DataEMGfilt(:,6),'r');
title('TrapezeFiltre');
% hold on
%  plot(DataEMGfilt(:,7),'g')
%   hold on
  plot(DataEMGfilt(:,8))

subplot(3,1,3); %plot(RMS(:,6)/MatMVCMat(:,6)*100,'r'); 
title('TrapezeRMS');
% hold on
%  plot(RMS(:,7)/MatMVCMat(:,7)*100,'g')
%   hold on
 plot(RMS(:,8)/MatMVCMat(:,8)*100)

%%% 4) BICEPS TRICEPS STERNOCLEIDOMASTOIDIEN
figure
 subplot(3,1,1); plot(DataMVCBrut(:,9),'r');
title('Biceps_Triceps_SCM_Brute');
% hold on
%  plot(DataMVCBrut(:,10),'g')
% plot(DataMVCBrut(:,11))
 
 subplot(3,1,2); plot(DataEMGfilt(:,9),'r');
title('Biceps_Triceps_SCM_Filtre');
% hold on
% plot(DataEMGfilt(:,10),'g')
%plot(DataEMGfilt(:,11))

 subplot(3,1,3); plot(RMS(:,9)/MatMVCMat(:,9)*100,'r'); 
title('Biceps_Triceps_SCM_RMS');
% hold on
%  plot(RMS(:,10)/MatMVCMat(:,10)*100,'g')
%plot(RMS(:,11)/MatMVCMat(:,11)*100)
 

