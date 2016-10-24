function [DataForceBrutOffset] = OffsetForce(DataForceBrut);

MoyMille(:,1:6)= mean(DataForceBrut(1:250,:)); % Moyenne sur les 250 premiers points
for i= 1:length(DataForceBrut)
DataForceBrutOffset(i,:)=DataForceBrut(i,:)-MoyMille(:,:);
end
end

