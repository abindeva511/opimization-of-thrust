function [Tmax_rudder,F,a,bk,sectors,S]=calculateRudderThings(del,T0)
T10 = 0.95*T0;
lift_percent=[0,-0.1,-0.2,-0.3,-0.35,-0.425,-0.45,-0.45,-0.45]';  %Lift Percent of T0
Drag_percent=[0.01,0.02,0.025,0.1,0.2,0.30,0.45,0.6,0.65]';   %Drag percent of T0
rudderAngle=[0 5 10 15 20 25 30 35 40]';
LiftDragMatrix=[];
%lift=lift_per*T0; drag=Drag_per*T0;
for i=1:9
        LiftDragMatrix(i,1)=rudderAngle(i);  %1st column is rudder angle
        LiftDragMatrix(i,2)= lift_percent(i)*T10;  % 2nd column is lift force
        LiftDragMatrix(i,3)= Drag_percent(i)*T10;  % 3rd column is Drag Force
        LiftDragMatrix(i,4)= sqrt(LiftDragMatrix(i,2)^2 + LiftDragMatrix(i,3)^2); %4th column is total rudder thrust
end

x= LiftDragMatrix(:,1)==del;  %Finding rudder angle in LiftDragMatrix
Tmax_rudder=LiftDragMatrix(x,4);  %Assigning 4th column of LiftDragMatrix as Maximum rudder force

%F is coordinateMatrix
for i=1:8
    %Evaluating Coordinate Matrix
    F=[];
    F(1,1:3)=0;
    theta_iter=5;
     theta_sweep = 2*del;
%     theta_start = (90-del);
%     theta_end
    sectors = theta_sweep/theta_iter;
    for j=2:sectors+2
        theta=del-theta_iter*(j-2);
        F(j,1)=theta;
        F(j,2)=Tmax_rudder* cos(theta*pi/180);%ux
        F(j,3)=Tmax_rudder* sin(theta*pi/180);%uy
    end
    F(sectors+3,1:3)=0;
    a=[];
    bk=[];
   for j=1:sectors+2
    a(j,1)=F(j+1,3)-F(j,3);
    a(j,2)=F(j,2)-F(j+1,2);
    bk=F(j,2)*F(j+1,3)-F(j,3)*F(j+1,2);
   end    
    a(sectors+3:sectors+4,3)=[-1;1];
    bk(sectors+3:sectors+4,1)=[T10;0];
    S = sectors+4;  %just for simplicity

end
end