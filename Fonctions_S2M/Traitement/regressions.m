clear;clc;close all

MatriceH=load('E:\Projet_LeverCaisse\Landry_LeverCaisse\IRSST.mat\StatsisticaEMGMoyHOMME.mat');
MatriceH=MatriceH.StatsisticaEMGMoyHOMME;

MatriceF=load('E:\Projet_LeverCaisse\Landry_LeverCaisse\IRSST.mat\StatsisticaEMGMoyFEMME.mat');
MatriceF=MatriceF.StatsisticaEMGMoyFEMME;

% Poids relatif Homme(xH) et Femme (xF)
xH=[9.090909091;9.230769231;8.108108108;6.666666667;8.219178082;6;8;8;8.571428571;8.333333333;18.18181818;18.46153846;16.21621622;13.33333333;16.43835616;12;16;16;17.14285714;16.66666667;27.27272727;27.69230769;24.32432432;20;24.65753425;18;24;24;25.71428571;25];
xF=[10.52631579;10;10;10.90909091;11.53846154;8.571428571;10.34482759;10.90909091;21.05263158;20;20;21.81818182;23.07692308;17.14285714;20.68965517;21.81818182];
xH = [ ones(size(xH)) xH ] ;
xF = [ ones(size(xF)) xF ] ; % il faut mettre une colonne de 1 devant les x
%% Organisation données
varMuscleF_tmp=1:36:360;varMuscleF=[varMuscleF_tmp(:,1:2) varMuscleF_tmp(:,6) varMuscleF_tmp(:,9)];

