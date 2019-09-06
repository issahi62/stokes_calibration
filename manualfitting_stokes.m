%clear
% close all

caseNr=1;


if(caseNr==1)
    saveName='S_1';
elseif(caseNr==2)
    saveName='S_2';
elseif(caseNr==3)
    saveName='S_3';
elseif(caseNr==4)
    saveName='S_4';
end


load([saveName,'.mat']);

maxvalue=max(data(:,5));

%maxvalue=1;

case0M=data(:,5)/maxvalue;
case1M=data(:,1)/maxvalue;
case2M=data(:,2)/maxvalue;
case3M=data(:,3)/maxvalue;
case4M=data(:,4)/maxvalue;



positionsShift=positions+10;


analyzer_angles=linspace(min(positionsShift),max(positionsShift),500);

%ideal parameters
Ein=[1;0];
px_analyzer = 1.0;
py_analyzer = 0.0;



% waveplate shifter 
Wp_shift=0.0005;

% % not ideal parameters
px_sample = 0.0; 
py_sample = 1;

%sample_1 values changing
pol_angle_sample1 = 0+1.25;
retardance_sample1 = pi/2 * 0.9867;
wp_angle_sample1 = pol_angle_sample1 + Wp_shift + 45;

%sample_2 values changing
pol_angle_sample2 = 90+14;
retardance_sample2 = retardance_sample1;
wp_angle_sample2 = pol_angle_sample2 + Wp_shift + 45;

%sample_3 values changing
pol_angle_sample3 = 45+10;
retardance_sample3 = retardance_sample1;
%wp_angle_sample3 = pol_angle_sample3 + Wp_shift + 45;
wp_angle_sample3 = pol_angle_sample3 + Wp_shift + 45;

%sample_4 values changing
pol_angle_sample4 = -45;
retardance_sample4 = retardance_sample1;
wp_angle_sample4 = pol_angle_sample4 + Wp_shift + 45;

Iref=zeros(size(analyzer_angles));
Iout1=zeros(size(analyzer_angles));
Iout2=zeros(size(analyzer_angles));
Iout3=zeros(size(analyzer_angles));
Iout4=zeros(size(analyzer_angles));

