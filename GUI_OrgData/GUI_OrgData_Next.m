%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  ____                       _         __  __            _   _                  %
% |  _ \ ___  _ __ ___   __ _(_)_ __   |  \/  | __ _ _ __| |_(_)_ __   ___ ____  %
% | |_) / _ \| '_ ` _ \ / _` | | '_ \  | |\/| |/ _` | '__| __| | '_ \ / _ \_  /  %
% |  _ < (_) | | | | | | (_| | | | | | | |  | | (_| | |  | |_| | | | |  __// /   % 
% |_| \_\___/|_| |_| |_|\__,_|_|_| |_| |_|  |_|\__,_|_|   \__|_|_| |_|\___/___|  %
%                                                                                %  
% Auteur : Romain Martinez                                 Date : Juin 2016      %
% Description : Fonction pour générer GUI attribution des data pour a_col_assign %
% Input : fichier c3d                                                            % 
% Output : attribution des voies du fichier c3d                                  %                                      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
						  

if index < 1 | index > length(Muscle_list)
	disp('Index out of range')
else
    L  = get(S.ls,{'string','value'});
    Col_assign{1,index} = L{1}(L{2}(:));
    
    current = find(strcmp(fields, L{1}(L{2}(:))));
    fields(current) = [];
    
    index = index+1;
    if index > length(Muscle_list)
        disp('Assignement complete')
        close all
        save(['Y:\Data\Epaule_manutention\Hommes-Femmes\Data\RAW\' num2str(annee) '\' subject '\' subject '_ColAssign.mat'],'Col_assign')
        disp('Col_assign saved')
    else
    set(S.pb,'string',Muscle_list(index));
    set(S.ls,'string',fields);
    end
end

