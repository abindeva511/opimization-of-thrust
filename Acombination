
function [CAZ,CbAzimuth]=Acombination(sectors,s,AZ,bAzimuth);
n1=sectors+2;
no=s;
a=[];
for i=1:no
a(:,:,i)=[AZ(:,:,2*i-1),AZ(:,:,2*i)];
ab(:,:,i)=[bAzimuth(:,:,2*i-1),bAzimuth(:,:,2*i)];
end
d=[];
q=[];
b=zeros(2*n1,2,no);
for j=1:1:no

    b(1:2*n1,1:2,j)=reshape(a(:,:,j),2*n1,2);


end
d=b(:,:,1);
q=ab(:,:,1);

f=[];
for i=1:1:no-1%no of azimuthal thrusters -1
    d=combvec(d,b(:,:,i+1));
    q=combvec(q,ab(:,:,i+1));
end
h=[];
ja=[];
jb=[];
cb=q;
for i=1:no
    ca(n1*i-n1+1:n1*i,1:2*2^no)=reshape(d(2*n1*i-2*n1+1:2*n1*i,1:2^no),n1,2*2^no);
end

for i=1:1:2^no%2*2^2
    ja(1:n1,1:2,i)=ca(1:n1,2*i-1:2*i);
    jb(1:n1,1,i)=cb(1:n1,i);
    for k=2:no
ja(1:n1*k,1:2*k,i)=blkdiag(ja(1:n1*k-n1,1:2*k-2,i),ca(n1*k-n1+1:n1*k,2*i-1:2*i));
jb(1:n1*k,1,i)=[jb(1:n1*k-n1,1,i);cb(n1*k-n1+1:n1*k,i)];
    end
end
CAZ=ja
size(CAZ);
CbAzimuth=jb;
size(CbAzimuth);
end


