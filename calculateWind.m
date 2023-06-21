function [Fxwind,Fywind,Mzwind]=calculateWind(kn,angle,hullSpecifics)
Cwx_h = 0.423*cos(angle*pi/180); Cwy_h=0.8*sin(angle*pi/180); Cwz_h=-0.143*sin(2*angle*pi/180);
Atrans_hull= hullSpecifics(1);
Along_hull=hullSpecifics(2);
Atrans_ss=hullSpecifics(3);
Along_ss=hullSpecifics(4);
LBP = hullSpecifics(5);
Fx_h=0.5*1.23*(kn*0.5144)^2*Cwx_h*Atrans_hull/1000;
Fy_h=0.5*1.23*(kn*0.5144)^2*Cwy_h*Along_hull/1000;
Mz_h=0.5*1.23*(kn*0.5144)^2*Cwz_h*Along_hull*LBP/1000;
Cw=0.615; Cs=1.1; Ch=1;
Fwx=Cw*Cs*Ch*Atrans_ss*(kn*0.5144)^2/1000;
Fwy=Cw*Cs*Ch*Along_ss*(kn*0.5144)^2/1000;
Fw=Fwy*2*sin(angle*pi/180)^2/(1+sin(angle*pi/180)^2) + Fwx*2*cos(angle*pi/180)^2/(1+cos(angle*pi/180)^2);
Fx_ss=Fw*cos(angle*pi/180); Fy_ss=Fw*sin(angle*pi/180); Mz_ss=Fy_ss*11.60;
Fxwind = Fx_h+Fx_ss; 
Fywind = Fy_h+Fy_ss;
Mzwind = Mz_h+Mz_ss;
end