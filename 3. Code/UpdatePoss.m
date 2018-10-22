function [ newposs ] = UpdatePoss( oldposs, dr )
%updateposs updates the position matrix according to the dr given
%   oldposs = [m,3]
%   dr = [m,1]
%   newposs = [m,3]
% Author Michelle Goodman
% Date 18 Sept 2018
newposs = zeros(size(oldposs));
for jj = 1:length(dr)
    lengthPt = sqrt(sum(oldposs(jj, :).^2));
    r = lengthPt+dr(jj);
    if oldposs(jj, 1) == 0 && oldposs(jj, 2) == 0
        newposs(jj,1) = 0;
        newposs(jj,2) = 0;
        newposs(jj,3) = r;
    
    else
        angleacc = atan(oldposs(jj, 2)/oldposs(jj, 1));
        diagd = sqrt(oldposs(jj, 1)^2+oldposs(jj, 2)^2);
        angledown = pi/2 -  atan(oldposs(jj, 3)/diagd);
        
        newposs(jj,1) = r*sin(angledown)*cos(angleacc);
        newposs(jj,2) = r*sin(angledown)*sin(angleacc);
        newposs(jj,3) = r*cos(angledown);
    end
    
    
end

