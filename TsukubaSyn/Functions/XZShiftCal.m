function  [dX,dZ] = XZShiftCal(ref_xpos, vir_xpos, xpos_num, ... 
                               ref_zpos, vir_zpos, zpos_num, ...
                               dZ_max, SR_f)
%XZSHIFTCAL Summary of this function goes here
%   Detailed explanation goes here
x_shift = vir_xpos - ref_xpos;
dX = 1/(xpos_num-1)*x_shift*SR_f;

z_shift = vir_zpos - ref_zpos;
dZ = 1/(zpos_num-1)*z_shift*dZ_max;

end

