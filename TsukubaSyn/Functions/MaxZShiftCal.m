function [ dZ ] = MaxZShiftCal(  di1, di2 )
%ZSHIFTCAL Summary of this function goes here
%   Detailed explanation goes here

di = [di1,di2];
min_z = 1/max(max(di));
dZ = min_z * (0.5 - 1); % 0 is the farest and 2 is the nearest
 
end

