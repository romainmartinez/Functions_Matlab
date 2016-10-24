function [maxindex,maxvalue,minindex,minvalue] = maxmin2plot(DataF)

%fonction de filtrage et identification des max et mins 
%locales dans un signal oscillant
%     orderbut = 2;
%     freqcut = 1;
%     freqech = 500;
%     [b, a] = butter(orderbut, freqcut/(freqech*0.5));
%     DataF = filtfilt(b,a,Data);

%calcul d'une derivee approchee
    Y=diff(DataF);
    
%recuperation du signe de la derivee
%dans Y2 une valeur +1 correspond a une pente croissante
%						  -1 correspond a une pente decroissante
    Y2=sign(Y);
    
%recuperation des indices des minima
%un minimum est caracterise par une pente de signe -1 avant puis +1 apres
%si on fait la difference du vecteur de signe Y2, un minimum est 
%donc caracterise par +2
    minindex=find(diff(Y2)==2)+1;
    
%recuperation des indices des minima
%un minimum est caracterise par une pente de signe +1 avant puis -1 apres
%si on fait la difference du vecteur de signe Y2, un minimum est 
%donc caracterise par -2
    maxindex=find(diff(Y2)==-2)+1;
    
%recupeartion des valeurs associees aux indices
    maxvalue=DataF(maxindex);
    minvalue=DataF(minindex);
% %affichage
%     figure
%     plot (DataF,'-');
%     hold on;
%     plot (maxindex,maxvalue,'ro',minindex,minvalue,'g*');





