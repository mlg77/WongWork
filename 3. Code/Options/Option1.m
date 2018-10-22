clear; clc; close all

% Parameters
myrho = 1000;
mysigma = 0.02;
mymu = 8.9e-4; 

% Vectors of changing stuff
v = 3;% 0.8:0.05:1.2;
r_avg = 800*10^-6;
v_r = r_avg*v;
v_r_dot = [0, r_avg/3, r_avg/3, r_avg/2];
v_r_dotdot = [0, r_avg/3, r_avg/2, r_avg/2];

% Ode parameters
n = 4;
syms y(t)
Dy = diff(y);
cond1 = y(0) == 0.01; cond2 = Dy(0) == 0.01;
conds = [cond1 cond2];

tt = 0:1*10^-2:4;
for ii = 1:length(v_r_dot)
    r_dot = v_r_dot(ii);
    r_dotdot = v_r_dotdot(ii);
    a = [];
    count = 0;
    for jj = 1:length(v_r)
        r = v_r(jj);
                
        b = 3*r_dot./r + 2*(n-1)*(2*n+1)*mymu./(myrho.*r.^2);
        c = -(n+2)*r_dotdot./r - (n-1)*n*(n+2)*mysigma./(myrho./r.^3) - (n-1)*(n+2)*2*mymu*r_dot./(myrho.*r.^3);
        
        if b^2-4*c > 0
            % real
            display('Real, Overdamped')
        else
            display('Imag, Underdamped')
        end
        
        syms y(t)
        Dy = diff(y);
        ode = diff(y,t,2) + b.*diff(y,t) + c.*y == 0;
        y(t) = dsolve(ode,conds);
        count = count + 1;
        a(:,count) = double(y(tt));
    end

%     surf(v_r, tt, a)
    plot(tt,a); hold on
    ylabel('a')
    xlabel('Time')
    title([', R_{dot} = ' num2str(r_dot) ', R_{dotdot} = ' num2str(r_dotdot) ])
%     pause()
end
title('R with different change')
legend('R = 0\mu m, Rdd = 0\mu m','R = 0.26\mu m, Rdd = 0.26\mu m','R = 0.26\mu m, Rdd = 0.4\mu m', 'R = 0.4\mu m, Rdd = 0.4\mu m')