function [DataForceBrutOffset] = OffsetForce(DataForceBrut);

MoyMille(:,1:6)= mean(DataForceBrut(1:1000,1:6)); % Moyenne sur les 1000 premiers points
for i= 1:length(DataForceBrut)
DataForceBrutOffset(i,1:6)=DataForceBrut(i,1:6)-MoyMille(:,1:6);
end
end

