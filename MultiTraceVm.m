% This script produce sample membrane potential (Vm) traces for used in the 
% figures. Figures were later exported as vector graphics for addition of other 
% layers such as light stimulus final adjustments in Adobe Illustrator
%
% Parameters to change:
% 1) Set root directory

%% START functions

% Clear workspace
clear all

% Close figures
close all

% Set root directory
root_directory = 'E:\Troup2018\Codes and Data\'; % Change this
cd(root_directory)

%% Set parameters

sam_rate = 10000; % In Hertz (usually 10kHz)
rec_duration = 300; % Recording duration in seconds (5min = 300s)
pulse_onset = 60; % Pulse onset in seconds
pulse_duration = 120;    % Duration of the pulse train in seconds
% pulse_freq = 1; % In Hertz

%% Enter directories and filenames

% NoChR Constant (n = 6)
no_chr{1,1} = 'Data\Ephys\2015-07-23';
no_chr{1,2} = '2015-07-23-fly1-LFPcell-002.mat';
no_chr{2,1} = 'Data\Ephys\2015-07-23';
no_chr{2,2} = '2015-07-23-fly2-LFPcell-002.mat';
no_chr{3,1} = 'Data\Ephys\2015-07-24';
no_chr{3,2} = '2015-07-24-fly1-LFPcell-002.mat';
no_chr{4,1} = 'Data\Ephys\2015-08-27';
no_chr{4,2} = '2015-08-27-fly1-LFPcell-002.mat';
no_chr{5,1} = 'Data\Ephys\2015-04-28';
no_chr{5,2} = '2015-04-28-fly1-cell1-001.mat';
no_chr{6,1} = 'Data\Ephys\2015-04-29';
no_chr{6,2} = '2015-04-29-fly1-cell1-001.mat';

% ChR Constant no spiking (n = 6)
chr_nospk{1,1} = 'Data\Ephys\2015-06-11';
chr_nospk{1,2} = '2015-06-11-fly1-LFPcell1-002.mat';
chr_nospk{2,1} = 'Data\Ephys\2015-07-09';
chr_nospk{2,2} = '2015-07-09-fly1-LFPcell-002.mat';
chr_nospk{3,1} = 'Data\Ephys\2015-08-14';
chr_nospk{3,2} = '2015-08-14-fly1-LFPcell-003.mat';
chr_nospk{4,1} = 'Data\Ephys\2015-09-02';
chr_nospk{4,2} = '2015-09-02-fly1-LFPcell-002.mat';
chr_nospk{5,1} = 'Data\Ephys\2015-04-09';
chr_nospk{5,2} = '2015-04-09-fly1-cell1-002.mat';
chr_nospk{6,1} = 'Data\Ephys\2015-05-12';
chr_nospk{6,2} = '2015-05-12-fly1-cell1-003.mat';

% ChR Constant spiking (n = 10)
chr_spk{1,1} = 'Data\Ephys\2015-06-30';
chr_spk{1,2} = '2015-06-30-fly1-LFPcell-002.mat';
chr_spk{2,1} = 'Data\Ephys\2015-07-29';
chr_spk{2,2} = '2015-07-29-fly1-LFPcell-003.mat';
chr_spk{3,1} = 'Data\Ephys\2015-09-08';
chr_spk{3,2} = '2015-09-08-fly1-LFPcell-002.mat';
chr_spk{4,1} = 'Data\Ephys\2015-04-10';
chr_spk{4,2} = '2015-04-10-fly1-cell1-002.mat';
chr_spk{5,1} = 'Data\Ephys\2015-04-10';
chr_spk{5,2} = '2015-04-10-fly1-cell2-001.mat';
chr_spk{6,1} = 'Data\Ephys\2015-04-30';
chr_spk{6,2} = '2015-04-30-fly1-cell1-001.mat';
chr_spk{7,1} = 'Data\Ephys\2015-05-07';
chr_spk{7,2} = '2015-05-07-fly1-cell1-009.mat';
chr_spk{8,1} = 'Data\Ephys\2015-05-11';
chr_spk{8,2} = '2015-05-11-fly1-cell1-001.mat';
chr_spk{9,1} = 'Data\Ephys\2015-05-12';
chr_spk{9,2} = '2015-05-12-fly2-cell1-004.mat';
chr_spk{10,1} = 'Data\Ephys\2015-06-18';
chr_spk{10,2} = '2015-06-18-fly1-cell1-002.mat';

