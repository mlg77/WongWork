function [ dr ] = AoP( Poss, b, c, conds, tt , n)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

for ii = 1:size(Poss, 1)
    syms y(t)
    Dy = diff(y);
    ode = diff(y,t,2) + b(ii).*diff(y,t) + c(ii).*y == 0;
    y(t) = dsolve(ode,conds);
    a(ii,1) = double(y(tt));
    
    % r = R(t) + a(t) Y
    if Poss(ii, 1) == 0 && Poss(ii, 2) == 0
        thetheta = 0;
        thephi = 0;
    else
        thetheta = atan(Poss(ii, 2)/Poss(ii, 1));
        diagd = sqrt(Poss(ii, 1)^2+Poss(ii, 2)^2);
        thephi = pi/2 -  atan(Poss(ii, 3)/diagd);
    end
    
    %         Y = sin(tt(jj)*2*pi);
    Y = Ylm(n,n,thephi, thetheta);
    if imag(Y) ~= 0
        error('Imag Y')
    end
    dr(ii,1) = a(ii, 1) .* Y ; % *(tt(jj+1) - tt(jj))
    
end
end

