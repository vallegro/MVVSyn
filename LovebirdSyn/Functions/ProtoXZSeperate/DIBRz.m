function [im_vir, di_vir, di_vir_t] = DIBRz(ref_zpos, vir_zpos, zpos_num, im_ref_sr, di_ref_sr, SR_f )
    c = 3;
    z_shift = (vir_zpos - ref_zpos)/(zpos_num - 1);
    seq_size_sr = size(di_ref_sr);

    im_vir_sr = zeros([seq_size_sr c]);
    di_vir_sr = zeros(seq_size_sr);
    di_vir_t_sr = zeros(seq_size_sr);    
        
    min_z = 1/max(max(di_ref_sr));  
    dZ = min_z * (2^(-z_shift) - 1); % 0 is the farest and 2 is the nearest 
    
    for i = 1 : seq_size_sr(1),
        for j =1 : seq_size_sr(2),
            Z_r = 1/di_ref_sr(i, j);
            Z_v = Z_r +dZ;
            coor_v = round(([i j]-seq_size_sr/2)*(Z_r/Z_v) + seq_size_sr/2);
            if coor_v(1) > 0 && coor_v(1) <= seq_size_sr(1) && ... 
               coor_v(2) > 0 && coor_v(2) <= seq_size_sr(2),                
                if di_ref_sr(i, j) > di_vir_sr(coor_v(1),coor_v(2)),
                    
                    di_vir_sr(coor_v(1),coor_v(2)) = di_ref_sr(i, j);
                    di_vir_t_sr(coor_v(1),coor_v(2)) = di_ref_sr(i, j);
                    im_vir_sr(coor_v(1),coor_v(2), 1:c) = im_ref_sr(i, j, 1:c);
                end
            
            end
        end
    end
    
    [im_vir , di_vir, di_vir_t] = DiDownSample(im_vir_sr, di_vir_sr, di_vir_t_sr, SR_f);
    
end