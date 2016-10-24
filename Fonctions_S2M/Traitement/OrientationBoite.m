function OrientationBoite(DataViconBrut,onoff_force,model) 

% 	Pour l'interpolation
LgPhase=onoff_force(2)-onoff_force(1);
LgTotale=1000;
% Vecteur temps initial
x1 = 1:LgPhase;
% Nouveaux vecteur temps desiré
A3=linspace(1,length(x1),LgTotale);

% Filtre des données brutes
	DataViconFilt = filtreDonneesKinematicBrutes(DataViconBrut);
	DataViconFilt = DataViconFilt / 1000;
	if size(DataAngleBrut.Q1,2) == size(DataViconFilt,1)
	[A,B,C,D,E,F,G,H,J,Ob] = BoiteAngles(DataAngleBrut, model,DataViconFilt);
	else
	DataViconFilt=DataViconFilt(2:end,:);						
	if size(DataAngleBrut.Q1,2) ~= size(DataViconFilt,1)
	DataViconFilt=DataViconFilt(2:end,:);
	[A,B,C,D,E,F,G,H,J,Ob] = BoiteAngles(DataAngleBrut, model,DataViconFilt);
	end
	[A,B,C,D,E,F,G,H,J,Ob] = BoiteAngles(DataAngleBrut, model,DataViconFilt);
	end
	AnglesBoiteThorax_tmp=[A B C];
	AnglesBoiteGlobal_tmp=[D E F];
	AnglesBoitePelvis_tmp=[G H J];

	InterpDataBoiteThorax=interp1(x1,AnglesBoiteThorax_tmp(DebutForce+1:FinForce,:),A3,'spline');
	InterpDataBoiteGlobal=interp1(x1,AnglesBoiteGlobal_tmp(DebutForce+1:FinForce,:),A3,'spline');
	InterpDataBoitePelvis=interp1(x1,AnglesBoitePelvis_tmp(DebutForce+1:FinForce,:),A3,'spline');



