function [ im_vir, di_vir, di_vir_t ] = DiDownSample( im_vir_sr, di_vir_sr, di_vir_t_sr, SR_f )
%DIDOWNSAMPLE Summary of this function goes here
%   Detailed explanation goes here
    c =3;
    seq_size = size(di_vir_sr)/SR_f;
    im_vir = zeros([seq_size c]);
    di_vir = zeros(seq_size);
    di_vir_t = zeros(seq_size);
    
    for i = 1:seq_size(1),
        for j = 1:seq_size(2),
            block_di_vir_sr = di_vir_sr( (i-1)*SR_f+1:i*SR_f, (j-1)*SR_f+1:j*SR_f); 
            block_di_vir_t_sr = di_vir_t_sr( (i-1)*SR_f+1:i*SR_f, (j-1)*SR_f+1:j*SR_f);
            block_im_vir_sr = im_vir_sr( (i-1)*SR_f+1:i*SR_f, (j-1)*SR_f+1:j*SR_f, 1:c);
            
            fore_pixel_ind = find(block_di_vir_sr == max(max(block_di_vir_sr)));
                        
            di_vir(i,j) = block_di_vir_sr(fore_pixel_ind(1));
            di_vir_t(i,j) = block_di_vir_t_sr(fore_pixel_ind(1));
            
            for i_c = 1:c
                block_im_vir_sr_c(1:SR_f, 1:SR_f) = block_im_vir_sr(:,: , i_c);
                fore_block_im_vir_sr_c = block_im_vir_sr_c(fore_pixel_ind);
                im_vir(i,j,i_c) = mean(fore_block_im_vir_sr_c);
            
            end
            
        end       
    end
    

end

