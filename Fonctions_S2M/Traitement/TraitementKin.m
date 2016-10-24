function [DataThorax,InterpDataThorax,DataClavicule,InterpDataClavicule,DataCoude,InterpDataCoude,DataPoignet,InterpDataPoignet]=TraitementKin(AngleBrutQ1,onoff_force)

% 	Pour l'interpolation
LgPhase=onoff_force(2)-onoff_force(1);
LgTotale=1000;
% Vecteur temps initial
x1 = 1:LgPhase;
% Nouveaux vecteur temps desiré
A3=linspace(1,length(x1),LgTotale);

%% Angles articulation TP
	DATATHORAX=AngleBrutQ1(10:12,:);
    DataThoraxBrute=angleRotation(matrice_rotation(DATATHORAX,'xyz'),'xyz');
	DataThoraxBrute_tmp(:,:)=unwrap(DataThoraxBrute(:,1:3,:));
    DataThorax=DataThoraxBrute_tmp'*180/pi;
    % Nouvelles données interpolées
   InterpDataThorax=interp1(x1,DataThorax(onoff_force(1)+1:onoff_force(2),:),A3,'spline');
clear DATATHORAX;clear DataThoraxBrute;clear DataThoraxBrute_tmp;

%% Angles articulation SC
	DATACLAVICULE=AngleBrutQ1(13:14,:);
    DataClaviculeBrute=angleRotation(matrice_rotation(DATACLAVICULE,'zy'),'zy');
	DataClaviculeBrute_tmp(:,:)=unwrap(DataClaviculeBrute(:,1:2,:));
    DataClavicule=DataClaviculeBrute_tmp'*180/pi;
    % Nouvelles données interpolées
   InterpDataClavicule=interp1(x1,DataClavicule(onoff_force(1)+1:onoff_force(2),:),A3,'spline');
clear DATACLAVICULE;clear DataClaviculeBrute;clear DataClaviculeBrute_tmp;   

%% Angles du Coude (Flex-Ext et Prono Sup)
	DATACOUDE=AngleBrutQ1(25:26,:); 
	DataCoudeBrute_tmp(:,:)=unwrap(DATACOUDE(:,:));
    DataCoude=DataCoudeBrute_tmp'*180/pi;
    % Nouvelles données interpolées
   InterpDataCoude=interp1(x1,DataCoude(onoff_force(1)+1:onoff_force(2),:),A3,'spline');
clear DATACOUDE;clear DataCoudeBrute_tmp;

%% Angles du Poignet
	DATAPOIGNET=AngleBrutQ1(27:28,:);
    DataPoignetBrute=angleRotation(matrice_rotation(DATAPOIGNET,'xy'),'xy');
	DataPoignetBrute_tmp(:,:)=unwrap(DataPoignetBrute(:,1:2,:));
	DataPoignet=DataPoignetBrute_tmp'*180/pi;
	% Nouvelles données interpolées	
	InterpDataPoignet=interp1(x1,DataPoignet(onoff_force(1)+1:onoff_force(2),:),A3,'spline');	
clear DATAPOIGNET;clear DataPoignetBrute;clear DataPoignetBrute_tmp;  
%%   
end   