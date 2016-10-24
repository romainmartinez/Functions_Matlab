function DataAngleFilt = filtreDonneesBrutesAngleTest(DataAngleBrut)

    
    %%%%%%%%%%%%%%%%%%%%%%%%%  Filtrage des données  %%%%%%%%%%%%%%%%%%%%%%%%%%
    Ordre=2;
    Fc=8;
    
    % Butterworth passe bas d'ordre 2 et de Frequence de coupure 8Hz(Winter et coll, 2005)
    [b,a]= butter(Ordre, Fc/200); 
    DataAngleFilt = filtfilt(b,a, DataAngleBrut);


end