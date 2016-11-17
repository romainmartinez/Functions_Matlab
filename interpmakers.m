function [ markers ] = interpmakers(X)
% % X est la structure de marqueurs où chaque field = 3*n
    % nom des fields
names = fieldnames(X);

    for i = 1 : length(names)
        % nom des marqueurs
    markers(i).name = names{i};
    
        % matrice des marqueurs
    markeraw = getfield(X,names{i});
    
        % remplacer 0 par nan
    markeraw(markeraw == 0) = nan;
    
        % Taille du gap en % de l'essai
    sumnan = round(sum(isnan(markeraw))*100/size(markeraw,1));
        if sumnan > 10
            disp(['Warning markers have gaps > 10% : ' names{i} ' (' num2str(sumnan(1)) '%)'])
            markers(i).gap = max(sumnan);
        end 
        
        % Gap filling avec interpolation cubique
    markers(i).interp= naninterp(markeraw);
    end
end

