function [] = MVVSyn( di_seq_path_sr, im_seq_path_sr, seq_start, seq_end, SR_f )
%XDIMENSYN Summary of this function goes here
%   Detailed explanation goes here
xpos_num = 5;       
zpos_num = 3;

di_5_path = '../Outputs/lovebird/Di5/';
di_t_5_path = '../Outputs/lovebird/Dit5/';
im_5_path = '../Outputs/lovebird/Im5/';

for i = seq_start:seq_end,
    
    di_r_name = sprintf('lovebird1_disparity_cam08_%04d_sr%dx.pgm',i,SR_f);
    di_r_name = strcat(di_seq_path_sr, di_r_name);
    
    di_m_name = sprintf('lovebird1_disparity_cam06_%04d_sr%dx.pgm',i,SR_f);
    di_m_name = strcat(di_seq_path_sr, di_m_name);
    
    di_l_name = sprintf('lovebird1_disparity_cam04_%04d_sr%dx.pgm',i,SR_f);
    di_l_name = strcat(di_seq_path_sr, di_l_name);
    
    im_r_name = sprintf('lovebird1_cam08_%04d_sr%dx.ppm',i,SR_f);
    im_r_name = strcat(im_seq_path_sr, im_r_name);
    
    im_m_name = sprintf('lovebird1_cam06_%04d_sr%dx.ppm',i,SR_f);
    im_m_name = strcat(im_seq_path_sr, im_m_name);
    
    im_l_name = sprintf('lovebird1_cam04_%04d_sr%dx.ppm',i,SR_f);
    im_l_name = strcat(im_seq_path_sr, im_l_name);
    
    di_r = double(imread(di_r_name));
    di_m = double(imread(di_m_name));
    di_l = double(imread(di_l_name));
    
    im_r = double(imread(im_r_name));
    im_m = double(imread(im_m_name));
    im_l = double(imread(im_l_name));        
    
    for zpos = 3:zpos_num,
        for xpos = 1:xpos_num,
            di_5_name = sprintf('Di_%05d_v%02d_z%02d.pgm',i,xpos,zpos);
            di_t_5_name = sprintf('Di_t_%05d_v%02d_z%02d.ppm',i,xpos,zpos);
            im_5_name = sprintf('Im_%05d_v%02d_z%02d.ppm',i,xpos,zpos);

            di_5_name = strcat(di_5_path, di_5_name);
            di_t_5_name = strcat(di_t_5_path, di_t_5_name);
            im_5_name = strcat(im_5_path, im_5_name);
                        
            [dX,dZ] = XZShiftCal(1, xpos, xpos_num, 1, zpos, zpos_num, di_l, di_r, SR_f);            
            [im_5_from_l, di_5_from_l, di_t_5_from_l] = ...
                DIBRxz( dX, dZ, im_l, di_l, SR_f);

            [dX,dZ] = XZShiftCal(3, xpos, xpos_num, 1, zpos, zpos_num, di_m, di_m, SR_f);            
            [im_5_from_m, di_5_from_m, di_t_5_from_m] = ...
                DIBRxz( dX, dZ, im_m, di_m, SR_f);   % to check                   
            
            [dX,dZ] = XZShiftCal(5, xpos, xpos_num, 1, zpos, zpos_num, di_l, di_r, SR_f);            
            [im_5_from_r, di_5_from_r, di_t_5_from_r] = ...
                DIBRxz( dX, dZ, im_r, di_r, SR_f);   % to check       

            [im_5, di_5, di_t_5] = mergeDIBR(im_5_from_l, di_5_from_l, di_t_5_from_l, ...
                                             im_5_from_m, di_5_from_m, di_t_5_from_m, ...
                                             im_5_from_r, di_5_from_r, di_t_5_from_r, ...
                                             1, 3, 5, xpos);

            [im_5,di_5,di_t_5 ] = Inpainting( im_5,di_5,di_t_5 );

            di_t_5_w = zeros(size(im_5));
            di_t_5_w(:,:,1) = mod(di_t_5, 256);
            di_t_5_w(:,:,2) = floor(di_t_5/256);
            
            imwrite(uint8(im_5), im_5_name);
            imwrite(uint8(di_5), di_5_name);
            imwrite(uint8(di_t_5_w), di_t_5_name);

        end
    end
end

end

