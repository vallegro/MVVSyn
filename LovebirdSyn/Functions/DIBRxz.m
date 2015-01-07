function [ im_vir, di_vir, di_vir_t ] = DIBRxz(dX, dZ, im_ref_sr, di_ref_sr, SR_f)
%DIBRXZ Summary of this function goes here
%   Detailed explanation goes here

    c = 3;
    seq_size_sr = size(di_ref_sr);    

    im_vir_sr = zeros([seq_size_sr c]);
    di_vir_sr = zeros(seq_size_sr);
    di_vir_t_sr = zeros(seq_size_sr);    
    
    
    for i = 1 : seq_size_sr(1),
        for j = 1 : seq_size_sr(2),
            v_j = round (j - di_ref_sr(i,j)*dX);
            
            Z_r = 1/di_ref_sr(i, j);
            Z_v = Z_r +dZ;
            coor_v = round(([i v_j]-seq_size_sr/2)*(Z_r/Z_v) + seq_size_sr/2);

            if coor_v(1) > 0 && coor_v(1) <= seq_size_sr(1) && ... 
               coor_v(2) > 0 && coor_v(2) <= seq_size_sr(2),                
                if di_ref_sr(i, j) > di_vir_sr(coor_v(1),coor_v(2)),
                    
                    di_vir_sr(coor_v(1),coor_v(2)) = di_ref_sr(i, j);
                    di_vir_t_sr(coor_v(1),coor_v(2)) = 1/Z_v;                    
                    im_vir_sr(coor_v(1),coor_v(2), 1:c) = im_ref_sr(i, j, 1:c);
                end
            
            end
        end  
    end
    
    if dZ==0,
        [im_vir_sr, di_vir_sr, di_vir_t_sr] = Erode( im_vir_sr, di_vir_sr, di_vir_t_sr ,2);
        [im_vir , di_vir, di_vir_t] = DiDownSample(im_vir_sr, di_vir_sr, di_vir_t_sr, SR_f);
    else
        [im_vir , di_vir, di_vir_t] = DiDownSample(im_vir_sr, di_vir_sr, di_vir_t_sr, SR_f);
        [im_vir, di_vir, di_vir_t] = Erode( im_vir, di_vir, di_vir_t ,1);
    end
    
    [im_vir, di_vir, di_vir_t] = CrackPainting(im_vir, di_vir, di_vir_t);

    
end

