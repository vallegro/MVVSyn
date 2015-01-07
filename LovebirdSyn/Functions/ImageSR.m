function [] = ImageSR(di_seq_path, im_seq_path, di_seq_path_sr, im_seq_path_sr, seq_length, SR_f)


for i = 1:seq_length,
    for cam = 4:2:8,
        di_name = sprintf('lovebird1_depth_cam%02d_%04d.pgm',cam,i);
        di_name = strcat(di_seq_path, di_name);
      
        im_name = sprintf('lovebird1_cam%02d_%04d.ppm',cam,i);
        im_name = strcat(im_seq_path, im_name);

    
        di = double(imread(di_name));
        im = double(imread(im_name));
    
        di_sr = imresize(di, 2, 'nearest');
        im_sr = imresize(im, 2);
    
        di_sr_name = sprintf('lovebird1_disparity_cam%02d_%04d_sr%dx.pgm',cam,i,SR_f);
        di_sr_name = strcat(di_seq_path_sr, di_sr_name);

    
        im_sr_name = sprintf('lovebird1_cam%02d_%04d_sr%dx.ppm',cam,i,SR_f);
        im_sr_name = strcat(im_seq_path_sr, im_sr_name);

        imwrite(uint8(di_sr(97:1536,129:2048)),di_sr_name);
        imwrite(uint8(im_sr(97:1536,129:2048,1:3)),im_sr_name);
        
    end
end

end