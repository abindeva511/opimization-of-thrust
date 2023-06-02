function [Fxc,Fyc,Mzc] =  calculateCurrent(currentdata,bowshape,angle,hullSpecificdata,vesselType)
currentSpeed = currentdata(1,1);
ratio = currentdata(1,2);
B=hullSpecificdata(6);
T = hullSpecificdata(7);
LBP = hullSpecificdata(5);
filename = 'current_coeff1.xlsx';

if(ratio<4.4)
    if(ratio>=1.2 && ratio<1.5)
        if (strcmp(bowshape,'co')==1 || strcmp(bowshape,'CO')==1)
            sheetnameCx = 'Cx_1.2';
            dataRangeCx = 'G6:H357';
            Cxdata = xlsread(filename,sheetnameCx,dataRangeCx);
        elseif (strcmp(bowshape,'cy')==1 || strcmp(bowshape,'CY')==1)
            sheetnameCx = 'Cx_1.2';
            dataRangeCx = 'J6:K259';
            Cxdata = xlsread(filename,sheetnameCx,dataRangeCx);
        end
        sheetnameCy = 'Cy';
        dataRangeCy = 'Q6:R72';
        Cydata = xlsread(filename,sheetnameCy,dataRangeCy);
        sheetnameCn = 'Cn_all';
        dataRangeCn = 'M7:N89';
        Cndata = xlsread(filename,sheetnameCn,dataRangeCn);
    elseif (ratio>=1.5 && ratio<3)
        if (strcmp(bowshape,'co')==1 || strcmp(bowshape,'CO')==1)
            sheetnameCx = 'Cx_1.5';
            dataRangeCx = 'A2:B112';
            Cxdata = xlsread(filename,sheetnameCx,dataRangeCx);
        elseif (strcmp(bowshape,'cy')==1 || strcmp(bowshape,'CY')==1)
            sheetnameCx = 'Cx_1.5';
            dataRangeCx = 'D2:E124';
            Cxdata = xlsread(filename,sheetnameCx,dataRangeCx);
        end
        sheetnameCy = 'Cy';
        dataRangeCy = 'O6:P72';
        Cydata = xlsread(filename,sheetnameCy,dataRangeCy);
        sheetnameCn = 'Cn_all';
        dataRangeCn = 'S7:T101';
        Cndata = xlsread(filename,sheetnameCn,dataRangeCn);
    elseif (ratio>=3 && ratio<4.4)
        if (strcmp(bowshape,'co')==1 || strcmp(bowshape,'CO')==1)
            sheetnameCx = 'Cx_3';
            dataRangeCx = 'I2:J94';
            Cxdata = xlsread(filename,sheetnameCx,dataRangeCx);
        elseif (strcmp(bowshape,'cy')==1 || strcmp(bowshape,'CY')==1)
            sheetnameCx = 'Cx_3';
            dataRangeCx = 'L2:M86';
            Cxdata = xlsread(filename,sheetnameCx,dataRangeCx);
        end
        sheetnameCy = 'Cy';
        dataRangeCy = 'M6:N66';
        Cydata = xlsread(filename,sheetnameCy,dataRangeCy);
        sheetnameCn = 'Cn_all';
        dataRangeCn = 'Q7:R75';
        Cndata = xlsread(filename,sheetnameCn,dataRangeCn);
    end
    
elseif (ratio>=4.4)
    if     (strcmp(vesselType,'Supply Vessel')==1 || strcmp(vesselType,'supply vessel')==1)
        sheetnameCx = 'Cx_shiptype';
        dataRangeCx = 'D2:E262';
        sheetnameCy = 'Cy_shiptype';
        dataRangeCy = 'A2:B67';
        sheetnameCn = 'Cn_shiptype';
        dataRangeCn = 'J3:K74';
    elseif (strcmp(vesselType,'Ferry')==1 || strcmp(vesselType,'ferry')==1)
        sheetnameCx = 'Cx_shiptype';
        dataRangeCx = 'M2:N172';
        sheetnameCy = 'Cy_shiptype';
        dataRangeCy = 'D2:E63';
        sheetnameCn = 'Cn_shiptype';
        dataRangeCn = 'G3:H62';
    elseif (strcmp(vesselType,'Container')==1 || strcmp(vesselType,'Container')==1)
        sheetnameCx = 'Cx_shiptype';
        dataRangeCx = 'J2:K188';
        sheetnameCy = 'Cy_shiptype';
        dataRangeCy = 'G2:H58';
        sheetnameCn = 'Cn_shiptype';
        dataRangeCn = 'A3:B51';
    elseif (strcmp(vesselType,'Tanker')==1 || strcp(vesselType,'tanker')==1)
        sheetnameCx = 'Cx_shiptype';
        dataRangeCx = 'A2:B282';
        sheetnameCy = 'Cy_shiptype';
        dataRangeCy = 'J2:K50';
        sheetnameCn = 'Cn_shiptype';
        dataRangeCn = 'M3:N50';
    elseif (strcmp(vesselType,'Drill Ship')==1 || strcmp(vesselType,'drill ship')==1)
        sheetnameCx = 'Cx_shiptype';
        dataRangeCx = 'G2:H237';
        sheetnameCy = 'Cy_shiptype';
        dataRangeCy = 'M2:N54';
        sheetnameCn = 'Cn_shiptype';
        dataRangeCn = 'D3:E53';
    end
    Cxdata = xlsread(filename,sheetnameCx,dataRangeCx);
    Cydata = xlsread(filename,sheetnameCy,dataRangeCy);
    Cndata = xlsread(filename,sheetnameCn,dataRangeCn);
end

    Cxfit = fit(Cxdata(1:end,1),Cxdata(1:end,2),'linearinterp');
    Cyfit = fit(Cydata(1:end,1),Cydata(1:end,2),'linearinterp');
    Cnfit = fit(Cndata(1:end,1),Cndata(1:end,2),'linearinterp');
    
    Ccx = Cxfit(angle);
    Ccy = Cyfit(angle);
    Ccn = Cnfit(angle);
    rho = 1.025;
    Fxc = 0.5*rho*(currentSpeed*0.5144)^2*B*T*Ccx;
    Fyc = 0.5*rho*(currentSpeed*0.5144)^2*LBP*T*Ccy;
    Mzc = 0.5*rho*(currentSpeed*0.5144)^2*LBP^2*T*Ccn;
end