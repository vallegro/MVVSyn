function [] = ImageSR(di_seq_path, im_seq_path, di_seq_path_sr, im_seq_path_sr, seq_length, SR_f)


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
    
    di_r_sr = imresize(di_r, 3, 'nearest');
    di_l_sr = imresize(di_l, 3, 'nearest');
    im_r_sr = imresize(im_r, 3);
    im_l_sr = imresize(im_l, 3);
    
    di_r_sr_name = sprintf('right/tsukuba_disparity_R_%05d_sr%dx.pgm',i,SR_f);
    di_r_sr_name = strcat(di_seq_path_sr, di_r_sr_name);
    di_l_sr_name = sprintf('left/tsukuba_disparity_L_%05d_sr%dx.pgm',i,SR_f);
    di_l_sr_name = strcat(di_seq_path_sr, di_l_sr_name);
    
    im_r_sr_name = sprintf('right/tsukuba_daylight_R_%05d_sr%dx.ppm',i,SR_f);
    im_r_sr_name = strcat(im_seq_path_sr, im_r_sr_name);
    im_l_sr_name = sprintf('left/tsukuba_daylight_L_%05d_sr%dx.ppm',i,SR_f);
    im_l_sr_name = strcat(im_seq_path_sr, im_l_sr_name);
    
    imwrite(uint8(di_r_sr),di_r_sr_name);
    imwrite(uint8(di_l_sr),di_l_sr_name);
    imwrite(uint8(im_r_sr),im_r_sr_name);
    imwrite(uint8(im_l_sr),im_l_sr_name);

end

end