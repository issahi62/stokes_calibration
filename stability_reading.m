clear
skippedRows=2;

figure
hold on

colors='rgb';

% fileNames={'671nm_new_stability.txt','532nm_stability.txt','457nm_stability.txt'};
% fileNames={'IR_stability_27_6_2019.txt'};
fileNames={'New_green_pointer.txt'};
% for indColor=1:3
for indColor=1:1
    fid = fopen(fileNames{indColor});
    out=textscan(fid,'%s  %s  %s  %s', 'headerlines',  skippedRows);
    fclose(fid);

    Nvalues=length(out{3});

    powers=zeros(1,Nvalues);
    powerCell=out{3};
    timeCell=out{2};
    timesSec=zeros(1,Nvalues);

    for ind=1:Nvalues
    % for ind=1
        powerStr=powerCell{ind};
        powerStr = strrep(powerStr,',','.');

        powers(ind)=str2double(powerStr);

        timeStr=timeCell{ind};
        timesSec(ind) = str2double(timeStr(1:2))*60*60 +...
                        str2double(timeStr(4:5))*60 +...
                        str2double(timeStr(7:8)) +...
                        str2double(timeStr(10:12))*0.001;
    end
    timesMin=(timesSec-timesSec(1))/60;


    plot(timesMin,powers,colors(indColor))
end

xlabel('time [min]')
ylabel('optical power [W]')
axis tight;