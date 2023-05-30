function A = calculateAMatrix(T,Az,del,T0,propNumber,azcoord,Azmax,index,no)
T01 = 0.95*T0;
A=[];
F=[];
D=[];
AT(1:2,1)=[1;-1];
N=pi/acos(0.99);
s=size(index);
 for k=0:21
     phi=(2*k+1)*pi/N;
     j=k+1;
     AZ(j,1)= cos(phi);
     AZ(j,2)= sin(phi);
 end
 for i=1:T
    A=concatenateMatrix(A,AT);
 end
 for i=1:Az-no
    A=concatenateMatrix(A,AZ);
 end

%calculatinf A for azimuth
    [CAZ,CbAzimuth]=forbidden(Azmax,index,azcoord);
   
display('size of caz and cabzimuth(amatrix)');
size(CAZ);
size(CbAzimuth)
 
 [Tmax_rudder,F,a,bk,sectors,S] = calculateRudderParameters(del,T01);
ArudderPropeller = a;
 D1=A;
 sectors=26;
for i=1:2^(no)
    
A(1:2*T+no*(sectors+2)+22*(Az-no),1:T+2*Az,i)=blkdiag(D1,CAZ(:,:,1));
end
D=A;
S1=size(A);
    S2=size(ArudderPropeller);
 for i=1:2^(no)
if propNumber==1
 A(1:S1(1,1)+S2(1,1),1:S2(1,2)+S1(1,2),i)= concatenateMatrix(D(:,:,i),ArudderPropeller);
elseif propNumber==2
     A(1:S1(1,1)+S2(1,1),1:S2(1,2)+S1(1,2),i)= concatenateMatrix(D(:,:,i),ArudderPropeller);
     D=A;
     A(1:S1(1,1)+2*S2(1,1),1:2*S2(1,2)+S1(1,2),i)= concatenateMatrix(D(:,:,i),ArudderPropeller);
end
 end
end