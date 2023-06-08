function CurrentWaveForces = calculateSumofCurrentWaveForces(num,currentdata,vesselType,bowshape,hullSpecificdata)
h=waitbar(0,'calculating environmental Forces');
CurrentWaveForces =[];
for i=1:24
    waitbar(i/24);
    angle = (i-1)*15;
    CurrentWaveForces(1,i)=angle;
    [Fx,Fy,Mz] = calculateCurrent(currentdata,bowshape,angle,hullSpecificdata,vesselType);
    CurrentWaveForces(2,i) = Fx+ num(i,2);
    CurrentWaveForces(3,i) = Fy+ num(i,4);
    CurrentWaveForces(4,i) = Mz+ num(i,6);
end
close(h);
end