function [a,b]=calculateAdisjunct(sectors,theta_start,theta_iter,Azm)
F(1,:)=0;
Azm
for i=2:sectors+2
    theta=theta_start+theta_iter*(i-2);
    F(i,1)=theta;
    F(i,2)=Azm*cos(theta*pi/180);%ux
    F(i,3)=Azm*sin(theta*pi/180);%uy
end
F(sectors+3,:)=0;
F;
    a=[];
    b=[];
   for j=1:sectors+2
    a(j,1)=F(j+1,3)-F(j,3);
    a(j,2)=F(j,2)-F(j+1,2);
    b(j,1)=F(j,2)*F(j+1,3)-F(j,3)*F(j+1,2);
    
   end    
end
