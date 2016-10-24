function [TpsTotal,Phase1,Phase3,Phase2]=CalculPhase(DebutForce,FinForce,ValPhase13);

% Calcul de 20% du temps totale de l'analyse pour connaitre le nombre de points en phase 1 et phase 3
TpsTot=FinForce-DebutForce;
Phase1_3_tmp=TpsTot*ValPhase13;
Phase1_3= round(Phase1_3_tmp);

% Determine l'indice dans l'essai de la fin de la phase 1 et debut de la phase 3
Phase1= DebutForce+Phase1_3;
Phase3=FinForce-Phase1_3;

Phase2=Phase3-Phase1;
TpsTotal=FinForce-DebutForce;
end