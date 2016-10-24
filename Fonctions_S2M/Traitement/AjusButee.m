function [DataButee] = AjusButee(D,seq,REF,X)
% D=D/180*pi;
%X=linspace(1:length(D))/lenght(D)*100
% %%% Create limits on GH or TH
% for i=1:length(D);
%     for lim = 1:3	
%     while D(i,lim)> pi;  D(i,lim)=D(i,lim)-2*pi; end
%     while D(i,lim)<-pi;  D(i,lim)=D(i,lim)+2*pi; end
%     end
% end
%     plot(D*180/pi,'--');

    %%% Correct if elev goes wrong way
        for i=1:length(D); 
            if D(i,1)>=0; sign1=-pi; else sign1=pi; end
            if D(i,3)>=0; sign3=-pi; else sign3=pi; end
            
            if      strcmp(seq,'zyzz')  && D(i,2)> 0;
                    D(i,1:3) = [D(i,1)+sign1 -D(i,2) D(i,3)];
            elseif  strcmp(seq,'zyz')   && D(i,2)> 0; 
                    D(i,1:3) = [D(i,1)+sign1 -D(i,2) D(i,3)+sign3];
            elseif (strcmp(seq,'xyz')|| strcmp(seq,'yxz')) && D(i,2)<= -pi/2 
                    D(i,1:3) = [D(i,1)+sign1 pi+D(i,2) D(i,3)+sign3];
            elseif (strcmp(seq,'xyz')|| strcmp(seq,'yxz')) && D(i,2)> pi/2
                    D(i,1:3) = [D(i,1)+sign1 -pi+D(i,2) D(i,3)+sign3];
            end
        end
      %plot(X,D(:,1)*180/pi,'.',X,D(:,2)*180/pi,'.',X,D(:,3)*180/pi,'.');
        
    %%% Adjust limits
	M=2*pi; m=-2*pi;
    for lim=1:3
        for i = 1:length(D); 
            if REF==1 && lim==1      %GH PoE
               if     strcmp(seq,'zyzz') || strcmp(seq,'zyz');  m=-13*pi/9;  M=5*pi/9; 
               end
           elseif REF==1 && lim==3 %GH Rot
               if     strcmp(seq,'zyzz'); 				         m=-5*pi/6;  M=5*pi/6;
               elseif strcmp(seq,'xyz')  || strcmp(seq,'yxz');  m=-pi;      M=pi;
               else                                             m=-pi;      M=pi; %zyz
               end     
            elseif REF==2 && lim==3  %TH Rot
                if     strcmp(seq,'zyzz'); 				         m=-7*pi/6;  M=5*pi/6;
                elseif strcmp(seq,'xyz')  || strcmp(seq,'yxz');  m=D(i,1)-pi;M=m+2*pi;
               else                                             m=-8*pi/9;  M=10*pi/9; %zyz
                end
            end
        while D(i,lim)> M;  D(i,lim)=D(i,lim)-2*pi; end
        while D(i,lim)< m;  D(i,lim)=D(i,lim)+2*pi; end
        end
	end
    
% 	 %%% Avoid gimbal lock 
% 	 if REF == 1
% 	 d2r=pi/180;
%         if     strcmp(seq,'zyz')|| strcmp(seq,'zyzz'); % Euler ZYZ or ZYZZ (YXY ISB 2005, with or without correction)
%                wh  = (D(:,2)>= -170*d2r & D(:,2)<=-10*d2r);
%         elseif strcmp(seq,'xyz')||strcmp(seq,'yxz');   % Cardan XYZ or YXZ (ZXY or XZY Senk 2006)-->20�???!!!
%                wh  = D(:,2)>= 100*d2r | (D(:,2)<=80*d2r & D(:,2)>=-80*d2r) | D(:,2)<=-100*d2r;
% 		end
%         
%         for i=1:length(D)
% 			if wh(i)==0; D(i,:)=nan(1,3);end
% 		end
% 	 end			
        
%     plot(X,D(:,1)*180/pi,'o',X,D(:,2)*180/pi,'o',X,D(:,3)*180/pi,'o');
%     legend('PEL','EL','ROT')
    
DataButee=unwrap(D,pi/2)*180/pi;
DataButee=unwrap(DataButee,pi/2);
end

