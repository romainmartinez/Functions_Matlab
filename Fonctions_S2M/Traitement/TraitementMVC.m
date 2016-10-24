function Nrms = TraitementMVC(Sujet, DataMVCBrut, FenetreRMS, FreqEMG);


% band pass filter
    DataT = bandfilter(DataMVCBrut(:,:),15,500,FreqEMG,'damped');
% Offset
    DataOffset= DataT-ones(size(DataT,1),1)*mean(DataT);

        Nrms = nan(size(DataOffset));
        for i = FenetreRMS:size(DataOffset,1)-FenetreRMS-1
            Nrms(i,:) = rms(DataOffset(i-FenetreRMS+1:i+FenetreRMS,:));
        end 







end

