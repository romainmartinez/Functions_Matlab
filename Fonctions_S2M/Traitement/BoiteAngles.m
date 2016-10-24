function [A,B,C,D,E,F,G,H,J,Ob] = BoiteAngles(Q, model,DataViconFilt)
% Cette fonction permet de calculer les orientations de la boite dans le repere du Thorax
Q=Q.Q1;
n = size(Q,2);
A = nan(n,1);
B = A; C = A; D = A; E = A; F = A;G = A; H = A; J = A;
Q(isnan(Q))=0;
% Creer le repere boite
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
        Yb = ((AvG(i,:)+AvD(i,:))/2) - Ob(i,:);
        Xbtmp = ((AvD(i,:)+ArrD(i,:))/2) - Ob(i,:);
        Zb = cross(Xbtmp,Yb);
        Xb = cross(Yb,Zb);

        Xb= Xb/norm(Xb);
        Zb= Zb/norm(Zb);
        Yb= Yb/norm(Yb);    

        Rb = [Xb', Yb', Zb', Ob(i,:)'; 0 0 0 1];% boite exprimé dans 0      
        R_Global2Boite = Rb;
		
		GL = S2M_rbdl('globalJCS', model, Q(:,i));
		R_Global2Thorax = GL(:,:,2);
		R_Global2Pelvis = GL(:,:,1);
		R_Thorax2Boite = invR(R_Global2Thorax)*R_Global2Boite;
		R_Pelvis2Boite = invR(R_Global2Pelvis)*R_Global2Boite;	
		
		%% Extraction des orientations (en radian) de la boite par rapport au Thorax
		[A(i), B(i), C(i)] = angleRotation(R_Thorax2Boite(1:3,1:3), 'xyz');
		%% Extraction des orientations (tjrs en radian) de la boite par rapport au Global
		[D(i), E(i), F(i)] = angleRotation(R_Global2Boite(1:3,1:3), 'xyz');
		%% Extraction des orientations (tjrs en radian) de la boite par rapport au Pelvis
		[G(i), H(i), J(i)] = angleRotation(R_Pelvis2Boite(1:3,1:3), 'xyz');

	end

A = unwrap(A);
B = unwrap(B);
C = unwrap(C);

D = unwrap(D);
E = unwrap(E);
F = unwrap(F);

G = unwrap(G);
H = unwrap(H);
J = unwrap(J);

if nargout==1; A=[A B C]; end
if nargout==1; D=[D E F]; end
if nargout==1; G=[G H J]; end


