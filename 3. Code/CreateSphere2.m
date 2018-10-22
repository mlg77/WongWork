function [ Pts, Poss, Connect, r ] = CreateSphere2( N, r )
%CreateSphere Creates an array of points based upon dimensions and an
%connectivity matrix as to what connects to what
% 
% Author: Michelle Goodman 
% Date 17 Sept 2018
% N = 4;
% r = 1; 

Pts = ones(N*(N+1)/2,1);


Connect = diag(Pts*0 -6);
idx = 0:N;
Seq = idx.*(idx+1)./2;

for jj = 1:length(Pts)
    if jj == 1 % Top corner
        Connect(jj,jj) = -2; Connect(jj,jj+1) = 1; Connect(jj,jj+2) = 1;
    elseif jj == (N-1)*(N)/2 +1 %left corner
        Connect(jj,jj) = -4; 
        idxseq = find(jj == Seq+1);
        Connect(jj,Seq(idxseq) - Seq(idxseq-1) ) = 1; % up
        Connect(jj,Seq(idxseq) +2 ) = 1; % right
        Connect(jj,Seq(idxseq) ) = 1; % other side up
        Connect(jj,Seq(idxseq+1) ) = 1; % other side left
    elseif  jj == N*(N+1)/2 %right corner
        Connect(jj,jj) = -4; 
        idxseq = find(jj == Seq);
        Connect(jj,Seq(idxseq-1) ) = 1; % up
        Connect(jj,Seq(idxseq) -1 ) = 1; % left
        Connect(jj,Seq(idxseq-1)+1) = 1; % other side right
        Connect(jj,Seq(idxseq-2)+1) = 1; % otherside up
     elseif ismember(jj, Seq+1) % Left side
        Connect(jj,jj) = -6; 
        idxseq = find(jj == Seq+1);
        Connect(jj,Seq(idxseq) - Seq(idxseq-1) ) = 1; % up
        Connect(jj,Seq(idxseq) +2 ) = 1; % right
        Connect(jj,Seq(idxseq+1)+1) = 1; % down 
        Connect(jj,Seq(idxseq+1)+2) = 1; % down2 
        Connect(jj,Seq(idxseq) ) = 1; % other side up
        Connect(jj,Seq(idxseq+1) ) = 1; % other side left
        
    elseif ismember(jj, Seq) % Right side
        Connect(jj,jj) = -6; 
        idxseq = find(jj == Seq);
        Connect(jj,Seq(idxseq-1) ) = 1; % up
        Connect(jj,Seq(idxseq) -1 ) = 1; % left
        Connect(jj,Seq(idxseq+1)-1) = 1; % down 
        Connect(jj,Seq(idxseq+1)) = 1; % down2 
        Connect(jj,Seq(idxseq-1)+1) = 1; % other side right
        Connect(jj,Seq(idxseq-2)+1) = 1; % otherside up
       
    elseif jj >= (N-1)*(N)/2 +1 % Bottom row
        Connect(jj,jj) = -4; 
        idxseq = find(Seq >= jj);
        rewstidx = (N-1)*(N)/2 +1;
        Connect(jj,jj-1 ) = 1; % left
        Connect(jj,jj +1 ) = 1; % right
        Connect(jj,Seq(idxseq-2)+ jj - Seq(idxseq-1)-1) = 1; % up left
        Connect(jj,Seq(idxseq-2)+ jj - Seq(idxseq-1)) = 1; % up right 
    else % Center points
        Connect(jj,jj) = -6; 
        idxseq = find(Seq >= jj,1);
        Connect(jj,jj - 1 ) = 1; % left
        Connect(jj,jj + 1 ) = 1; % right
        Connect(jj,Seq(idxseq-2)+ Seq(idxseq)-jj) = 1; % up left
        Connect(jj,Seq(idxseq-2)+ Seq(idxseq)-jj +1) = 1; % up right 
        Connect(jj,2*Seq(idxseq)-jj +1) = 1; % down left 
        Connect(jj,2*Seq(idxseq)-jj +2) = 1; % down right
    end



end

% Length of all points must be 1
% distance between all points must be equal
% bottom line is circle with r= 1
% Left is left wall circle
% right is right wall circle
mytheta = pi/2/(N-1);
for jj = 1:length(Pts)
    if jj == 1 % Top corner
        Poss(jj,1:3) = [0,0,r];
    elseif jj == (N-1)*(N)/2 +1 %left corner
        Poss(jj,1:3) = [r,0,0];
    elseif  jj == N*(N+1)/2 %right corner
        Poss(jj,1:3) = [0,r,0];
    elseif ismember(jj, Seq+1) % Left side
        idxseq = find(jj == Seq+1);
        theangle = mytheta*(idxseq-1);
        Poss(jj,1:3) = [r*sin(theangle),0,r*cos(theangle)];
    elseif ismember(jj, Seq) % Right side
        idxseq = find(jj == Seq)-2;
        theangle = mytheta*idxseq;
        Poss(jj,1:3) = [0, r*sin(theangle),r*cos(theangle)];
    elseif jj >= (N-1)*(N)/2 +1 % Bottom row
        idxseq = jj-(Seq(end-1)+1);
        theangle = mytheta*idxseq;
        Poss(jj,1:3) = [r*cos(theangle) ,r*sin(theangle),0];
    else % Center points
        idxseq = find(Seq >= jj,1); % end of row
        theangledown = mytheta*(idxseq-2);
        ptsinrow = Seq(idxseq) - Seq(idxseq-1);
        theangleacc = (pi/2)/(ptsinrow-1)* (jj-Seq(idxseq-1)-1);
        Poss(jj,1:3) = [r*sin(theangledown)*cos(theangleacc), r*cos(theangledown),r*sin(theangledown)*sin(theangleacc)];
    end


end

r = sqrt(Poss(:,1).^2 + Poss(:,2).^2 + Poss(:,3).^2);