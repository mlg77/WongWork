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
tt = 0:0.01:10;

% Radius
N = 10;     % Number of rows
radiuss = 1;      % radius
[ Pts, Poss, Connect ] = CreateSphere2( N, radiuss );
r = sqrt(Poss(:,1).^2 + Poss(:,2).^2 + Poss(:,3).^2);
r_dot = r*0; 
r_dotdot = r*0; 

figure(1)
plot3(Poss(:,1), Poss(:,2), Poss(:,3), 'ro')
grid on;
xlabel('x');   ylabel('y');   zlabel('z')
drawnow

% Ode parameters
n = 1;
syms y(t)
Dy = diff(y);
cond1 = y(0) == 0.01;
cond2 = Dy(0) == 0.01;
conds = [cond1 cond2];


% The b and c components of the second order differential equation of AoP
b = 3*r_dot./r + 2*(n-1)*(2*n+1)*mymu./(myrho*r.^2);
c = -(n+2)*r_dotdot./r - (n-1)*n*(n+2)*mysigma./(myrho./r.^3) - (n-1)*(n+2)*2*mymu*r_dot./(myrho*r.^3);
    
% The AoP equation
for ii = 1:length(Pts)
    syms y(t)
    Dy = diff(y);
    ode = diff(y,t,2) + b(ii).*diff(y,t) + c(ii).*y == 0;
    y(t) = dsolve(ode,conds);
    a(ii,1) = double(y(tt(1)));
    
    % r = R(t) + a(t) Y
    thetheta = atan(Poss(ii, 2)/Poss(ii, 1));
    diagd = sqrt(Poss(ii, 1)^2+Poss(ii, 2)^2);
    thephi = pi/2 -  atan(Poss(ii, 3)/diagd);

    Y = Ylm(0,0,thetheta,thephi);
    dr(ii) = a(ii, 1) .* Y;
    
end
[ Poss ] = UpdatePoss( Poss, dr );

plot3(Poss(:,1), Poss(:,2), Poss(:,3), 'ro')
drawnow




