% Computes the minimum distance between two line segments. Code
% is adapted for Matlab from Dan Sunday's Geometry Algorithms originally
% written in C++
% http://softsurfer.com/Archive/algorithm_0106/algorithm_0106.htm#dist3D_Segment_to_Segment

% Usage: Input the start and end x,y,z coordinates for two line segments. 
% p1, p2 are [x,y,z] coordinates of first line segment and p3,p4 are for
% second line segment. 

% Output: scalar minimum distance between the two segments.

%  Example:
%	P1 = [0 0 0];     P2 = [1 0 0];
%   P3 = [0 1 0];     P4 = [1 1 0];
%	dist = DistBetween2Segment(P1, P2, P3, P4)
%   dist =
%
%    1
% 

function distance = DistBetween2Segment(p1, p2, p3, p4)
    u = p1 - p2;
    v = p3 - p4;
    w = p2 - p4;
    
    a = dot(u,u,2);
    b = dot(u,v,2);
    c = dot(v,v,2);
    d = dot(u,w,2);
    e = dot(v,w,2);
    D = a.*c - b.*b;
    sD = D;
    tD = D;
    
    SMALL_NUM = 0.00000001;
    
    sN = nan(size(D));
    tN = nan(size(D));
    
    % compute the line parameters of the two closest points
    idx = D<SMALL_NUM;
        sN(idx) = 0.0;
        sD(idx) = 1.0;
        tN(idx) = e(idx);
        tD(idx) = c(idx);
    
    idx = ~idx;
        sN(idx) = b(idx).*e(idx) - c(idx).*d(idx);
        tN(idx) = a(idx).*e(idx) - b(idx).*d(idx);
        
        idx2 = sN <0.0 & idx;
            sN(idx2) = 0.0;
            tN(idx2) = e(idx2);
            tD(idx2) = c(idx2);
        idx2 = sN > sD & idx;
            sN(idx2) = sD(idx2);
            tN(idx2) = e(idx2) + b(idx2);
            tD(idx2) = c(idx2);
            
    idx = tN < 0.0;
        tN(idx) = 0.0;
        idx2 = -d<0.0 & idx;
            sN(idx2) = 0.0;
        idx3 = -d>a & idx;
            sN(idx3)   = sD(idx3);
        idx4 = -d>=0.0 & -d<=a & idx;
            sN(idx4) = -d(idx4);
            sD(idx4) = a(idx4);
    idx = tN > tD;
        tN(idx) = tD(idx);
        idx2 = (-d+b)< 0.0 & idx;
            sN(idx2) = 0;
        idx2 = (-d+b) > a & idx;
            sN(idx2) = sD(idx2);
        idx2 = (-d+b)>=0.0 & (-d+b)<=a & idx;
            sN(idx2) = -d(idx2) + b(idx2);
            sD(idx2) = a(idx2);
    
    
    % finally do the division to get sc and tc
    sc = nan(size(sN));
    tc = nan(size(tN));
    idx = abs(sN) < SMALL_NUM;
        sc(idx) = 0.0;
    idx = ~idx;
        sc(idx) = sN(idx) ./ sD(idx);
     
    idx = abs(tN) < SMALL_NUM;
        tc(idx) = 0.0;
    idx = ~idx;
        tc(idx) = tN(idx) ./ tD(idx);  
            
    % get the difference of the two closest points
    dP = w + (repmat(sc, [1 3]) .* u) - (repmat(tc,[1 3]) .* v);  % = S1(sc) - S2(tc)

    distance = sqrt(sum(dP.^2,2));
end