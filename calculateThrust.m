function [u,Othrust]=calculateThrust(T,Az,propNumber,W,A,b,B,Ttaken,lb,ub,Tmax,Azmax,no)
T1max = 0.95*Tmax;
S = size(B);
S2 = S(1,2);
s1=size(A);
s2=size(b);
s12=s1(1,2);
s22=s2(1,2);
T
Az
%thrust=zeros(T+Az+2*propNumber+1+2,24)
for p=1:2^no
for i=1:36
   
    %using try and catch to seperate feasible and infeasible solutions
    try
        u(1,i,p)= (i-1)*10; thrust(1,i,p)=(i-1)*10; Tr=Ttaken(1:3,i);
        u(2:S2+1,i,p) = quadprog(W,[],A(1:s1(1,1),1:s1(1,2),p),b(1:s1(1,1),1,p),B,Tr,lb,ub);
        
        
        %Making those solutions zero which did not converge
        if abs(B*u(2:end,i,p) - Ttaken(1:3,i))>=1e-4
            u(2:S2+1,i,p)=0;
        end
        m=6
        for j=1:T
        thrust(j+1,i,p)=(u(j+1,i,p));
        end
        
        for k=1:Az
        thrust(T+1+k,i,p)=sqrt(u(T+1+2*k-1,i,p)^2+u(T+1+2*k,i,p)^2);
        end
        
        for j=1:propNumber
          thrust(T+1+Az+2*j-1,i,p)=sqrt(u(T+1+2*Az+3*j-2,i,p)^2+u(T+1+2*Az+3*j-1,i,p)^2);
          thrust(T+1+Az+2*j,i,p)=sqrt(u(T+1+2*Az+3*j,i,p)^2);
        end
        
thrust(T+1+Az+2*propNumber+1,i,p)=sum(abs(thrust(2:T+1+Az,i,p)));
thrust(T+1+Az+2*propNumber+2,i,p)=thrust(T+1+Az+2*propNumber+1,i,p)/(sum(Tmax)+sum(Azmax));

    catch
%         display('Error');
        u(2:S2+1,i,p)=0; %thrust(2:11,i)=0;
    end
end
end

for i=1:1:2^no
for j=1:1:36
    Power(i,j)=u(2:S2+1,j,i)'*W(:,:,1)*u(2:S2+1,j,i);
end
end
for i=1:36
[value(i),index(i)]=min(Power(:,i));
Othrust(:,i)=thrust(:,i,index(i));
end

end
