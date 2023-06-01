function W=calculateCostMatrix(T,Az,userResponse,Tmax,Azmax,Tmax_rudder,T0,propNumber)
%T1max = 0.95*Tmax;
T10 = T0*0.95;

if (userResponse=='n'|| userResponse=='N')
        thrustAmount=[0,50,100,150,200,250,300]';
        power = [440,550,700,950,1300,1700,2150]';
        options = fitoptions('Method','LinearLeastSquares');
        cfit = fit(thrustAmount,power,'poly2',options);
        P2=cfit.p2/300;
        P1=cfit.p1+P2;
        for i=1:T
        w(i)=P1*Tmax(i)/300;
        end
        for j=1:Az
        w(T+2*j-1)=P1*Azmax(j)/300;
        w(T+2*j)=P1*Azmax(j)/300;
        end
        for k=1:propNumber
        w(T+2*Az+3*k-2)=P1*Tmax_rudder/300;
        w(T+2*Az+3*k-1)=P1*Tmax_rudder/300;
        w(T+2*Az+3*k)=P1*T10/300;
        end
  elseif (userResponse=='y'|| userResponse=='Y')
            thrustAmountTunnel='Input the thrust points of tunnel thruster in a vector:';
            thrustAmountTunnel=inputdlg(thrustAmountTunnel);
            thrustAmountTunnel = str2num(thrustAmountTunnel{:});
            powerTunnel = 'Input the corresponding Power: ';
            powerTunnel = inputdlg(powerTunnel);
            powerTunnel = str2num(powerTunnel{:});
            options = fitoptions('Method','LinearLeastSquares');
            cfit1=fit(thrustAmountTunnel',powerTunnel','poly2',options);
            P2 = cfit1.p2/thrustAmountTunnel(end);
            w1=cfit1.p1+P2; 
            for i=1:T
            w(i)=w1;
            end
            thrustAmountAzimuth='Input the thrust points of azimuth thruster in a vector: ';
            thrustAmountAzimuth= inputdlg(thrustAmountAzimuth);
            thrustAmountAzimuth=str2num(thrustAmountAzimuth{:});
            powerAzimuth = 'Input the corresponding powers: ';
            powerAzimuth = inputdlg(powerAzimuth);
            powerAzimuth = str2num(powerAzimuth{:});
            cfit2 = fit(thrustAmountAzimuth',powerAzimuth','poly2',options);
            w2 = cfit2.p1 + cfit2.p2/thrustAmountAzimuth(end);
            
            for j=1:Az
            w(T+2*j-1)=w2;
            w(T+2*j)=w2;
            end

            thrustAmountRudder = 'Input the thrust points of rudder in a vector: ';
            thrustAmountRudder = inputdlg(thrustAmountRudder);
            thrustAmountRudder = str2num(thrustAmountRudder{:});
            powerRudder = 'Input the corresponding powers: ';
            powerRudder = inputdlg(powerRudder);
            powerRudder = str2num(powerRudder{:});
            cfit3=fit(thrustAmountRudder',powerRudder','poly2',options);
            w5 = cfit3.p1+ cfit3.p2/thrustAmountRudder(end);
           
            for k=1:propNumber
            w(T+2*Az+3*k-2)=w5;
            w(T+2*Az+3*k-1)=w5;
            end
            
            thrustAmountPropeller = 'Input the thrust points of propeller in a vector: ';
            thrustAmountPropeller = inputdlg(thrustAmountPropeller);
            thrustAmountPropeller = str2num(thrustAmountPropeller{:});
            powerPropeller = 'Input the corresponding powers: ';
            powerPropeller = inputdlg(powerPropeller);
            powerPropeller = str2num(powerPropeller{:});
            cfit4=fit(thrustAmountPropeller',powerPropeller','poly2',options);
            w6 = cfit4.p1+cfit4.p2/thrustAmountPropeller(end);
            
            for k=1:propNumber
            w(T+2*Az+3*k)=w6;
            end
end

for i=1:T+2*Az+3*propNumber
W=diag(w);
end
end