% This is the main run file to run the wong work 
% Date: 17th Sept 2018
% Author: Michelle Goodman

clear; clc; close all

% Step 1 create vector of points and matrix of conectivity
N = 20;     % Number of rows
r = 1;      % radius
[ Pts, Poss, Connect ] = CreateSphere2( N, r );

% do one update of radius position




% Example change
dr = Pts*0.05;

% update a position given a change in r (ie. dr/dt)
[ Poss ] = UpdatePoss( Poss, dr );

figure(1)
plot3(Poss(1,1), Poss(1,2), Poss(1,3), 'kx')
grid on; hold on; 
xlabel('x');   ylabel('y');   zlabel('z')
plot3(Poss(:,1), Poss(:,2), Poss(:,3), 'ro')
