function [ ] = plot_r( plotposs, numpoints )
%plot_r Plots the radius over time. Has a pause in it so need to enter when
%plot is at the right angle
% Date: 4/10/2018
% Author: Michelle Goodman


figure()
plot3(plotposs(1,1,1), plotposs(1,2,1), plotposs(1,3,1), 'kx')
grid on; hold on; 
a = 0:0.01:1;
b = sqrt(1-a.^2);
plot3(a, b, a*0, 'k:')
plot3(a, a*0, b, 'k:')
plot3(a*0, b, a, 'k:')
axis([0,1.5,0,1.5,0,1.5])
xlabel('x');   ylabel('y');   zlabel('z')
pause()
for jj = 1:numpoints
    title(num2str(jj))
    h = plot3(plotposs(:,1,jj), plotposs(:,2,jj), plotposs(:,3,jj), 'ro');
    pause(0.1)
    delete(h)
end

end

