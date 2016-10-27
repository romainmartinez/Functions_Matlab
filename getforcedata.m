function [Force] = getforcedata(Alias)
%% Dossier des essais
folderPath = ['\\10.89.24.15\f\Data\Shoulder\RAW\IRSST_' Alias.sujet 'd\trials\'];
%% noms des fichiers c3d
C3dfiles = dir([folderPath '*.c3d']);
%% Matrice d'�talonnage
EtalonnageForce=[15.7377 -178.4176 172.9822 7.6998 -192.7411 174.1840;
                 208.3629 -109.1685 -110.3583  209.3269 -104.9032 -103.5278;
                 227.6774 222.8613 219.1087 234.3732 217.1453 221.2831;
                 5.6472 -0.7266 -0.3242 5.4650 -8.9705 -8.4179;
                 5.7700 6.7466 -6.9682 -4.1899 1.5741 -2.4571;
                 -1.2722 1.6912 -3.0543 5.1092 -5.6222 3.3049];
%% Ouvertures des c3d analogiques (EMG & Force)
    for i = 1 : length(C3dfiles)
        FileName = [folderPath C3dfiles(i).name]; 
        btkc3d = btkReadAcquisition(FileName);
        btkanalog = btkGetAnalogs(btkc3d);
%% Obtenir la force brute   
        for f = 1 : 6
            Force(i).Raw(:,f) = getfield(btkanalog, ['Voltage_' num2str(f)] );
        end
%% �talonnage du capteur
% Feta= Force(i).Raw*EtalonnageForce';
    end

    
end