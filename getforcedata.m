function [Force] = getforcedata(subject)
%% Dossier des essais
folderPath = ['\\10.89.24.15\f\Data\Shoulder\RAW\IRSST_' subject 'd\trials\'];
%% noms des fichiers c3d
C3dfiles = dir([folderPath '*.c3d']);
%% Ouvertures des c3d analogiques (EMG & Force)
    for i = 1 : length(C3dfiles)
        FileName = [folderPath C3dfiles(i).name]; 
        btkc3d = btkReadAcquisition(FileName);
        btkanalog = btkGetAnalogs(btkc3d);
%% Obtenir la force brute   
        for f = 1 : 6
            Force(i).Raw(:,f) = getfield(btkanalog, ['Voltage_' num2str(f)] );
        end
%% Rebase
Forcerebase = [];
    for j =1:6
        Force(i).rebase(:,j) = Force(i).Raw(:,j)-mean(Force(i).Raw(1:100,j));
    end        
%% Traitement Force pour onset|offset
	% Fonction permettant de trouver les onset|offset avec force
[~, ~, F_onset, F_offset] = Force_thre_output(Force(i).rebase);
%% Variable d'exportation 
Force(i).onsetensec = F_onset/2000;
Force(i).offsetensec = F_offset/2000;
    end    
end
