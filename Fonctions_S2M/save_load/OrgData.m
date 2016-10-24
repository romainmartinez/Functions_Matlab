function MM = OrgData(MarkName, FileName)


%% read in conf
delimit = ',';
Ro = 5;
Co = 2;
header = 3;


% keyboard
fid = fopen(FileName);
if fid==-1; 
                   fprintf(     '!!!!!!! Le fichier %s n''existe pas !!!!!!\n',FileName); 
end

for i=1:header, 
    Head = fgetl(fid);  
%     disp(Head)
end


MarkName2 = {};
H = length(Head);
h=1;

while h<H
% Sortir les noms des marqueurs de l'entete de la matrice sans le nom du
% sujet (Mettre dans MarkName2)
    i=h; while Head(i)==',', if i==H; break; end; i=i+1; end
    j=i; while Head(j)~=',', if j==H; break; end; j=j+1; end
%     MarkName2 = strvcat(MarkName2, Head(i:j-1));
    w = strfind(Head(i:j),':');
    if ~isempty(w), i=i+w; end
    if j==H && ~strcmp(Head(i:j), ','), MarkName2 = [MarkName2, Head(i:j)]; %#ok<AGROW>
    else     MarkName2 = [MarkName2, Head(i:j-1)];  %#ok<AGROW>
    end
    
    h=j;
end


fclose(fid);


M = dlmread(FileName,delimit,Ro,Co);
n = size(M,1);

MM = zeros(n,  length(MarkName)*3);

for i=1:size(MarkName2,2)
    m  = M(:,i*3-2:i*3);
    name = char(MarkName2(1,i)); % Faire un nom à la fois
    
    mm = find(strcmp(MarkName, name)); % Comparer le nom avec celui où il devrait être placé et trouver où il se trouve
    if isempty(mm), % Si le nom n'existe pas, il y a probablement une erreur dans le labelling
        
    else 
%         keyboard
		wh = m(:,1)~=0; 
        for j = 1:length(mm)
    		MM(wh,mm(j)*3-2:mm(j)*3) = m(wh,:);  % Mettre le marqueur au bon endroit 
        end
	
	
    end
end

    
    
    
    
