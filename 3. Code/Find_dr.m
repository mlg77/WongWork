function [ dr ] = Find_dr( Poss , r, r_dot, r_dotdot, IC_a, dt, t)
%Find_dr Function that finds the change in radius give the current position
%of each point
%   Poss = [M, 3]
%   myrho = [1,2]
%   mymu = [1,2]
%   a, da, da2, dt are all scalars

%   dr = [M, 1]

n = 16;
dr = zeros(size(Poss,1),1);
R = sqrt(Poss(:,1).^2 + Poss(:,1).^2 + Poss(:,1).^2);


% Parameters
myrho = 1000;
mysigma = 0.02;
mymu = 8.9e-4;

syms y(t)
Dy = diff(y);

cond1 = y(0) == IC_a(1);
cond2 = Dy(0) == IC_a(2);
conds = [cond1 cond2];

    
% loop untill steady state 
for ii = 1:100
    % solve for a each round
    b = 3*r_dot./r + 2*(n-1)*(2*n+1)*mymu./(myrho*r.^2);
    c = -(n+2)*r_dotdot./r - (n-1)*n*(n+2)*mysigma./(myrho./r.^3) - (n-1)*(n+2)*2mymu*r_dot./(myrho*r.^3);
    
    

    ode = diff(y,t,2) + b.*diff(y,t) + c.*y == 0;
    ySol(t) = dsolve(ode,conds);

    a = ySol(t);
    
    % Find dr
    Y = Ylm(0,0,pi/4,pi/4);
    
    
    if abs(dr-newdr) <= 0.01*R
        dr = newdr;
        break
    elseif ii == 100
        error('too long')
    end
    
    dr = newdr;    
end
    





end

