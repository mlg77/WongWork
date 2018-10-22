function [ mdensity ] = step3( mdensity, dr, dt, connect )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

ddensity_dt = connect * (mdensity .* dr );
for ii = 1:10
    mdensity = mdensity + dt/10 * ddensity_dt;
end



end

