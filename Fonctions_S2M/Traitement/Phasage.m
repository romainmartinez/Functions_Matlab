function [P1, P2, P3, P4]=Phasage(DebutForce,FinForce,maxtab,IndPhase)

    % Phase 1: Arrachage
P1= maxtab(1,1)-DebutForce;


    % Phase 2: Transfert 
P2= maxtab(2,1)-maxtab(1,1);


    % Phase 3: Depot
P3= FinForce-maxtab(2,1);

%Phase finale
P4=FinForce-IndPhase;