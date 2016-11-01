function GenerateOpenSimTrcFile(exportPath,trialname,confTrc,trcmat)
%% Ouverture
    fid   = fopen([exportPath trialname '.trc'],'w+');
%% Écriture des headers
    fprintf(fid,'%s\t',confTrc.header1{:});
    fprintf(fid,'\n');
    fprintf(fid,'%s\t',confTrc.header2{:});
    fprintf(fid,'\n');
    fprintf(fid,'%s\t',confTrc.header3{:});
    fprintf(fid,'\n');
    fprintf(fid,'%s\t',confTrc.header4{:});
    fprintf(fid,'\n');
    fprintf(fid,'%s\t',confTrc.header5{:});
    fprintf(fid,'\n');
%% Écriture des datas
    fprintf(fid, [repmat('%f\t', 1, size(trcmat, 2)) '\n'], trcmat');
%% Fermeture   
    fclose(fid);
end