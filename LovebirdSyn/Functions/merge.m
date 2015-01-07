function [im, di, di_t] = merge(im_from_l, di_from_l, di_t_from_l, ...
                                im_from_r, di_from_r, di_t_from_r, main)
%MERGEDIBR Summary of this function goes here
%   Detailed explanation goes here
    im_size = size(im_from_l);
    im = zeros(im_size);

    di_size = size(di_from_l);
    di = zeros(di_size);
    di_t = zeros(di_size);
    
    if main == 1,
        l_ne = di_from_l>=di_from_r;  %pixel generated from left view is closer(or equal)
        l_f = di_from_l < di_from_r;   %pixel generated from right view is closer
        
        di(l_ne) = di_from_l(l_ne);
        di(l_f) = di_from_r(l_f);
        
        di_t(l_ne) = di_t_from_l(l_ne);
        di_t(l_f) = di_t_from_r(l_f);
        
        l_ne_c = [l_ne,l_ne,l_ne];
        l_f_c = [l_f,l_f,l_f];
        
        im(l_ne_c) = im_from_l(l_ne_c);
        im(l_f_c) = im_from_r(l_f_c);
    else
        r_ne = di_from_r>=di_from_l;
        r_f = di_from_r < di_from_l;
        
        di(r_ne) = di_from_r(r_ne);
        di(r_f) = di_from_l(r_f);
       
        di_t(r_ne) = di_t_from_r(r_ne);
        di_t(r_f) = di_t_from_l(r_f);

        r_ne_c = [r_ne,r_ne,r_ne];
        r_f_c = [r_f,r_f,r_f];
        
        im(r_ne_c) = im_from_r(r_ne_c);
        im(r_f_c) = im_from_l(r_f_c);        
    end
end

