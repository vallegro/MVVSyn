function [ im_vir, di_vir, di_vir_t ] = DIBRx( ref_xpos, vir_xpos, xpos_num, im_ref_sr, di_ref_sr, SR_f )
%DIBRX Summary of this function goes here
%   Detailed explanation goes here
    c = 3;
    v_shift = vir_xpos - ref_xpos;
    seq_size_sr = size(di_ref_sr);    

    im_vir_sr = zeros([seq_size_sr c]);
    di_vir_sr = zeros(seq_size_sr);
    di_vir_t_sr = zeros(seq_size_sr);    
    
    di_x = 1/(xpos_num-1)*v_shift;
    for i = 1 : seq_size_sr(1),
        for j = 1 : seq_size_sr(2),
            v_j = round (j - di_ref_sr(i,j)*di_x);
            if v_j>0 &&v_j<= seq_size_sr(2)
                if di_ref_sr(i, j) > di_vir_sr(i, v_j),
                    di_vir_sr(i, v_j) = di_ref_sr(i, j);
                    di_vir_t_sr(i, v_j) = di_ref_sr(i, j);
                    im_vir_sr(i, v_j, 1:c) = im_ref_sr(i, j, 1:c);
                end
            end
        end
    end
    
    [im_vir , di_vir, di_vir_t] = DiDownSample(im_vir_sr, di_vir_sr, di_vir_t_sr, SR_f);
    
    

end