% ChR-INX (n = 6)
chr_inx{1,1} = 'Data\Ephys\2016-08-25';
chr_inx{1,2} = '2016-08-25-fly1-LFPcell1-002.mat';
chr_inx{2,1} = 'Data\Ephys\2016-08-25';
chr_inx{2,2} = '2016-08-25-fly2-LFPcell1-002.mat';
chr_inx{3,1} = 'Data\Ephys\2016-08-28';
chr_inx{3,2} = '2016-08-28-fly1-LFPcell1-002.mat';
chr_inx{4,1} = 'Data\Ephys\2016-08-31';
chr_inx{4,2} = '2016-08-31-fly1-LFPcell1-002.mat';
chr_inx{5,1} = 'Data\Ephys\2016-08-31';
chr_inx{5,2} = '2016-08-31-fly2-LFPcell1-002.mat';
chr_inx{6,1} = 'Data\Ephys\2016-09-01';
chr_inx{6,2} = '2016-09-01-fly1-LFPcell1-008.mat';

%% NoChR Constant (n = 6)

for bb = 1:length(no_chr)

% Select current directory
cd(root_directory)
dirname = no_chr{bb,1};
cd(dirname);

% Load file
filename = no_chr{bb,2};
load(filename);

% Smaller chunks of time for plot x-axis display
c001_Time_1000 = c001_Time(1:10000)*1000; % 10000 data points or 1000ms

%% Generate new matrices to be plotted

% Extract mean values into holder variable
LFP_mean(bb,1:10000) = c002_Voltage(595001:605000); %#ok<SAGROW>

end

%% Normalise data (manually)

for cc = 1:length(no_chr)
    LFP_mean_norm(cc,:) = LFP_mean(cc,:)-mean(LFP_mean(cc,1:5000)); %#ok<SAGROW>
end

LFP_mean_norm_avg = mean(LFP_mean_norm);

%% Generate MultiTrace figure

handle_fig = figure('Color','white');
set(handle_fig, 'Position', [40 80 200 150])

% Plot raw traces of all stimulation
plot(c001_Time_1000,LFP_mean_norm,'k');
hold on
plot(c001_Time_1000,LFP_mean_norm_avg,'LineWidth',2.5,'Color','r');

% Plot scale bar
plot([525; 575], [-0.01; -0.01], '-k','LineWidth', 2); % scale bar: 50ms
plot([575; 575], [-0.01; 0], '-k','LineWidth', 2); % scale bar: 1uV
    
% Subplot formatting
ylabel('Voltage (V)','FontSize',12);
xlabel('Time (ms)','FontSize',12);
set(gca,'TickDir','out')
xlim([475 575])
% ylim([-0.02 0.02])
set(gca,'TickDir','out')
set(gca, 'Visible', 'off')

clear LFP_mean_norm LFP_mean_norm_avg;

%% ChR Constant no spiking (n = 6)

for bb = 1:length(chr_nospk)

% Directory of all tethered flies in the overnight preparation
cd(root_directory)
dirname = chr_nospk{bb,1};

% Select current directory
cd(dirname);

% Load file
filename = chr_nospk{bb,2};

load(filename);

% Smaller chunks of time for plot x-axis display
c001_Time_1000 = c001_Time(1:10000)*1000; % 10000 data points or 1000ms

%% Generate new matrices to be plotted

% Extract mean values into holder variable
LFP_mean(bb,1:10000) = c002_Voltage(595001:605000); %#ok<SAGROW>

end

%% Normalise data (manually)

for cc = 1:length(chr_nospk)
    LFP_mean_norm(cc,:) = LFP_mean(cc,:)-mean(LFP_mean(cc,1:5000)); %#ok<SAGROW>
end

LFP_mean_norm_avg = mean(LFP_mean_norm);

%% Generate MultiTrace figure

handle_fig = figure('Color','white');
set(handle_fig, 'Position', [240 80 200 150])

% Plot raw traces of all stimulation
plot(c001_Time_1000,LFP_mean_norm,'k');
hold on
plot(c001_Time_1000,LFP_mean_norm_avg,'LineWidth',2.5,'Color','r');

