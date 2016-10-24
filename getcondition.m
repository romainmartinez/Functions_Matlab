function [Data] = getcondition(Data)
%% Détermine la condition de l'essai en fonction du nom du fichier

for essai = 1 : length(Data)
    %% Boucle pour le poids
    if strcmp(Data(essai).trialname(2:3),'6H') == 1
        Data(essai).poids = 6;                              % 6kg
        Data(essai).trialname(end) = [];                    % permet de retirer le caractère en trop ('_')
    elseif strcmp(Data(essai).trialname(2:4),'12H') == 1
        Data(essai).poids = 12;                             % 12kg
    elseif strcmp(Data(essai).trialname(2:4),'18H') == 1
        Data(essai).poids = 18;                             % 18kg  
    end
    
    %% Boucle pour la hauteur
    for hauteur = 1 : 6
        if strcmp(Data(essai).trialname(end-2),num2str(hauteur)) == 1
            Data(essai).hauteur = hauteur;  
        end
    end
    
end


    
    
    
    
    
end

