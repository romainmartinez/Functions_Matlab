function [ X ] = interpmakers(X)
% X est la structure de marqueurs où chaque field = 3*n
lengths = structfun(@numel, s)
utiliser fonction @
%     % Remplacer les 0 par NaN
% X(X==0) = nan;
% 
%     % Pourcentage de NaN
% gap = round((sum(isnan(X))*100)/length(X));
% if gap > 10
%     disp('Warning: gap > 10% of the trial. Consider other way to interpolate.')
% end
% 
%     % Interpolate over nan with PCHIP methods
% X = naninterp(X);

end

