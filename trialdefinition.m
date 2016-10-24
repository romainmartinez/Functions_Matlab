function [poids_h,poids_f,hauteur] = trialdefinition(essai_h,essai_f)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  ____                       _         __  __            _   _                  %
% |  _ \ ___  _ __ ___   __ _(_)_ __   |  \/  | __ _ _ __| |_(_)_ __   ___ ____  %
% | |_) / _ \| '_ ` _ \ / _` | | '_ \  | |\/| |/ _` | '__| __| | '_ \ / _ \_  /  %
% |  _ < (_) | | | | | | (_| | | | | | | |  | | (_| | |  | |_| | | | |  __// /   % 
% |_| \_\___/|_| |_| |_|\__,_|_|_| |_| |_|  |_|\__,_|_|   \__|_|_| |_|\___/___|  %
%                                                                                %  
% Auteur : Romain Martinez                                 Date : Juin 2016      %
% Description : Déterminer Poids et hauteur en fonction de la condition          %
% Input : Numéro de l'essai                                                      % 
% Output : Poids hommes, poids femme, hauteur                                    %                                      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Poids
if essai_h <= 6
	poids_h = '6kg'
elseif essai_h <= 12
	poids_h = '12kg'
elseif essai_h <= 18
	poids_h = '18kg'
	end


if essai_f <= 6
	poids_f = '6kg'
elseif essai_f <= 12
	poids_f = '12kg'
elseif essai_f <= 18
	poids_f = '18kg'
end
%% Hauteurs
	if essai_h == 1 | essai_h == 7 | essai_h == 13
	hauteur = 'hips - shoulders'
elseif essai_h == 2 | essai_h == 8 | essai_h == 14 
	hauteur = 'hips - eyes'
elseif essai_h == 3 | essai_h == 9 | essai_h == 15 
	hauteur = 'shoulders - hips'
elseif essai_h == 4 | essai_h == 10 | essai_h == 16 
	hauteur = 'shoulders - eyes'
elseif essai_h == 5 | essai_h == 11 | essai_h == 17 
	hauteur = 'eyes - hips'
elseif essai_h == 6 | essai_h == 12 | essai_h == 18
	hauteur = 'eyes - shoulders'
	end
	
end