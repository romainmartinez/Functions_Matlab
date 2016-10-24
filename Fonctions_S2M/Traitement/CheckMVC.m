function CheckMVC(DataPath)
    % Loader la matrice de max
        load(DataPath);
    % Faire ce que tu as besoin de faire 
        disp('Fait le check Michel, puis taper return pour sauvegarder ou CTRL+C pour annuler')
        keyboard

    % Recalculer le max
        MatMVCMat = max(MaxDESessai);

    % Enregistrer
        save(DataPath, 'MatMVCMat', 'MaxDESessai', 'NomsEssais');
end