function [ im, di, di_t ] = mergeDIBR( im_from_l, di_from_l, di_t_from_l, ...
                                       im_from_m, di_from_m, di_t_from_m, ...
                                       im_from_r, di_from_r, di_t_from_r, ...
                                       xpos_l, xpos_m, xpos_r, xpos_v)
%MERGEDIBR Summary of this function goes here
%   Detailed explanation goes here
    if xpos_v>=xpos_l && xpos_v<=xpos_m,
        mid_pos = (xpos_l + xpos_m)/2;
        if xpos_v< mid_pos,
            main = 1;
        else
            main = 2;
        end
        [im, di, di_t] = merge(im_from_l, di_from_l, di_t_from_l, ...
                               im_from_m, di_from_m, di_t_from_m, main);
        [im, di, di_t] = merge(im, di, di_t, ...
                               im_from_r, di_from_r, di_t_from_r, 1);                   
            
    elseif xpos_v>xpos_m && xpos_v<=xpos_r,
        mid_pos = (xpos_m + xpos_r)/2;        
        if xpos_v<= mid_pos,
            main = 1;
        else
            main = 2;
        end
        [im, di, di_t] = merge(im_from_m, di_from_m, di_t_from_m, ...
                               im_from_r, di_from_r, di_t_from_r, main);
        [im, di, di_t] = merge(im, di, di_t, ...
                               im_from_l, di_from_l, di_t_from_l, 1); 
    end
    
end

