function [lb,ub]=calculateBounds(T,Az,Tmax,Azmax,Tmax_rudder,T0,propNumber)
T1max = 0.95*Tmax;
Az1max=0.95*Azmax;
T10=0.95*T0;
for i=1:T
lb(i)=-T1max(i);
ub(i)=T1max(i);
end
for j=1:Az
lb(T+2*j-1)=-Az1max(j);
lb(T+2*j)=-Az1max(j);
ub(T+2*j-1)=Az1max(j);
ub(T+2*j)=Az1max(j);
end
for k=1:1:propNumber
lb(T+2*Az+3*k-2)=-Tmax_rudder;
lb(T+2*Az+3*k-1)=-Tmax_rudder;
lb(T+2*Az+3*k)=0;
ub(T+2*Az+3*k-2)=Tmax_rudder;
ub(T+2*Az+3*k-1)=Tmax_rudder;
ub(T+2*Az+3*k)=T10;
end
end