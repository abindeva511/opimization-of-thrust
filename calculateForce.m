function Tref=calculateForce(response,num,kn,hullSpecifics,currentdata,bowshape,vesselType)
numlines=1;
h=waitbar(0,'calculating Environmental Forces');
if (response=='y'|| response=='Y')
for i=1:36
    waitbar(i/36);
    angle=(i-1)*10;
    [Fxwind,Fywind,Mzwind]=calculateWind(kn,angle,hullSpecifics);
    [Fxc,Fyc,Mzc] =calculateCurrent(currentdata,bowshape,angle,hullSpecifics,vesselType);
    Tref(1,i)=(num(i,2)+Fxwind+Fxc);
    Tref(2,i)=(num(i,4)+Fywind+Fyc);
    Tref(3,i)=(num(i,6)+Mzwind+Mzc);
    
    Fwind(1,i)=Fxwind;
    Fwind(2,i)=Fywind;
    Fwind(3,i)=Mzwind;
    
    Fcurrent(1,i)=Fxc;
    Fcurrent(2,i)=Fyc;
    Fcurrent(3,i)=Mzc;
    
    
end
fname = 'Enter the filename to save the data: ';
defname = {'wave and current'};
filename = inputdlg(fname,'file name',numlines,defname);
filename = filename{1};
filename = strcat(filename,'.xlsx');
sheetName=strcat('wind',num2str(kn));
xlswrite(filename,Fwind,sheetName);
sheetName=strcat('current',num2str(kn));
xlswrite(filename,Fcurrent,sheetName);
else
for i=1:36
    waitbar(i/36);
    angle=(i-1)*10;
    [Fxwind,Fywind,Mzwind]=calculateWind(kn,angle,hullSpecifics);
   
    Tref(1,i)=(num(i,2)+Fxwind);
    Tref(2,i)=(num(i,4)+Fywind);
    Tref(3,i)=(num(i,6)+Mzwind);
 
    
    
    
end
end


close(h);
end