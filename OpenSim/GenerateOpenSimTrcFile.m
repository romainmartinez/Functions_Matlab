function GenerateOpenSimTrcFile(FileMot,confTrc,markers)

    fid   = fopen([FileMot '.trc'],'w+');


for i = 1:length(confTrc.header1)
    fprintf(fid,'%s\t',confTrc.header1{i});
end

fprintf(fid,'\n');

for i = 1:length(confTrc.header2)
    fprintf(fid,'%s\t',confTrc.header2{i});
end

fprintf(fid,'\n');

for i = 1:length(confTrc.header3)
    fprintf(fid,'%s\t',confTrc.header3{i});
end

fprintf(fid,'\n');

for i = 1:length(confTrc.header4)
    fprintf(fid,'%s\t',confTrc.header4{i});
end

fprintf(fid,'\n');

for i = 1:length(confTrc.header5)
    fprintf(fid,'%s\t',confTrc.header5{i});
end

fprintf(fid,'\n');


    
%     for i =1:size(markers,2) %nb instants
%         for j = 1:size(markers,1) %nb markers
%             fprintf(fid,'%1.10f',markers(j,i));
%             fprintf(fid,'\t','');
%         end
%         fprintf(fid,'\n');
%     end
    
end