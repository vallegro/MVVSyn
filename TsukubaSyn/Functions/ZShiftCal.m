function [ dZ ] = ZShiftCal( ref_zpos, vir_zpos, zpos_num, z_max )
%ZSHIFTCAL Summary of this function goes here
%   Detailed explanation goes here
    z_shift = (vir_zpos -ref_zpos)/(zpos_num - 1);
    dZ = z_max * z_shift;

end

