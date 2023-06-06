function [PCR,PCRData]=calculatePCR(T,Az,propNumber,thrust,pcrfile,months)
pcrdata=[];
Sum=0;
for j=1:months
    for i=1:8
        pcrdata(1,i)=(i-1)*45;
        k=i+2*(i-1);
        m=2+(j-1)*3;
        n=3+(j-1)*3;
        column = 2+(j-1);
        row = 3*(j);
        if thrust(2:T+Az+2*propNumber,k)==0
            pcrdata(m,i)=0;   %thrust allocation can not be done means zero
            pcrdata(n,i)=0;   % probability at that angle becomes zero
        elseif any(thrust(2:T+Az+2*propNumber,k))==1
            pcrdata(m,i)=1;   %thrust allocation done successfully
            pcrdata(n,i)=pcrfile(i,column);   %probability at that angle from docfile
        end
       
    end
     Sum = Sum + sum(pcrdata(row,:));
end
PCRData = pcrdata;
PCR = Sum/months
fid= fopen('PCR','w');
fprintf(fid,'%f',PCR);
fclose (fid);

end