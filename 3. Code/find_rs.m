function [ r, r_dot, r_dotdot, dr_old ] = find_rs( Poss, dr, dr_old )
%Update the radius given the old and new
% Poss      :   New Position
% dr        :   New dr 
% dr_old    :   New dr 

r = sqrt(Poss(:,1).^2 + Poss(:,2).^2 + Poss(:,3).^2);
r_dot = dr; 
r_dotdot = dr_old - dr;

dr_old = dr;


end

