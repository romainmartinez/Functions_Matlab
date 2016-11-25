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
    
    %% Boucle pour déterminer la condition
    if      Data(essai).poids == 6
        
        if     Data(essai).hauteur == 1
            Data(essai).condition = 1;
        elseif Data(essai).hauteur == 2
            Data(essai).condition = 2;
        elseif Data(essai).hauteur == 3
            Data(essai).condition = 3;
        elseif Data(essai).hauteur == 4
            Data(essai).condition = 4;
        elseif Data(essai).hauteur == 5
            Data(essai).condition = 5;
        elseif Data(essai).hauteur == 6
            Data(essai).condition = 6;
        end
        
    elseif  Data(essai).poids == 12
        
        if     Data(essai).hauteur == 1
            Data(essai).condition = 7;
        elseif Data(essai).hauteur == 2
            Data(essai).condition = 8;
        elseif Data(essai).hauteur == 3
            Data(essai).condition = 9;
        elseif Data(essai).hauteur == 4
            Data(essai).condition = 10;
        elseif Data(essai).hauteur == 5
            Data(essai).condition = 11;
        elseif Data(essai).hauteur == 6
            Data(essai).condition = 12;
        end
        
    elseif  Data(essai).poids == 18
        
        if     Data(essai).hauteur == 1
            Data(essai).condition = 13;
        elseif Data(essai).hauteur == 2
            Data(essai).condition = 14;
        elseif Data(essai).hauteur == 3
            Data(essai).condition = 15;
        elseif Data(essai).hauteur == 4
            Data(essai).condition = 16;
        elseif Data(essai).hauteur == 5
            Data(essai).condition = 17;
        elseif Data(essai).hauteur == 6
            Data(essai).condition = 18;
        end
        
    end   
end