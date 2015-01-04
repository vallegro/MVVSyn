function  [ im,di,di_t ] = Erode( im,di,di_t,num )
%INPAINTINGX Summary of this function goes here
%   Detailed explanation goes here

seq_size=size(di);
num = num-1;

for y=1:seq_size(1);
    status=1;
    for x=1:seq_size(2);
        if di(y,x)==0&&status==1;
            status=0;
            beginning=x-1;
        end
        if di(y,x)~=0&&status==0
            status=2;
            ending=x;
        end
        if  x==seq_size(2)&&status==0;
            status=2;
            ending=x+1;
        end
        if status==2;
            if beginning==0,
                begindisp=Inf;
            else
                begindisp=di(y,beginning);
            end
            
            if ending==seq_size(2)+1,
                endingdisp=Inf;
                ending=seq_size(2);
            else
                endingdisp=di(y,ending);
            end
            
            if endingdisp<=begindisp,
                back=ending:min(ending+1,seq_size(2));
                di(y,back) = 0;
                di_t(y,back) = 0;
                im(y,back,1:3) = 0;
            else
                back=max(1,beginning-num):beginning;
                di(y,back) = 0;
                di_t(y,back) = 0;
                im(y,back,1:3) = 0;
            end
            status=1;
        end
    end
end

for x=1:seq_size(2);
    status=1;
    for y=1:seq_size(1);
        if di(y,x)==0&&status==1;
            status=0;
            beginning=y-1;
        end
        if di(y,x)~=0&&status==0
            status=2;
            ending=y;
        end
        if  y==seq_size(1)&&status==0;
            status=2;
            ending=y+1;
        end
        if status==2;
            if beginning==0,
                begindisp=Inf;
            else
                begindisp=di(beginning,x);
            end
            
            if ending==seq_size(1)+1,
                endingdisp=Inf;
                ending=seq_size(1);
            else
                endingdisp=di(ending,x);
            end
            
            if endingdisp<=begindisp,
                back=ending:min(ending+1,seq_size(1));
                di(back,x) = 0;
                di_t(back,x) = 0;
                im(back,x,1:3) = 0;
            else
                back=max(1,beginning-num):beginning;
                di(back,x) = 0;
                di_t(back,x) = 0;
                im(back,x,1:3) = 0;
            end
            status=1;
        end
    end
end

end
