function [] = MVVSyn( di_seq_path, im_seq_path, seq_start, seq_end, SR_f )
%XDIMENSYN Summary of this function goes here
%   Detailed explanation goes here
xpos_num = 7;       
zpos_num = 3;

di_7_path = '../Outputs/NTSD/Di7/';
di_t_7_path = '../Outputs/NTSD/Dit7/';
im_7_path = '../Outputs/NTSD/Im7/';

for i = seq_start:seq_end,
    
    di_r_name = sprintf('right/tsukuba_disparity_R_%05d_sr%dx.pgm',i,SR_f);
    di_r_name = strcat(di_seq_path, di_r_name);
    di_l_name = sprintf('left/tsukuba_disparity_L_%05d_sr%dx.pgm',i,SR_f);
    di_l_name = strcat(di_seq_path, di_l_name);
    
    im_r_name = sprintf('right/tsukuba_daylight_R_%05d_sr%dx.ppm',i,SR_f);
    im_r_name = strcat(im_seq_path, im_r_name);
    im_l_name = sprintf('left/tsukuba_daylight_L_%05d_sr%dx.ppm',i,SR_f);
    im_l_name = strcat(im_seq_path, im_l_name);
    
    di_r = double(imread(di_r_name));
    di_l = double(imread(di_l_name));
    im_r = double(imread(im_r_name));
    im_l = double(imread(im_l_name));        
    
    for zpos = 3:zpos_num,
        for xpos = 3:xpos_num,
            di_7_name = sprintf('Di_%05d_v%02d_z%02d.pgm',i,xpos,zpos);
            di_t_7_name = sprintf('Di_t_%05d_v%02d_z%02d.ppm',i,xpos,zpos);
            im_7_name = sprintf('Im_%05d_v%02d_z%02d.ppm',i,xpos,zpos);

            di_7_name = strcat(di_7_path, di_7_name);
            di_t_7_name = strcat(di_t_7_path, di_t_7_name);
            im_7_name = strcat(im_7_path, im_7_name);
                        
            [dX,dZ] = XZShiftCal(1, xpos, xpos_num, 1, zpos, zpos_num, di_l, di_r, SR_f);
            
            [im_7_from_l, di_7_from_l, di_t_7_from_l] = ...
                DIBRxz( dX, dZ, im_l, di_l, SR_f);

            [dX,dZ] = XZShiftCal(7, xpos, xpos_num, 1, zpos, zpos_num, di_l, di_r, SR_f);
            
            [im_7_from_r, di_7_from_r, di_t_7_from_r] = ...
                DIBRxz( dX, dZ, im_r, di_r, SR_f);   % to check       

            [im_7, di_7, di_t_7] = mergeDIBR(im_7_from_l, di_7_from_l, di_t_7_from_l, ...
                                             im_7_from_r, di_7_from_r, di_t_7_from_r);

            [im_7,di_7,di_t_7 ] = Inpainting( im_7,di_7,di_t_7 );

            di_t_7_w = zeros(size(im_7));
            di_t_7_w(:,:,1) = mod(di_t_7, 256);
            di_t_7_w(:,:,2) = floor(di_t_7/256);
            
            imwrite(uint8(im_7), im_7_name);
            imwrite(uint8(di_7), di_7_name);
            imwrite(uint8(di_t_7_w), di_t_7_name);

        end
    end
end

end

