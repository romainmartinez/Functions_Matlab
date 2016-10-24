function [A,B,C] = ScapulaAngles(Q, model)
Q=Q.Q1;
n = size(Q,2);
A = nan(n,1);
B = A; C = A;

Q(isnan(Q))=0;
for i=1:n
	q = Q(:,i);
%	GL = GlobalLocalInterface(q,1);
	%modele 2: 1 pPelvis [1..4], 2 Pelvis [5..8], 3 pThorax [9..12], 4 Thorax [13..16], 5 pClavicule [17..20], 6 Clavicule [21..24]
	% 7 pScapula [25..28], 8 Scapula [29..32], 9 pArm [33..36], 10 Arm [37..40]
% 	R_Global2Thorax = GL(:,13:16);
% 	R_Global2Arm    = GL(:,37:40);
% 	R_Global2Arm    = GL(:,29:32);
% 	R_Thorax2Arm = R_Global2Thorax*invR(R_Global2Arm);
% 	GL = GlobalLocalInterface(q,2);
% 	GL = reshape(GL,[4,4,size(GL,2)/4]);
    GL = S2M_rbdl('globalJCS', model, q);
	R_Global2Thorax = GL(1:3,1:3,2);
	R_Global2Scap    = GL(1:3,1:3,4);
	R_Thorax2Scap = R_Global2Thorax'*R_Global2Scap;

	
	[a, b, c] = angleRotation(R_Thorax2Scap(1:3,1:3), 'zyx');
% 	[a, b, c] = angleRotation(R_Thorax2Arm(1:3,1:3), 'xyz');
	A(i)=a;
	B(i)=b;
	C(i)=c;
end

A = unwrap(A);
B = unwrap(B);
C = unwrap(C);

if nargout==1; A=[A B C]; end


