function out = transposeMrot(M)
    R = M(1:3,1:3);
    T = M(1:3,4);
    out = [R', -R'*T; 0 0 0 1]; % 0 vers la boite   
end