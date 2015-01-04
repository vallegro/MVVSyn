function [] = XDimenSyn( di_seq_path, im_seq_path, seq_length )
%XDIMENSYN Summary of this function goes here
%   Detailed explanation goes here
SR_f = 1;
xpos_num = 7;       

di_7_path = '../Outputs/NTSD/Di7/';
di_t_7_path = '../Outputs/NTSD/Dit7/';
im_7_path = '../Outputs/NTSD/Im7/';

for i = 1:seq_length,
    
    di_r_name = sprintf('right/tsukuba_disparity_R_%05d.png',i);
    di_r_name = strcat(di_seq_path, di_r_name);
    di_l_name = sprintf('left/tsukuba_disparity_L_%05d.png',i);
    di_l_name = strcat(di_seq_path, di_l_name);
    
    im_r_name = sprintf('right/tsukuba_daylight_R_%05d.png',i);
    im_r_name = strcat(im_seq_path, im_r_name);
    im_l_name = sprintf('left/tsukuba_daylight_L_%05d.png',i);
    im_l_name = strcat(im_seq_path, im_l_name);
    
    di_r = double(imread(di_r_name));
    di_l = double(imread(di_l_name));
    im_r = double(imread(im_r_name));
    im_l = double(imread(im_l_name));        
    
    
    for xpos = 1:7,
        di_7_name = sprintf('Di_%05d_v%02d.pgm',i,xpos);
        di_t_7_name = sprintf('Di_t_%05d_v%02d.pgm',i,xpos);
        im_7_name = sprintf('Im_%05d_v%02d.ppm',i,xpos);

        di_7_name = strcat(di_7_path, di_7_name);
        di_t_7_name = strcat(di_t_7_path, di_t_7_name);
        im_7_name = strcat(im_7_path, im_7_name);

        [im_7_from_l, di_7_from_l, di_t_7_from_l] = ...
            DIBRx( 1, xpos, xpos_num, im_l, di_l, SR_f);
        [im_7_from_l, di_7_from_l, di_t_7_from_l] = ...
            ErodeX( im_7_from_l, di_7_from_l, di_t_7_from_l);
        
        [im_7_from_r, di_7_from_r, di_t_7_from_r] = ...
            DIBRx( 7, xpos, xpos_num, im_r, di_r, SR_f); 
        [im_7_from_r, di_7_from_r, di_t_7_from_r] = ...
            ErodeX( im_7_from_r, di_7_from_r, di_t_7_from_r);        
        
        
        [im_7, di_7, di_t_7] = mergeDIBR(im_7_from_l, di_7_from_l, di_t_7_from_l, ...
                                         im_7_from_r, di_7_from_r, di_t_7_from_r, xpos, xpos_num);
                                     
        [im_7,di_7,di_t_7 ] = InpaintingX( im_7,di_7,di_t_7 );
        
        imwrite(uint8(im_7), im_7_name);
        imwrite(uint8(di_7), di_7_name);
        imwrite(uint8(di_t_7), di_t_7_name);
        
    end    
end

end

