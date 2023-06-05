function Tref=calculateForcewoc(num,kn,hullSpecifics,currentdata,bowshape,vesselType)
h=waitbar(0,'calculating Environmental Forces');
for i=1:36
    waitbar(i/36);
    angle=(i-1)*10;
    [Fxwind,Fywind,Mzwind]=calculateWind(kn,angle,hullSpecifics);
    [Fxc,Fyc,Mzc] =calculateCurrent(currentdata,bowshape,angle,hullSpecifics,vesselType);
    Tref(1,i)=(num(i,2)+Fxwind+Fxc);
    Tref(2,i)=(num(i,4)+Fywind+Fyc);
    Tref(3,i)=(num(i,6)+Mzwind+Mzc);
end
end