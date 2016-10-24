
% output : relative phase between two signals (e.g. joint angles)
% input  : - time (s) (column vector)
%          - signal 1 (column vector)
%          - signal 2 (column vector)
%          - angleUnit (optional, 1=degree, 2=radian), degree by default


function[relativePhase]=fct_relativePhase(time,alpha1,alpha2,angleUnit)

%% select angle unity
if nargin == 3
  angleUnit = 1;

elseif nargin<3 ||  nargin>4
    
    display('bad number of arguments for relativePhase function')
    
end


%% calculate velocity
V(:,1)=diff(alpha1)./diff(time);
V(:,2)=diff(alpha2)./diff(time);

%% adjust matrix length
pos=[alpha1(1:end-1,:),alpha2(1:end-1,:)];

%% normalize data
posNorm=pos./repmat(max(abs(pos)),length(pos),1);
VNorm=V./repmat(max(abs(V)),length(V),1);

%% calculate phases
phase=atan2(VNorm,posNorm);

if angleUnit==2
relativePhase=phase(:,2)-phase(:,1);

elseif angleUnit==1
  relativePhase=(phase(:,2)-phase(:,1))*180/pi;
 
else
     display('unit angle must 1 (degree) or 2 (radian)')
  
end



