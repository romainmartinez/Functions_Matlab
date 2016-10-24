function [DATAFilt]= filtreDonneesModelisation(RawData)

    
    %%%%%%%%%%%%%%%%%%%%%%%%%  Filtrage des données  %%%%%%%%%%%%%%%%%%%%%%%%%%
FrequenceCoupure=20;
Ordre=4;
AcquisitionFrequency=200;
Wn= AcquisitionFrequency/2;
[b,a] = butter(Ordre,FrequenceCoupure/Wn);

DATAFilt = filtfilt(b, a, RawData);
end