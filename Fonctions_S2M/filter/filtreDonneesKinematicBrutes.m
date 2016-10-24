function DataFilt = filtreDonneesKinematicBrutes(DataBrut)

    
    %%%%%%%%%%%%%%%%%%%%%%%%%  Filtrage des données  %%%%%%%%%%%%%%%%%%%%%%%%%%
    Ordre=4;
    Fc=6;
    
    % Butterworth passe bas d'ordre 2 et de Frequence de coupure 8Hz(Winter et coll, 2005)
    [b,a]= butter(Ordre, Fc/200); 
    DataFilt = filtfilt(b,a, DataBrut);


end