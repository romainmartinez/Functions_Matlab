function [Nrms, MaxMuscles] = TraitementEMG(Sujet, DataEMGBrut, FenetreRMS, FreqEMG, Normalize,FiltreRMS)

% band pass filter
    DataT = bandfilter(DataEMGBrut(:,:),15,500,FreqEMG,'damped');
% Offset
    DataOffset= DataT-ones(size(DataT,1),1)*mean(DataT);	

if Normalize	    
        % Recuperation des Max des MVC
        [MatMVCMat] = loadMatMVCMat(Sujet);
    if FiltreRMS   
    % Calcul de la RMS avec fenetre de 250ms
        Nrms = nan(size(DataOffset));
        for i = FenetreRMS:size(DataOffset,1)-FenetreRMS-1
            Nrms(i,:) = (  rms(DataOffset(i-FenetreRMS+1:i+FenetreRMS,:)) ./ MatMVCMat  )*100;
        end
	else % else Filtre Passe bas à 5Hz ordre 20Hz aller retour damped (Robertson et Dowling 2003)
		% Rectification des envellope d'EMGs 
	 DataEMGrect= abs(DataOffset);
	 Nrms = lpfilter(DataEMGrect,5,FreqEMG,'damped');
	 for i=1:length(Nrms)
		Nrms(i,:) = (Nrms(i,:)./MatMVCMat)*100;  
	 end
	end

        % Calcul du max dans la rms normalisée pour chaque muscle
            MaxMuscles = max(Nrms);
% Pas necessaire finalement, on laisse les nan(plutot que 0)pour ne pas introduire de decalage temporel à cause de la RMS
%  		A=nan(FenetreRMS,size(Nrms,2)); 		
% % 		Nrms=[A;Nrms;A] 			
%         % Retirer les nan
%         Nrms = Nrms(~isnan(Nrms(:,1)),:);   
end
end