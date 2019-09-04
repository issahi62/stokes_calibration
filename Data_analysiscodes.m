% variables

close all;
clc; 

name = 'blue_source'; % Name to be displayed on the figure based on the light source. 

%specific orientation of the cpl polarizers in the polarizing filter wheel.

E_filter1 =[]; % horizontally oriented
E_filter2 =[]; % vertically oriented 
E_filter3 =[]; % 45 degree angle oriented 
E_filter4 =[]; % -45 degree angle oriented 
E_filter5 =[]; % empty filter with no polarizer

%% Stokes parameters
%I = I_0^2 + I_90^2; I = intensity 
%Q = I_0^2 - I_90^2; Q and U are linear P
%U = I_45^2 - I_-45^2;
%V = 2*I_0^2*I_90^2*h; where h = handedness or RCP^2 + LCP^2 = circular P

%%
%Note the folders are named with respect to its color and specified
%wavelength on the power sensor device.
% section for loading the files 
myFolder = '/Users/kobbyTilly/Desktop/Polarizer_rotation_stokes/Blue_457nm'; 
if ~isdir(myFolder)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
  uiwait(warndlg(errorMessage));
  return;
end

% where S_1 = A, S_2 = B S_3 = C S_4 = D
% Note A,B,C and D are the different arrangements of the filter and the analyzer

filePattern = fullfile(myFolder, 'S_*');
matFiles = dir(filePattern);
[~, ind] = sort([matFiles.datenum]);
matFiles = matFiles(ind);

for k = 1:length(matFiles)
  matFilename = fullfile(myFolder, matFiles(k).name);
  matData=load(matFilename);
  
  hasField = isfield(matData, 'timeUsed');
  if ~hasField
       warningMessage = sprintf('Data is not in %s\n', matFilename);
    uiwait(warndlg(warningMessage));
    continue; 
  end
  
  data = matData.data;
  positions = matData.positions; 
  maxvalue=max(data(:,5));

   E_filter1 = [(E_filter1), data(:, 1)/maxvalue];
   E_filter2 = [(E_filter2), data(:, 2)/maxvalue];
   E_filter3 = [(E_filter3), data(:, 3)/maxvalue];
   E_filter4 = [(E_filter4), data(:, 4)/maxvalue];
   E_filter5 = [(E_filter5), data(:, 5)/maxvalue];
  
end

E_filterA = [E_filter5(:,2),E_filter1];
E_filterB = [E_filter5(:,2),E_filter2]; 
E_filterC = [E_filter5(:,2),E_filter3]; 
E_filterD = [E_filter5(:,2),E_filter4]; 

lineWidth=2;

curveFig =figure(1);
hold on
plot(positions,E_filterA(:, 1),'-','lineWidth',lineWidth);
plot(positions,E_filterA(:, 2),'-','lineWidth',lineWidth);
plot(positions,E_filterA(:, 3),'--','lineWidth',lineWidth);
plot(positions,E_filterA(:, 4),'-.','lineWidth',lineWidth);
plot(positions,E_filterA(:, 5),':','lineWidth',lineWidth);
myLegend=legend('analyzer only',...
    'A. analyzer, CPL',...
    'B. CPL, analyzer',...
    'C. analyzer, flipped CPL',...
    'D. flipped CPL, analyzer');
set(myLegend, 'fontsize', 10);
set(curveFig, 'position', [680   716   560   262]);
xlabel('analyzer orientation [degrees]')
ylabel('intensity')
title('Filter1')
ylim([0,1])

curveFig =figure(2);
hold on
plot(positions,E_filterB(:, 1),'-','lineWidth',lineWidth);
plot(positions,E_filterB(:, 2),'-','lineWidth',lineWidth);
plot(positions,E_filterB(:, 3),'--','lineWidth',lineWidth);
plot(positions,E_filterB(:, 4),'-.','lineWidth',lineWidth);
plot(positions,E_filterB(:, 5),':','lineWidth',lineWidth);
myLegend=legend('analyzer only',...
    'A. analyzer, CPL',...
    'B. CPL, analyzer',...
    'C. analyzer, flipped CPL',...
    'D. flipped CPL, analyzer');
set(myLegend, 'fontsize', 10);
set(curveFig, 'position', [680   716   560   262]);
xlabel('analyzer orientation [degrees]')
ylabel('intensity')
title('Filter2')
ylim([0,1])

curveFig =figure(3);
hold on
plot(positions,E_filterC(:, 1),'-','lineWidth',lineWidth);
plot(positions,E_filterC(:, 2),'-','lineWidth',lineWidth);
plot(positions,E_filterC(:, 3),'--','lineWidth',lineWidth);
plot(positions,E_filterC(:, 4),'-.','lineWidth',lineWidth);
plot(positions,E_filterC(:, 5),':','lineWidth',lineWidth);
myLegend=legend('analyzer only',...
    'A. analyzer, CPL',...
    'B. CPL, analyzer',...
    'C. analyzer, flipped CPL',...
    'D. flipped CPL, analyzer');
set(myLegend, 'fontsize', 10);
set(curveFig, 'position', [680   716   560   262]);
title('Filter3')
xlabel('analyzer orientation [degrees]')
ylabel('intensity')
ylim([0,1])

curveFig = figure(4);
hold on
plot(positions,E_filterD(:, 1),'-','lineWidth',lineWidth);
plot(positions,E_filterD(:, 2),'-','lineWidth',lineWidth);
plot(positions,E_filterD(:, 3),'--','lineWidth',lineWidth);
plot(positions,E_filterD(:, 4),'-.','lineWidth',lineWidth);
plot(positions,E_filterD(:, 5),':','lineWidth',lineWidth);
myLegend=legend('analyzer only',...
    'A. analyzer, CPL',...
    'B. CPL, analyzer',...
    'C. analyzer, flipped CPL',...
    'D. flipped CPL, analyzer');
set(myLegend,'fontsize', 10);
set(curveFig, 'position', [680   716   560   262]);
title('Filter4')
xlabel('analyzer orientation [degrees]')
ylabel('intensity')
ylim([0,1])

P={zeros(4)}; 
fh = figure('Name', name,'NumberTitle','off');
screenfig = 4; 
for ii = 1:screenfig
    subplot(2,2,ii)
    P{ii} = get(gca,'pos');
end
clf
F = findobj('type','figure');
for ii = 2:5
    ax = findobj(F(ii),'type','axes');
    set(ax,'parent',fh,'pos',P{6-ii})
    close(F(ii))
end
          