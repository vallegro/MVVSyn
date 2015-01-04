function [ im,di,di_t ] = CrackPainting( im,di,di_t )
%CRACKPAINT Summary of this function goes here
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
                back=ending;
            else
                back=beginning;
            end
            
            if(ending - beginning)<=5,          
                inx=beginning+1:ending-1;
                di(y,inx)=di(y,back);
                di_t(y,inx) = di_t(y,back);
                im(y,inx,1:3)=repmat(im(y,back,1:3),1,length(inx));
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
                back=ending;
            else
                back=beginning;
            end
            
            if(ending - beginning)<=5,          
                iny=beginning+1:ending-1;
                di(iny,x)=di(back,x);
                di_t(iny,x) = di_t(back,x);
                im(iny,x,1:3)=repmat(im(back,x,1:3),1,length(iny));
            end
            
            status=1;
        end
    end    
end

end

