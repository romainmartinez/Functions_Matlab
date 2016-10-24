%% ANOVA X FACTEUR(S) - Zones o� le p est significatif (< 0.05)

function [x_blue,x_red] = Zones_Grises(alias,spmlisti)

    %Creation de variables de stockage des x pour les plots des areas
    x_blue = nan(1,alias.nInterp);
    x_red  = nan(1,alias.nInterp);

    %Sign = matrice indiquant quand le p est au dessus de la valeur seuil
    Sign = spmlisti.z>spmlisti.zstar ;

    %Trac� des plots de d�but (bleu) et fin (rouge) d�limitant les zones o� le p est au dessus de la valeur seuil 
        %Point initial
        if      ( Sign(1) == 1 ) && ( Sign(2) == 1 ) %premier d'une zone � griser
            x_blue(1,1) = 1;
        elseif  ( Sign(1) == 1 ) && ( Sign(2) == 0 ) %premier seul (trait gris seul)
            %plot([TPS(1) TPS(1)], [-10 10],'color',[0.4 0.4 0.4],'linewidth',2); 
        end   
        %Points interm�diaires
        for iSign = 2:size(Sign,2)-1
            if  ( Sign(iSign-1) == 1 ) && ( Sign(iSign) == 1 ) && ( Sign(iSign+1) == 1 ) %interm�diaire � l'int�rieur d'une zone � griser
                %rien faire
            elseif  ( Sign(iSign-1) == 1 ) && ( Sign(iSign) == 1 ) && ( Sign(iSign+1) == 0 ) %dernier d'une zone � griser
                x_red(1,iSign) = iSign;
            elseif  ( Sign(iSign-1) == 0 ) && ( Sign(iSign) == 1 ) && ( Sign(iSign+1) == 1 ) %premier d'une zone � griser
                x_blue(1,iSign) = iSign;
            elseif  ( Sign(iSign-1) == 0 ) && ( Sign(iSign) == 1 ) && ( Sign(iSign+1) == 0 ) %interm�diaire seul (trait gris seul)
                %plot([TPS(1) TPS(1)], [-10 10],'color',[0.4 0.4 0.4],'linewidth',2);
            end
        end
        %Point final
        if      ( Sign(alias.nInterp-1) == 1 ) && ( Sign(alias.nInterp) == 1 ) %dernier d'une zone � griser
            x_red(1,alias.nInterp) = alias.nInterp;
        elseif  ( Sign(alias.nInterp-1) == 0 ) && ( Sign(alias.nInterp) == 1 ) %dernier seul (trait gris seul)
            %plot([TPS(1) TPS(1)], [-10 10],'color',[0.4 0.4 0.4],'linewidth',2); 
        end  

    %Enlevement des nan dans les vecteurs x_blue et x_red
    x_blue = x_blue(~isnan(x_blue));
    x_red  = x_red(~isnan(x_red));
      
end