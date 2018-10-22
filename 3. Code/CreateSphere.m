function [ Pts, Connect ] = CreateSphere( input_args )
%CreateSphere Creates an array of points based upon dimensions and an
%connectivity matrix as to what connects to what
% 
% Author Michelle Goodman 
% Date 17 Sept 2018
ii = 4;
mytheta = 0:(pi/2)/ii:pi/2; % horo 
myphi =  0:(pi/2)/ii:pi/2; % vert up
myr = 1;

M = length(mytheta);
N =  length(myphi);

points = ones(M, N);
Pts = points(:);

Connect = diag(Pts*0 -4);
for jj = 1:length(Pts)
    if % jj is less than M
        
    elseif %% jj is greater than (M*(N-1))
        
    end
    
    if % jj is a multiple of M
        
    elseif % jj is a multiple of M+1
        



end

