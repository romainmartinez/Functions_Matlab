function [Data] = getforcedata(Alias)
    % Dossier des essais
folderPath = ['\\10.89.24.15\f\Data\Shoulder\RAW\IRSST_' Alias.sujet 'd\trials\'];
    % noms des fichiers c3d
C3dfiles = dir([folderPath '*.c3d']);

    % Ouvertures des c3d analogiques (EMG & Force)
    for i = 1 : length(C3dfiles)
        FileName = [folderPath C3dfiles(i).name]; 
        btkc3d = btkReadAcquisition(FileName);
        btkanalog = btkGetAnalogs(btkc3d);
        
        for f = 1 : 6
            Data(i).force(:,f) = getfield(btkanalog, ['Voltage_' num2str(f)] );
        end
    end
    
end
