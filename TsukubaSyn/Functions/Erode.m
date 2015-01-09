function  [ im,di,di_t ] = Erode( im,di,di_t,num )
%INPAINTINGX Summary of this function goes here
%   Detailed explanation goes here

seq_size=size(di);
num = num-1;

for y=1:seq_size(1);
    status=1;
    x=1;
    while x<=seq_size(2);
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
            
            if ending==seq_size(2)+1,
                ending=seq_size(2);
            end
            
            ending=ending:min(ending+1,seq_size(2));
            di(y,ending) = 0;
            di_t(y,ending) = 0;
            im(y,ending,1:3) = 0;
            
            beginning=max(1,beginning-num):beginning;
            di(y,beginning) = 0;
            di_t(y,beginning) = 0;
            im(y,beginning,1:3) = 0;
            
            x = max(ending);
            
            status=1;
        end
        x=x+1;
    end
end

for x=1:seq_size(2);
    status=1;
    y=1;
    while y<=seq_size(1);
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
            if ending==seq_size(1)+1,
                ending=seq_size(1);
            end           
            
            ending=ending:min(ending+1,seq_size(1));
            di(ending,x) = 0;
            di_t(ending,x) = 0;
            im(ending,x,1:3) = 0;
            
            beginning=max(1,beginning-num):beginning;
            di(beginning,x) = 0;
            di_t(beginning,x) = 0;
            im(beginning,x,1:3) = 0;
            
            y = max(ending);            
            
            status=1;
        end
        y=y+1;
    end
end

end
