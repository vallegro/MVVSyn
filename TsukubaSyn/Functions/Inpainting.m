function [ im,di,di_t ] = Inpainting( im,di,di_t )
%INPAINTINGX Summary of this function goes here
%   Detailed explanation goes here

seq_size=size(di);

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
                begindi=Inf;
            else
                begindi=di(y,beginning);
            end
            
            if ending==seq_size(2)+1,
                endingdi=Inf;
                ending=seq_size(2);
            else
                endingdi=di(y,ending);
            end
            
            if endingdi<=begindi,
                back=ending;
            else
                back=beginning;
            end
            
            inx=beginning+1:ending-1;
            di(y,inx)=di(y,back);
            di_t(y,inx) = di(y,back);
            im(y,inx,1:3)=repmat(im(y,back,1:3),1,length(inx));
            status=1;
        end
    end    
end



for y=1:seq_size(1),
    beginning=2;
    for x=2:seq_size(2),
        if abs(double(di(y,x))-double(di(y,x-1)))>10,
            endding=x;
            if endding-beginning<4 && abs(double(di(y,endding))-double(di(y,beginning-1)))<10,
                di(y,beginning:endding-1)=uint8((double(di(y,endding))+double(di(y,beginning-1)))/2);
                di_t(y,beginning:endding-1)=uint8((double(di_t(y,endding))+double(di_t(y,beginning-1)))/2);
                im(y,beginning:endding-1,1)=uint8((double(im(y,endding,1))+double(im(y,beginning-1,1)))/2);
                im(y,beginning:endding-1,2)=uint8((double(im(y,endding,2))+double(im(y,beginning-1,2)))/2);
                im(y,beginning:endding-1,3)=uint8((double(im(y,endding,3))+double(im(y,beginning-1,3)))/2);
            end
            beginning=x;
        end         
    end
end

for x=1:seq_size(2),
    beginning=2;
    for y=2:seq_size(1),
        if abs(double(di(y,x))-double(di(y-1,x)))>10,
            endding=y;
            if endding-beginning<4 && abs(double(di(endding,x))-double(di(beginning-1,x)))<10,
                di(beginning:endding-1,x)=uint8((double(di(endding,x))+double(di(beginning-1,x)))/2);
                di_t(beginning:endding-1,x)=uint8((double(di_t(endding,x))+double(di_t(beginning-1,x)))/2);
                im(beginning:endding-1,x,1)=uint8((double(im(endding,x,1))+double(im(beginning-1,x,1)))/2);
                im(beginning:endding-1,x,2)=uint8((double(im(endding,x,2))+double(im(beginning-1,x,2)))/2);
                im(beginning:endding-1,x,3)=uint8((double(im(endding,x,3))+double(im(beginning-1,x,3)))/2);
            end
            beginning=y;
        end         
    end
end

for y=1:seq_size(1),
    beginning=2;
    for x=2:seq_size(2),
        if abs(double(di(y,x))-double(di(y,x-1)))>10,
            endding=x;
            if endding-beginning<4 && abs(double(di(y,endding))-double(di(y,beginning-1)))<10,
                di(y,beginning:endding-1)=uint8((double(di(y,endding))+double(di(y,beginning-1)))/2);
                di_t(y,beginning:endding-1)=uint8((double(di_t(y,endding))+double(di_t(y,beginning-1)))/2);
                im(y,beginning:endding-1,1)=uint8((double(im(y,endding,1))+double(im(y,beginning-1,1)))/2);
                im(y,beginning:endding-1,2)=uint8((double(im(y,endding,2))+double(im(y,beginning-1,2)))/2);
                im(y,beginning:endding-1,3)=uint8((double(im(y,endding,3))+double(im(y,beginning-1,3)))/2);
            end
            beginning=x;
        end         
    end
end

for x=1:seq_size(2),
    beginning=2;
    for y=2:seq_size(1),
        if abs(double(di(y,x))-double(di(y-1,x)))>10,
            endding=y;
            if endding-beginning<4 && abs(double(di(endding,x))-double(di(beginning-1,x)))<10,
                di(beginning:endding-1,x)=uint8((double(di(endding,x))+double(di(beginning-1,x)))/2);
                di_t(beginning:endding-1,x)=uint8((double(di_t(endding,x))+double(di_t(beginning-1,x)))/2);
                im(beginning:endding-1,x,1)=uint8((double(im(endding,x,1))+double(im(beginning-1,x,1)))/2);
                im(beginning:endding-1,x,2)=uint8((double(im(endding,x,2))+double(im(beginning-1,x,2)))/2);
                im(beginning:endding-1,x,3)=uint8((double(im(endding,x,3))+double(im(beginning-1,x,3)))/2);
            end
            beginning=y;
        end         
    end
end




end

