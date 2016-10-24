function [SV, SF, SR, Sfig, SA, SCond,STH,SST,SSimple,SSEveAccMax] = creerMatriceSujet(Sujets, sexe, Essais, Mvts, ConditionPoids, ext,Genre,modele)


    SV = cell(length(Essais), length(Mvts), length(ConditionPoids), length(Sujets));
	SSimple= cell(length(Essais), length(Mvts), length(ConditionPoids), length(Sujets));
	SSEveAccMax= cell(length(Essais), length(Mvts), length(ConditionPoids), length(Sujets));
    SF = cell(length(Essais), length(Mvts), length(ConditionPoids), length(Sujets));
    SR = cell(length(Essais), length(Mvts), length(ConditionPoids), length(Sujets));
    SA = cell(length(Essais), length(Mvts), length(ConditionPoids), length(Sujets));
    Sfig = cell(length(Essais), length(Mvts), length(ConditionPoids), length(Sujets));
    STH = cell(length(Essais), length(Mvts), length(ConditionPoids), length(Sujets));
    for iSujet=1:length(Sujets)
        Sujet = Sujets{iSujet};
		for iEssai= 1:length(Essais)
      Essai = Essais{iEssai};
        for iCond = 1:length(ConditionPoids)
            Condition = ConditionPoids{iCond};
            for iMvt=1:length(Mvts)
                Mvt = Mvts{iMvt};

					Varmodele=num2str(str2num(modele{iSujet}));
                    % Matrice de nom d'essais VICON    
                    SV{iEssai,iMvt,iCond,iSujet}= [Sujet sexe{iSujet} Condition 'H' Mvt '_' Essai ext];
					SSimple{iEssai,iMvt,iCond,iSujet}= [Sujet sexe{iSujet} Condition 'H' Mvt '_' Essai '_EvenementForce'];
					SSEveAccMax{iEssai,iMvt,iCond,iSujet}= [Sujet sexe{iSujet} Condition 'H' Mvt '_' Essai '_EvenementAccMax'];
                    % Matrice de nom d'essais de Force
                    SF{iEssai,iMvt,iCond,iSujet}= [Sujet sexe{iSujet} Condition 'H' Mvt '_' Essai 'f' ext];

                    SR{iEssai,iMvt,iCond,iSujet}= [Sujet sexe{iSujet} Condition 'H' Mvt '_' Essai 'Resultat'];

                    Sfig{iEssai,iMvt,iCond,iSujet}= [Sujet sexe{iSujet} Condition 'H' Mvt '_' Essai 'Figure'];
                    
                    SA{iEssai,iMvt,iCond,iSujet}= [Sujet sexe{iSujet} Condition 'H' Mvt '_' Essai '_MOD' Varmodele '_rightHanded_Gender' Genre{iSujet} '_' Sujet 'd_.Q1'];
                    STH{iEssai,iMvt,iCond,iSujet}= [Sujet sexe{iSujet} Condition 'H' Mvt '_' Essai '_MOD' Varmodele '_rightHanded_Gender' Genre{iSujet} '_' Sujet 'd_.TH1'];
% 					SMSKActivation{iMvt,iCond,iSujet}= [Sujet sexe Condition 'H' Mvt '_'  '_MOD2_rightHanded_Gender' sexe '_' Sujet 'd_activation.sto'];
%                                            % AntCH6H1_1_MOD2_rightHanded_GenderM_AntCd_activation.sto
%                     SMSKForce{iMvt,iCond,iSujet}= [Sujet sexe Condition 'H' Mvt '_'  '_MOD2_rightHanded_Gender' sexe '_' Sujet 'd_force.sto'];
					SST{iEssai,iMvt,iCond,iSujet}= [Sujet sexe{iSujet} Condition 'H' Mvt '_' Essai '_MOD' Varmodele '_rightHanded_Gender' Genre{iSujet} '_' Sujet 'd_.ST1'];
				end                
           SCond{iMvt,iCond}=[Condition 'H' Mvt];
           end
        end
    end

end