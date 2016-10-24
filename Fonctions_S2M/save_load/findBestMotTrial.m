function [ActPath, ForcePath,noTrial] = findBestMotTrial(xlsPath, subject, lateralite, condition )
    
% if nargin == 0
%     xlsPath = 'E:\Projet_HuMAnS\Landry_HuMAnS\KinematicModel\SHOULDER\DATA/BILAN IRSST.xlsx';
%     subject = 'DamG';
%     lateralite = 'd';
%     condition = '6H6';
% end
    
    header = 4;
    [data, ~, alldata] = xlsread(xlsPath, subject);
    trials = alldata(header+1:end,1);
    
    
    idx = [];
    for i = 1:length(trials)
        % Ne pas traiter les nan
        if isnan(trials{i})
            continue
        end
        if ~isempty(strfind(trials{i},condition))
            idx = [idx i]; %#ok<AGROW>
        end
    end
    
    % Petit controle
    if sum(diff(idx)) ~= 2
        error('Il n''y a pas exactement 3 essais dans le fichier pour la condition : ''%s'' ou ils ne sont pas cote à cote', condition)
    end
    
    % Récupérer les valeurs de qualité
    val = data(idx,1);
    
    % Par ordre de bon : 200, 202, 201
    idx200 = find(val==200,1);
    idx201 = find(val==201,1);
    idx202 = find(val==202,1);
    
    % Préparer la variable de sortie
    Path = sprintf('%s/%s%s/0kg/OpenSim/',xlsPath(1:strfind(xlsPath, 'DATA')+3), subject, lateralite);
    if ~isempty(idx200)
       noTrial = trials{idx(idx200)};
    elseif ~isempty(idx202)
        noTrial = trials{idx(idx202)};
    elseif ~isempty(idx201)
        noTrial = trials{idx(idx201)};
    else
        noTrial = 0;
    end
	if noTrial ~=0 
	    ForcePath = dir(sprintf('%s/*%s*force.sto', Path, noTrial));
		ActPath = dir(sprintf('%s/*%s*activation.sto', Path, noTrial));
		if isempty(ForcePath) || isempty(ActPath)
			error('ForcePath or ActPath file for %s\%s*%s trial could not be found', Path, subject, noTrial)
		end
    
		% Ajouter le chemin d'accès 
		ForcePath = [Path ForcePath.name];
		ActPath = [Path ActPath.name];
		noTrial = str2num(noTrial(end)); %#ok<ST2NM>
	else
		ForcePath = [];
		ActPath = [];
	end
end

