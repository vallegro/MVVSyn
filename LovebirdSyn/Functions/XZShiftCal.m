function [ dX, dZ ] = XZShiftCal( ref_xpos, vir_xpos, xpos_num, ...
                                  ref_zpos, vir_zpos, zpos_num, ...
                                  di1, di2, SR_f)
%XZSHIFTCAL Summary of this function goes here
%   Detailed explanation goes here
x_shift = vir_xpos - ref_xpos;
dX = 1/(xpos_num-1)*x_shift*SR_f/3;

z_shift = (vir_zpos - ref_zpos)/(zpos_num - 1);
di = [di1,di2];
min_z = 1/max(max(di));
dZ = min_z * (2^(-z_shift) - 1); % 0 is the farest and 2 is the nearest

end

