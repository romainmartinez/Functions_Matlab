function [MM] = OrgData_c3d(FileName, nameTags)

    c = btkReadAcquisition(FileName);
    M = btkGetMarkers(c);
    MarkName2 = fieldnames(M);
    
    % Trouver le prefixe sur les noms de marqueurs s'il y en a un
    metadata = btkGetMetaData(c);
    try
        prefixes = metadata.children.SUBJECTS.children.NAMES.info.values;
    catch
        prefixes = {};
    end
    
    MM = zeros(btkGetLastFrame(c)-btkGetFirstFrame(c)+1,length(nameTags)*3);
    for i = 1:length(MarkName2)
        name = char(MarkName2(i)); % Faire un nom � la fois
        for j=1:length(prefixes)
            if length(name)>length(prefixes{j}) && strcmp(name(1:length(prefixes{j})+1), [prefixes{j} '_'])
                name = name(length(prefixes{j})+2:end);
                break;
            end
        end
        
        mm = find(strcmp(nameTags, name)); % Comparer le nom avec celui o� il devrait �tre plac� et trouver o� il se trouve
                
        for j = 1:length(mm)
            MM(:,mm(j)*3-2:mm(j)*3) = M.(MarkName2{i});  % Mettre le marqueur au bon endroit 
%             if verbose
%                 fprintf(     '%s...ok;', name);
%             end
        end

    end
    btkCloseAcquisition(c);
 end
