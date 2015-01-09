function [dz_rec] = DzRec( di_seq_path, seq_start, seq_end, SR_f )
%XDIMENSYN Summary of this function goes here
%   Detailed explanation goes here
xpos_num = 7;       
zpos_num = 3;

dz_rec = zeros(seq_end-seq_start+1,1);
for i = seq_start:seq_end,
    
    di_r_name = sprintf('right/tsukuba_disparity_R_%05d_sr%dx.pgm',i,SR_f);
    di_r_name = strcat(di_seq_path, di_r_name);
    di_l_name = sprintf('left/tsukuba_disparity_L_%05d_sr%dx.pgm',i,SR_f);
    di_l_name = strcat(di_seq_path, di_l_name);
    
    
    di_r = double(imread(di_r_name));
    di_l = double(imread(di_l_name));
    
    
    zpos = 2;
    xpos = 1;
    [~,dZ] = XZShiftCal(7, xpos, xpos_num, 1, zpos, zpos_num, di_l, di_r, SR_f);    
    dz_rec(i) = dZ;
    
end

end

