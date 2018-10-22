% This is a different look at the AoP equation
% Date:0/09/2018
% Author: Michelle Goodman

clear; clc; close all

%% Bubble Equation
% Parameters
myrho = 1000;
mysigma = 0.02;
mymu = 8.9e-4;

% time
tt = 0:1:40;

%% Radius
% Generate droplet r 
N = 5;     % Number of rows
radiuss = 1;      % radius
[ Pts, Poss, Connect, r ] = CreateSphere2( N, radiuss );
plotposs(:,:,1) = Poss;

dr = Poss(:,1)*359/360;
[ Poss_d ] = UpdatePoss( Poss, dr );
dr_old = dr*0;
myrho = Pts*myrho;

% Ode parameters
n = 4;
syms y(t)
Dy = diff(y);
cond1 = y(0) == 0.01; cond2 = Dy(0) == 0.01;
conds = [cond1 cond2];

numpoints =  length(tt)-1;
for jj = 1:numpoints
    % Update density
    [ myrho ] = step3( myrho, dr, tt(jj+1)-tt(jj), Connect );
    
    % Update/Find the radius and derivatives
    [ r, r_dot, r_dotdot, dr_old ] = find_rs( Poss, dr, dr_old );
    
    % The b and c components of the second order differential equation of AoP
    b = 3*r_dot./r + 2*(n-1)*(2*n+1)*mymu./(myrho.*r.^2);
    c = -(n+2)*r_dotdot./r - (n-1)*n*(n+2)*mysigma./(myrho./r.^3) - (n-1)*(n+2)*2*mymu*r_dot./(myrho.*r.^3);
    dr = [];
    % The AoP equation
    [ dr ] = AoP( Poss, b, c, conds, tt(jj+1) , n);
        
    [ Poss ] = UpdatePoss( Poss, dr );
    plotposs(:,:,jj) = Poss; % Save for plotting
    jj
end

cd('C:\Users\Michelle\Documents\GitHub\WongWork\6. Output')
save('data', 'plotposs')
cd('C:\Users\Michelle\Documents\GitHub\WongWork\3. Code')

return


cd('C:\Users\Michelle\Documents\GitHub\WongWork\6. Output')
load('data.mat')
plot_r( plotposs, numpoints )
cd('C:\Users\Michelle\Documents\GitHub\WongWork\3. Code')