% Plot scale bar
plot([525; 575], [-0.01; -0.01], '-k','LineWidth', 2); % scale bar: 50ms
plot([575; 575], [-0.01; 0], '-k','LineWidth', 2); % scale bar: 1uV
    
% Subplot formatting
ylabel('Voltage (V)','FontSize',12);
xlabel('Time (ms)','FontSize',12);
set(gca,'TickDir','out')
xlim([475 575])
% ylim([-0.02 0.02])
set(gca,'TickDir','out')
set(gca, 'Visible', 'off')

clear LFP_mean_norm LFP_mean_norm_avg;

%% ChR Constant spiking (n = 10)

for bb = 1:length(chr_spk)

% Directory of all tethered flies in the overnight preparation
cd(root_directory)
dirname = chr_spk{bb,1};

% Select current directory
cd(dirname);

% Load file
filename = chr_spk{bb,2};

load(filename);

% Smaller chunks of time for plot x-axis display
c001_Time_1000 = c001_Time(1:10000)*1000; % 10000 data points or 1000ms

%% Generate new matrices to be plotted

% Extract mean values into holder variable
LFP_mean(bb,1:10000) = c002_Voltage(595001:605000); %#ok<SAGROW>

end

%% Normalise data (manually)

for cc = 1:length(chr_spk)
    LFP_mean_norm(cc,:) = LFP_mean(cc,:)-mean(LFP_mean(cc,1:5000)); %#ok<SAGROW>
end

LFP_mean_norm_avg = mean(LFP_mean_norm);

%% Generate MultiTrace figure

handle_fig = figure('Color','white');
set(handle_fig, 'Position', [440 80 200 150])

% Plot raw traces of all stimulation
plot(c001_Time_1000,LFP_mean_norm,'k');
hold on
plot(c001_Time_1000,LFP_mean_norm_avg,'LineWidth',2.5,'Color','r');

% Plot scale bar
plot([525; 575], [-0.01; -0.01], '-k','LineWidth', 2); % scale bar: 50ms
plot([575; 575], [-0.01; 0], '-k','LineWidth', 2); % scale bar: 1uV
    
% Subplot formatting
ylabel('Voltage (V)','FontSize',12);
xlabel('Time (ms)','FontSize',12);
set(gca,'TickDir','out')
xlim([475 575])
% ylim([-0.02 0.02])
set(gca,'TickDir','out')
set(gca, 'Visible', 'off')

clear LFP_mean_norm LFP_mean_norm_avg;

%% ChR-INX (n = 6)

for bb = 1:length(chr_inx)

% Directory of all tethered flies in the overnight preparation
cd(root_directory)
dirname = chr_inx{bb,1};

% Select current directory
cd(dirname);

% Load file
filename = chr_inx{bb,2};

load(filename);

% Smaller chunks of time for plot x-axis display
c001_Time_1000 = c001_Time(1:10000)*1000; % 10000 data points or 1000ms

%% Generate new matrices to be plotted

% Extract mean values into holder variable
LFP_mean(bb,1:10000) = c002_Voltage(595001:605000); %#ok<SAGROW>

end

%% Normalise data (manually)

for cc = 1:length(chr_inx)
    LFP_mean_norm(cc,:) = LFP_mean(cc,:)-mean(LFP_mean(cc,1:5000)); %#ok<SAGROW>
end

LFP_mean_norm_avg = mean(LFP_mean_norm);

%% Generate MultiTrace figure

handle_fig = figure('Color','white');
set(handle_fig, 'Position', [640 80 300 150])

% Plot raw traces of all stimulation
plot(c001_Time_1000,LFP_mean_norm,'k');
hold on
plot(c001_Time_1000,LFP_mean_norm_avg,'LineWidth',2.5,'Color','r');

% Plot scale bar
plot([625; 675], [-0.01; -0.01], '-k','LineWidth', 2); % scale bar: 50ms
plot([675; 675], [-0.01; 0], '-k','LineWidth', 2); % scale bar: 1uV
    
% Subplot formatting
ylabel('Voltage (V)','FontSize',12);
xlabel('Time (ms)','FontSize',12);
set(gca,'TickDir','out')
xlim([475 675])
% ylim([-0.02 0.02])
set(gca,'TickDir','out')
set(gca, 'Visible', 'off')
