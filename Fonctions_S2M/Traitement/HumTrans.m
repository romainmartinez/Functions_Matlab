function T = HumTrans(Q,Sujets,lateralite,modele,model)
    % Cette fonction prend en entr� des Q et retourne la translation du
    % syst�me d'axe de l'hum�rus par rapport au thorax
    % Attention, cette fonction se terminer par un rmpath sur la librairie,
    % ce qui va peut-�tre demander de la r�ajouter par la suite

    % Ajouter le path dans lequel la librairie est
    [~, LibPath] = adresseDossierData('shoulder');
    LibPath = sprintf('%s%s%s/Model_%d/', LibPath, Sujets,lateralite, floor(modele));
    addpath(LibPath);

    
    % Pour chaque instant
    T = nan(3,size(Q,2));
    Q = Q.Q1;
    Q(isnan(Q)) = 0;
    for i = 1:size(Q,2)
        % R�cup�rer le GL
%         GL = GlobalLocalInterface(Q(:,i), 2);
%         GL = reshape(GL, [4,4,size(GL,2)/4]);
        GL = S2M_rbdl('globalJCS', model, Q(:,i));
        
        % Selon le mod�le, trouver la matrice de rototrans TH
        switch floor(modele)
            case 1
%                 GL_ref = GlobalLocalInterface([Q(1:12,i);zeros(16,1)], 2);
%                 GL_ref = reshape(GL_ref, [4,4,size(GL_ref,2)/4]);
                
                GL_ref = S2M_rbdl('globalJCS', model, [Q(1:12,i);zeros(16,1)]);
                Tho = GL(:,:,2);
                Hum = GL(:,:,5);
                Hum_ref = GL_ref(:,:,5);
            otherwise
                error('model %d is not implemented yet', floor(modele))
        end
        TH = Tho' * Hum;
        TH_ref = Tho' * Hum_ref;
        
        % Extraction des translations
        T(:,i) = TH(1:3,4) - TH_ref(1:3,4);
        
    end
    
    
    
    % Retirer les path
%     rmpath(LibPath)
%     S2M_rbdl('delete', model);
end