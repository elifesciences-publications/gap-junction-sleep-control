% This script processes spike timing data with the output of raster plot and 
% peristimulus histogram. Time points for spikes were determined using AxoGraph 
% then exported to an Excel spreadsheet. Figures were later exported as vector 
% graphics for addition of other layers such as light stimulus final adjustments
% in Adobe Illustrator
%
% Parameters to change:
% 1) Set root directory

%% Start functions

% Clear workspace
clear all

% Close figures
close all

% Set root directory
root_directory = 'E:\Troup2018\Codes and Data\'; % Change this
cd(root_directory)

%% Read from external file and select dataset to analyse

% Read external xls file
[~, ~, raw] = xlsread('Data\Ephys\Spikes_times','ALL','','basic');

% Create output variables
dirnameset{1} = raw(3:619,1:1);    % 2015-04-30-fly1-cell1-010.mat
dirnameset{2} = raw(3:394,2:2);    % 2015-05-11-fly1-cell1-003.mat
dirnameset{3} = raw(3:624,3:3);    % 2015-07-29-fly1-LFPcell-004.mat
dirnameset{4} = raw(3:95,4:4);    % 2015-06-18-fly1-cell1-005.mat
dirnameset{5} = raw(3:375,5:5);    % 2015-07-24-fly1-LFPcell-001.mat - Control 23E10/+
dirnameset{6} = raw(3:976,6:6);    % 2015-04-08-fly1-cell1-005.mat - Control 23E10/Chrimson (no ATR)

for cellno = 1:6

% Select data set to analyse
dataset = cellno;
cdirname = dirnameset{dataset};

% Flicker period (ms)
flicker_period = 1200000;
baseline_period = 600000;

% Duration of cycle of each pulse
pulse_cycle = 10000;
pulse_count = 120; 

%% Convert cell to double

%  Setup vector
all_spike = zeros(size(cdirname,1),size(cdirname,2));

% Fill vector
for aa = 1:length(cdirname)
    all_spike(aa,1) = cdirname{aa,1};
end

% Rounddown
spike_integer = floor(all_spike);

% Move to zero
spike_zerostart = (spike_integer-baseline_period)';

% Set up vector
binary_spike = zeros(1,flicker_period);

% Fill vector with one whenever spikes
binary_spike(1,spike_zerostart) = ones;

% Setup matrix
matrix_spike = zeros(pulse_count,floor(pulse_cycle));

% Fill first row of matrix with one whenever spikes
matrix_spike(1,1:floor(pulse_cycle)) = binary_spike(1:floor(pulse_cycle));

% Fill the remaning rows of matrix with one whenever spikes
for bb = 2:pulse_count
    matrix_spike(bb,1:floor(pulse_cycle)) = binary_spike((bb-1)*floor(pulse_cycle)+1:bb*floor(pulse_cycle));
end

%% Plot raster

binarySpikes2 = matrix_spike;
binarySpikes2 = logical(binarySpikes2);
LineFormatHorz.LineWidth = 5;
LineFormatHorz.Color = 'b';
LineFormatVert.LineWidth = 5;
MarkerFormat.MarkerSize = 12;
MarkerFormat.Marker = '*';
        
% Prepare figure
handle_fig = figure('Color','white');
set(handle_fig, 'Position', [10 10 400 1000])

subplot(4,1,1:3);
ha = area([0 pulse_cycle/0], [pulse_count+1 pulse_count+1]);

% led_blue = strfind(raw(2,dataset),'Blue');
% led_green = strfind(raw(2,dataset),'Green');
% if led_blue{1} == 1
%     set(ha, 'FaceColor', 'c')
% elseif led_green{1} == 1
%     set(ha, 'FaceColor', 'g')
% end

set(ha, 'FaceColor', 'w')

hold on
plotSpikeRaster(binarySpikes2,'PlotType','vertline','LineFormat',LineFormatVert,'VertSpikePosition', -0.5);
title(raw(2,dataset));
xlabel('Time (ms)');
ylabel('Trial');
tick = 0:2000:10000;
set(gca,'XTick',tick)
set(gca,'XTickLabel', {'0', '200', '400', '600', '800', '1000'})
hold off
    
%% Spike distribution within each trial

sum_spike = sum(matrix_spike);

bin_spike = floor(pulse_cycle/20);

dist_spike(1:20) = zeros;

for cc = 1:20
    dist_spike(cc) = sum(sum_spike((cc*bin_spike)+1-bin_spike:cc*bin_spike)); %#ok<SAGROW>
end

%% Plot histogram

subplot(4,1,4)
bar(dist_spike,'k');
xlabel('Time bin');
ylabel('Spike count');
xlim([0 21]);

end
