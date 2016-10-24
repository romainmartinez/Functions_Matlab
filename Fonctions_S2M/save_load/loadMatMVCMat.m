function [MatMVCMat]= loadMatMVCMat(Sujet) %#ok<STOUT>
    %load
    load(['./Resultats/' Sujet '/MaxMVC' Sujet '.mat']);
end