function b = calculatebMatrix(T,Az,Tmax,Azmax,del,T0,propNumber,azcoord,index,no)
T1max = 0.95*Tmax; 
Az1max=0.95*Azmax;
T01 = 0.95*T0;
s=size(index);
no=s(1,2);
bAzimuth=[];
bTunnel=[];
for i=1:T
bTunnel(2*i-1:2*i,1)=[T1max(i);T1max(i)];
end

for j=1:Az-no%CHANGEDFDSFADDDD
        R = Az1max(j);
        N=pi/acos(0.99);
        r = R*cos(pi/N);
        bAzimuth(22*j-21:22*j,1)=r;
    
end
b=[];
b=[b;bTunnel];
 b=[b;bAzimuth];
[CAZ,CbAzimuth]=forbidden(Azmax,index,azcoord);
sectors=26;
D1=b;
for i=1:2^(no)
b(1:2*T+no*(sectors+2)+22*(Az-no),1,i)=[D1;CbAzimuth(:,:,i)];
end


[Tmax_rudder,F,a,bk,sectors,S]=calculateRudderParameters(del,T01);
bRudderPropeller = bk;
D1=b;
S1=size(b);
    S2=size(bRudderPropeller);
for i=1:2^(no)
if (propNumber==1)
     b(1:S1(1,1)+S2(1,1),1,i)= [(D1(:,:,i));bRudderPropeller];
elseif (propNumber==2)
    b=[b;bk;bk];
    b(1:S1(1,1)+S2(1,1),1,i)= [D(:,:,i);ArudderPropeller];
     D=A;
     b(1:S1(1,1)+2*S2(1,1),1,i)= [D(:,:,i);ArudderPropeller];
end
end
size(b)
end