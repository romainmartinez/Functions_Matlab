function[FT,Ob,FTNorm]=ForceenRc(DataViconFilt,MM,FTA)
% Variable sortie : 
% FT : Matrice Nx1 qui est ...
    FTA = [FTA; ones(1, size(FTA,2))];
    MMt = transposeMrot(MM);          
    
    
    AvG= DataViconFilt(:,148:150);
    AvD= DataViconFilt(:,151:153);
    ArrG= DataViconFilt(:,157:159);
    ArrD= DataViconFilt(:,154:156);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%  Création du repere boite (Rb) %%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    q=size(ArrD);
    FT = nan(q(1),4);
    
    Ob = nan(size(DataViconFilt,1),3);
    for i= 1:q(1)

        Ob(i,:) = (AvG(i,:)+ArrD(i,:))/2;
        Zb = ((ArrG(i,:)+ArrD(i,:))/2) - Ob(i,:);
        Xbtmp = ((AvD(i,:)+ArrD(i,:))/2) - Ob(i,:);
        Yb = cross(Zb,Xbtmp);
        Xb = cross(Yb,Zb);

        Xb= Xb/norm(Xb);
        Yb= Yb/norm(Yb);
        Zb= Zb/norm(Zb);    


        Rb = [Xb', Yb', Zb', Ob(i,:)'; 0 0 0 1];% boite vers 0
        R0b = transposeMrot(Rb);

        FT(i,:)=R0b*MMt*FTA(:,i);

    end
    FTNorm= sqrt(sum(FT(:,1:3).^2,2));
end

function out = transposeMrot(M)
    R = M(1:3,1:3);
    T = M(1:3,4);
    out = [R', -R'*T; 0 0 0 1]; % 0 vers la boite   
end
