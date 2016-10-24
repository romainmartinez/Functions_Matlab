function [MM]=Repere(FichierBoite)



M12= dlmread(FichierBoite,',',5,2);
M12=M12/1000;

M12 = filtreDonneesBrutes(M12);

MExtH= M12(:,1:3)';
MIntH= M12(:,4:6)';
MExtB= M12(:,7:9)';
MIntB= M12(:,10:12)'; %#ok<NASGU>

AvG= M12(:,13:15)';
AvD= M12(:,16:18)';
ArrG= M12(:,19:21)';
ArrD= M12(:,22:24)';

q = size(M12,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%  Creation du repere capteur (Rc)  %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Rcb = nan(4, 4, q);

for i= 1:q
    
    Oc = (MIntH(:,i)+MExtB(:,i))/2; % Coordonnées de l'Origine du Repere Capteur
    Yc= ((MIntH(:,i)+MExtH(:,i))/2) - Oc; % Coordonnées du Vecteur Origine Oy
    Xctmp = ((MExtH(:,i)+MExtB(:,i))/2) - Oc; 
    Zc= cross(Xctmp,Yc);% Coordonnées du Vecteur Origine Oz
    Xc= cross(Yc,Zc); % Coordonnées du Vecteur Origine Ox

    Xc= Xc/norm(Xc);
    Yc= Yc/norm(Yc);
    Zc= Zc/norm(Zc);
    
    Rc = [Xc, Yc, Zc Oc; 0 0 0 1]; %matrice du capteur vers 0
    
    
    Ob = (AvG(:,i)+ArrD(:,i))/2;
    Zb = ((ArrG(:,i)+ArrD(:,i))/2) - Ob;
    Xbtmp = ((AvD(:,i)+ArrD(:,i))/2) - Ob;
    Yb = cross(Zb,Xbtmp);
    Xb = cross(Yb,Zb);

    Xb= Xb/norm(Xb);
    Yb= Yb/norm(Yb);
    Zb= Zb/norm(Zb);    
    
    Rb = [Xb, Yb, Zb Ob; 0 0 0 1];% boite vers 0
    
    R = Rb(1:3,1:3);
    T = Rb(1:3,4);
    R0b = [R', -R'*T; 0 0 0 1]; % 0 vers la boite

    
    Rcb(:,:,i) = R0b*Rc; %capteur vers 0 puis de 0 vers boite
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%  Création du repere boite (Rb) %%%%%%%%%%%%%%%%%%%%%%%%
Rcb_ = mean(Rcb,3);
diff = Rcb - repmat(Rcb_, [1,1,q]);
diff = squeeze(sum(sum(diff.^2,2)));
[~,w] = min(diff);

MM = Rcb(:,:,w);