for i=1:size(varMuscleF,2)
	H1MatriceF=[MatriceF(:,varMuscleF(i):varMuscleF(i)+2);MatriceF(:,varMuscleF(i)+3:varMuscleF(i)+5)]; H4MatriceF=[MatriceF(:,varMuscleF(i)+18:varMuscleF(i)+20);MatriceF(:,varMuscleF(i)+21:varMuscleF(i)+23)];
	yFH1_tmp=max(H1MatriceF');yFH1_tmp=yFH1_tmp';yFH4_tmp=max(H4MatriceF');yFH4_tmp=yFH4_tmp';
	yFH1(:,i)=yFH1_tmp;yFH4(:,i)=yFH4_tmp;
end

varMuscleH_tmp=1:54:540;varMuscleH=[varMuscleH_tmp(:,1:2) varMuscleH_tmp(:,6) varMuscleH_tmp(:,9)];

for j=1:size(varMuscleH,2)
	H1MatriceH=[MatriceH(:,varMuscleH(j):varMuscleH(j)+2);MatriceH(:,varMuscleH(j)+3:varMuscleH(j)+5);MatriceH(:,varMuscleH(j)+6:varMuscleH(j)+8)]; H4MatriceH=[MatriceH(:,varMuscleH(j)+36:varMuscleH(j)+38);MatriceH(:,varMuscleH(j)+39:varMuscleH(j)+41);MatriceH(:,varMuscleH(j)+42:varMuscleH(j)+44)];
	yHH1_tmp=max(H1MatriceH');yHH1_tmp=yHH1_tmp';yHH4_tmp=max(H4MatriceH');yHH4_tmp=yHH4_tmp';
	yHH1(:,j)=yHH1_tmp;yHH4(:,j)=yHH4_tmp;
end


%%

NomdeMuscle={'Deltoïde antérieur';'Deltoïde median';'Trapèze supérieur';'Biceps'};
NomdeFigH1={'H1DeltAnt';'H1DeltMed';'H1TrapSup';'H1Biceps'};
NomdeFigH4={'H4DeltAnt';'H4DeltMed';'H4TrapSup';'H4Bicepss'};
NomdeFigHF={'Deltoïde antérieur','Deltoïde median','Trapèze supérieur','Biceps'};

% regression lineaire
% y = activations
% x = poids
for p = 1:size(yHH1,2)
	NomdeFigure_tmp=NomdeMuscle(p,:);NomdeFigure= sprintf('%s',NomdeFigure_tmp{:});
	yh = yHH1(:,p);
	yf = yFH1(:,p);
	xmax = max(max([xH ; xF])) ; 
	% il faut mettre une colonne de 1 devant les x
	[b,~,~,~,stats] = regress (yh,xH) ;
	% Calcul du R carre ajusté
	ymodel = b(2,1)*xH(:,2) + b(1,1) ;
	SSE = sum((yh-ymodel).^2) ;
	SST = sum ((yh - mean(yh)).^2) ;
	Rcarre_adjus(1,1) = 1-((SSE*(length(yh)-1))/(SST*((length(yh)-2-1)))) ;
	
	% affichage
	% hommes
	figure1=figure;
	subplot1 = subplot(1,1,1) ;
	set(subplot1,'FontSize',15)
	title(NomdeFigure(p,:),'fontsize',18)
	
	hold(subplot1,'all');
	plot(xH(:,2),yh,'bo') ; hold on	
	
	regrH = b(2,1)*[min(xH(:,2)):1:max(xH(:,2))] + b(1,1) ;
	
	
	finalH = [b' Rcarre_adjus stats(:,2:3)] ;	
	text(3,95,['R^{2}_{adj} hommes = ' num2str((round(Rcarre_adjus*100))/100) '; p = ' num2str((round(stats(:,3)*10000))/10000) ],'FontSize',15)
	ylim([0 100]) ; xlim([0 xmax+5])
	hold on

	[a,~,~,~,statsa] = regress (yf,xF) ;
	% Calcul du R carre ajusté
	ymodel = a(2,1)*xF(:,2) + a(1,1) ;
	SSE = sum((yf-ymodel).^2) ;
	SST = sum ((yf - mean(yf)).^2) ;
	Rcarre_adjus(1,1) = 1-((SSE*(length(yf)-1))/(SST*((length(yf)-2-1)))) ;
	text(3,88,['R^{2}_{adj} femmes = ' num2str((round(Rcarre_adjus*100))/100) '; p = ' num2str((round(statsa(:,3)*10000))/10000) ],'FontSize',15)
	ylim([0 100]) ; xlim([0 xmax+5])
	% affichage
	% femmes
	plot(xF(:,2),yf,'r.','markersize',20) ; hold on
	legend('HOMME','FEMME')
	regrF = a(2,1)*[min(xF(:,2)):1:max(xF(:,2))]+ a(1,1) ;
	plot([min(xF(:,2)):1:max(xF(:,2))],regrF,'r','linewidth',1.5)
	plot([min(xH(:,2)):1:max(xH(:,2))],regrH,'--b','linewidth',1.5)
	
	%    set(gca,'XTick',-pi:pi/2:pi)
	%    set(gca,'XTickLabel',{'-pi','-pi/2','0','pi/2','pi'})
	%    title('Sine Function');
	%    xlabel('Radians');
	%    ylabel('Function Value');


	
	xlabel('Masse relative de la caisse (%)','fontsize',18)
	ylabel('Niveau d''activation EMG moyen (%)','fontsize',18)
	
	finalF = [a' Rcarre_adjus statsa(:,2:3)] ;
% 	figureFullScreen(figure1)
% pause(0.001)
% 		print(figure1,'-dmeta',NomdeFigure)
end
% 
% for p = 1:size(yHH4,2)
% 	NomdeFigure_tmp=NomdeMuscle(p,:);NomdeFigure= sprintf('%s',NomdeFigure_tmp{:});
% 	yh = yHH4(:,p);
% 	yf = yFH4(:,p);
% 	xmax = max(max([xH ; xF])) ; 
% 	% il faut mettre une colonne de 1 devant les x
% 	[c,~,~,~,statsc] = regress (yh,xH) ;
% 	
% 	% Calcul du R carre ajusté
% 	ymodel = c(2,1)*xH(:,2) + c(1,1) ;
% 	SSE = sum((yh-ymodel).^2) ;
% 	SST = sum ((yh - mean(yh)).^2) ;
% 	Rcarre_adjus(1,1) = 1-((SSE*(length(yh)-1))/(SST*((length(yh)-2-1)))) ;
% 	
% 	% affichage
% 	figure2=figure;
% 	subplot1 = subplot(1,1,1) ;
% 	set(subplot1,'FontSize',15)
% 	hold(subplot1,'all');
% 	title(NomdeMuscle(p,:),'fontsize',18);
% 	plot(xH(:,2),yh,'bo') ; hold on
% 	
% 	regrH4 = c(2,1)*[min(xH(:,2)):1:max(xH(:,2))] + c(1,1) ;
% 	
% 	finalH = [c' Rcarre_adjus statsc(:,2:3)] ;
% 	text(3,95,['R^{2}_{adj} hommes = ' num2str((round(Rcarre_adjus*100))/100) '; p = ' num2str((round(statsc(:,3)*10000))/10000) ],'FontSize',15)
% 	ylim([0 100]) ; xlim([0 xmax+5])
% 	hold on
% 
% 	
% 	[d,~,~,~,statsd] = regress (yf,xF) ;
% 	% Calcul du R carre ajusté
% 	ymodel = d(2,1)*xF(:,2) + d(1,1) ;
% 	SSE = sum((yf-ymodel).^2) ;
% 	SST = sum ((yf - mean(yf)).^2) ;
% 	Rcarre_adjus(1,1) = 1-((SSE*(length(yf)-1))/(SST*((length(yf)-2-1)))) ;
% 	
% 	% affichage
% 	plot(xF(:,2),yf,'r.','markersize',20) ; hold on
% 	regrF4 = d(2,1)*[min(xF(:,2)):1:max(xF(:,2))] + d(1,1) ;
% 	legend('HOMME','FEMME');
% 	plot([min(xH(:,2)):1:max(xH(:,2))],regrH4,'--b','linewidth',1.5)
% 	plot([min(xF(:,2)):1:max(xF(:,2))],regrF4,'r','linewidth',1.5)
% 	
% 	
% 	finalF = [d' Rcarre_adjus statsd(:,2:3)] ;
% 	text(3,88,['R^{2}_{adj} femmes = ' num2str((round(Rcarre_adjus*100))/100) '; p = ' num2str((round(statsd(:,3)*10000))/10000) ],'FontSize',15)
% 	ylim([0 100]) ; xlim([0 xmax+5])
% 	
% 	xlabel('Masse relative de la caisse (%)','fontsize',18)
% 	ylabel('Niveau d''activation EMG moyen (%)','fontsize',18)
% 	
% 	figureFullScreen(figure2)
% pause(0.001)
% 		print(figure2,'-dmeta',NomdeFigure)
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%% on mélange homme et femme et on compare H1 avec H4
for p = 1:size(yHH1,2)
	NomdeFigure_tmp=NomdeFigHF{p};NomdeFigure= sprintf('%s',NomdeFigure_tmp) ;
	yhf = [yHH1(:,p) ; yFH1(:,p)] ;
	xHF = [xH ; xF] ;
	xmax = max(max(xHF)) ; 
	
	
	% il faut mettre une colonne de 1 devant les x
	[b,~,~,~,statsH1] = regress (yhf,xHF) ;
	% Calcul du R carre ajusté
	ymodel = b(2,1)*xHF(:,2) + b(1,1) ;
	SSE = sum((yhf-ymodel).^2) ;
	SST = sum ((yhf - mean(yhf)).^2) ;
	Rcarre_adjus(1,1) = 1-((SSE*(length(yhf)-1))/(SST*((length(yhf)-2-1)))) ;
		
	% affichage
	figure1=figure;
	subplot1 = subplot(1,1,1) ;
	set(subplot1,'FontSize',15)
	title(NomdeFigure_tmp,'fontsize',18)	
	hold(subplot1,'all');
	
	
	plot(xHF(:,2),yhf,'bo') ; hold on	
	text(3,95,['R^{2}_{adj} D_{H->E} = ' num2str((round(Rcarre_adjus*100))/100) '; p = ' num2str((round(statsH1(:,3)*10000))/10000) ],'FontSize',15)

	
	

	
	ylim([0 100]) ; xlim([0 xmax+5])
	hold on
		
	
	yhf = [yHH4(:,p) ; yFH4(:,p)] ;
	xHF = [xH ; xF] ;
	% il faut mettre une colonne de 1 devant les x
	[b,~,~,~,statsH4] = regress (yhf,xHF) ;
	% Calcul du R carre ajusté
	ymodel = b(2,1)*xHF(:,2) + b(1,1) ;
	SSE = sum((yhf-ymodel).^2) ;
	SST = sum ((yhf - mean(yhf)).^2) ;
	Rcarre_adjus(1,1) = 1-((SSE*(length(yhf)-1))/(SST*((length(yhf)-2-1)))) ;	
	
	% affichage
	plot(xHF(:,2),yhf,'r.','markersize',20) ; hold on
	text(3,88,['R^{2}_{adj} D_{H->Y} = ' num2str((round(Rcarre_adjus*100))/100) '; p = ' num2str((round(statsH4(:,3)*10000))/10000) ],'FontSize',15)
    legend('D_{H->E}','D_{H->Y}')
	%Revient a H1 pour la lengede
	
% 	if statsH1(1,3)<0.05
	regrH1 = b(2,1)*[min(xHF(:,2)):1:max(xHF(:,2))] + b(1,1) ;	
	plot([min(xHF(:,2)):1:max(xHF(:,2))],regrH1,'--b','linewidth',1.5)
% 	end
	
% 	if statsH4(1,3)<0.05
	regrH4 = b(2,1)*[min(xHF(:,2)):1:max(xHF(:,2))] + b(1,1) ;
	plot([min(xHF(:,2)):1:max(xHF(:,2))],regrH4,'-r','linewidth',1.5)	
% 	end
		
	ylim([0 100]) ; xlim([0 xmax+5])		
	xlabel('Masse relative de la caisse (%)','fontsize',18)
	ylabel('Niveau d''activation moyen EMG (%)','fontsize',18)
	
	
% 	if statsH1(1,3)<0.05 && statsH4(1,3)<0.05
% % 		legend('D_{H->E}','Régression linéaire','D_{H->Y}','Régression linéaire')
% 		legend('D_{H->E}','','D_{H->Y}','')
% % 		legend('D_{H->E}','D_{H->Y}')
% 	elseif	statsH1(1,3)<0.05 && statsH4(1,3)>0.05
% % 		legend('D_{H->E}','Régression linéaire','D_{H->Y}')
%  		legend('D_{H->E}','','D_{H->Y}')
% % 		legend('D_{H->E}','D_{H->Y}')
% 	elseif	statsH1(1,3)>0.05 && statsH4(1,3)<0.05
%  		legend('D_{H->E}','D_{H->Y}','Régression linéaire')
% % 		legend('D_{H->E}','D_{H->Y}')
% 	else legend('D_{H->E}','D_{H->Y}')
% 	end
	
	
% 	figureFullScreen(figure1)
% pause(0.001)
% 		print(figure1,'-dmeta',NomdeFigure)
end
