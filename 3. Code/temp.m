% temp

N = 4;

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
        rewstidx = (N-1)*(N)/2 +1;
        Connect(jj,Seq(idxseq) - Seq(idxseq-1) ) = 1; % left
        Connect(jj,Seq(idxseq) +2 ) = 1; % right
        Connect(jj,Seq(idxseq+1)+1) = 1; % down % ----will fail for last row
        Connect(jj,Seq(idxseq+1)+2) = 1; % down2 % ----will fail for last row
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
Connect