for ind=1:length(analyzer_angles)
    Eref =  linpol_tp(analyzer_angles(ind), px_analyzer, py_analyzer) *...
            Ein;
    
    if(caseNr==1)
        Eout1=Ecase1(Ein, wp_angle_sample1, retardance_sample1, pol_angle_sample1, px_sample, py_sample, analyzer_angles(ind), px_analyzer, py_analyzer);
        Eout2=Ecase1(Ein, wp_angle_sample2, retardance_sample2, pol_angle_sample2, px_sample, py_sample, analyzer_angles(ind), px_analyzer, py_analyzer);
        Eout3=Ecase1(Ein, wp_angle_sample3, retardance_sample3, pol_angle_sample3, px_sample, py_sample, analyzer_angles(ind), px_analyzer, py_analyzer);
        Eout4=Ecase1(Ein, wp_angle_sample4,  retardance_sample4, pol_angle_sample4, px_sample, py_sample, analyzer_angles(ind), px_analyzer, py_analyzer);
    elseif(caseNr==2)
        Eout1=Ecase2(Ein, wp_angle_sample1, retardance_sample1, pol_angle_sample1, px_sample, py_sample, analyzer_angles(ind), px_analyzer, py_analyzer);
        Eout2=Ecase2(Ein, wp_angle_sample2, retardance_sample2, pol_angle_sample2, px_sample, py_sample, analyzer_angles(ind), px_analyzer, py_analyzer);
        Eout3=Ecase2(Ein, wp_angle_sample3, retardance_sample3, pol_angle_sample3, px_sample, py_sample, analyzer_angles(ind), px_analyzer, py_analyzer);
        Eout4=Ecase2(Ein, wp_angle_sample4,  retardance_sample4, pol_angle_sample4, px_sample, py_sample, analyzer_angles(ind), px_analyzer, py_analyzer);
    elseif(caseNr==3)
        Eout1=Ecase3(Ein, wp_angle_sample1, retardance_sample1, pol_angle_sample1, px_sample, py_sample, analyzer_angles(ind), px_analyzer, py_analyzer);
        Eout2=Ecase3(Ein, wp_angle_sample2, retardance_sample2, pol_angle_sample2, px_sample, py_sample, analyzer_angles(ind), px_analyzer, py_analyzer);
        Eout3=Ecase3(Ein, wp_angle_sample3, retardance_sample3, pol_angle_sample3, px_sample, py_sample, analyzer_angles(ind), px_analyzer, py_analyzer);
        Eout4=Ecase3(Ein, wp_angle_sample4,  retardance_sample4, pol_angle_sample4, px_sample, py_sample, analyzer_angles(ind), px_analyzer, py_analyzer);
    elseif(caseNr==4)
        Eout1=Ecase4(Ein, wp_angle_sample1, retardance_sample1, pol_angle_sample1, px_sample, py_sample, analyzer_angles(ind), px_analyzer, py_analyzer);
        Eout2=Ecase4(Ein, wp_angle_sample2, retardance_sample2, pol_angle_sample2, px_sample, py_sample, analyzer_angles(ind), px_analyzer, py_analyzer);
        Eout3=Ecase4(Ein, wp_angle_sample3, retardance_sample3, pol_angle_sample3, px_sample, py_sample, analyzer_angles(ind), px_analyzer, py_analyzer);
        Eout4=Ecase4(Ein, wp_angle_sample4, retardance_sample4, pol_angle_sample4, px_sample, py_sample, analyzer_angles(ind), px_analyzer, py_analyzer);
    end
        
    Iref(ind) = sum(abs(Eref).^2); 
    Iout1(ind) = sum(abs(Eout1).^2);
    Iout2(ind) = sum(abs(Eout2).^2);
    Iout3(ind) = sum(abs(Eout3).^2);
    Iout4(ind) = sum(abs(Eout4).^2);
end    

% 
figure
hold on
plot(positionsShift,case0M, 'ko')
plot(positionsShift,case1M, 'ro')
plot(positionsShift,case2M, 'go')
plot(positionsShift,case3M, 'bo')
plot(positionsShift,case4M, 'co')
plot(analyzer_angles,Iref, 'k-')
plot(analyzer_angles,Iout1, 'r-')
plot(analyzer_angles,Iout2, 'g-')
plot(analyzer_angles,Iout3, 'b-')
plot(analyzer_angles,Iout3, 'c-')
xlabel('polarizer orientation [degrees]')
ylabel('power [W]')
ylim([0,1]);


myLegend=legend('analyzer only',...
    'A. analyzer, CPL_1',...
    'B. analyzer, CPL_2',...
    'C. analyzer, CPL_3',...
    'D. analyzer, CPL_4',...
    'fitted analyzer only',...
    'fitted A. CPL_1',...
    'fitted B. CPL_2',...
    'fitted C. CPL_3',...
    'fitted D. CPL_4');
set(myLegend,'Position',[0.599609375000001 0.491489128602729 0.1109375 0.295845272206304],...
    'fontsize', 12);
    
 % CPL_1 polarization angle is at 0 degrees with the waveplate oriented in its transmission axis 
 % CPL_2 polarization angle of the LPL is 45 degrees which is glued with the waveplate in its transmission axis 
 % CPL_3 polarization angle of the LPL is 90 degrees ... 
 % CPL_4 waveplate is infront of the light source oreinted at 45 degrees and stacked with a LPL at its transmission axis. 


% if(caseNr==1)
%     data=E_filterA;
% elseif(caseNr==2)
%     data=E_filterB;
% elseif(caseNr==3)
%     data=E_filterC;
% elseif(caseNr==4)
%     data=E_filterD;
% end
