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

%% Enter parameters

sam_rate = 10000; % In Hertz (usually 10kHz)
pulse_onset = 60; % Pulse onset in seconds
pulse_duration = 120;    % Duration of the pulse train in seconds

%% Directories and filenames

pulse_list{1,1} = 'Data\Ephys\2015-04-30';
pulse_list{1,2} = '2015-04-30-fly1-cell1-010.mat';
pulse_list{2,1} = 'Data\Ephys\2015-07-09';
pulse_list{2,2} = '2015-07-09-fly1-LFPcell-001.mat';
pulse_list{3,1} = 'Data\Ephys\2015-07-24';
pulse_list{3,2} = '2015-07-24-fly1-LFPcell-001.mat';
pulse_list{4,1} = 'Data\Ephys\2016-08-31';
pulse_list{4,2} = '2016-08-31-fly1-LFPcell1-001.mat';

%% Load and read files

for bb = 1:4

% Select current directory
cd(root_directory)
dirname = pulse_list{bb,1};
cd(dirname);

% Load file
filename = pulse_list{bb,2};
load(filename);

% Convert unit V to mV
c002_Voltage = c002_Voltage*1000;

% Smaller chunks of time for plot x-axis display
c001_Time_1000 = c001_Time(1:10000)*1000; % 10000 data points or 1000ms
c001_Time_100 = c001_Time(1:1000)*1000; % 1000 data points or 100ms

% Clear unused variables
clearvars fData fIndex fName fPath c002_Voltage_V;

%% Generate new matrices to be plotted

% Look for moments at the beginning of every LED pulse
stim_photo = c003_Photodiode(pulse_onset*sam_rate+1:pulse_onset*sam_rate+pulse_duration*sam_rate);
stim_photo_diff = diff(stim_photo);
stim_photo_start_idx = find((max(stim_photo_diff)-min(stim_photo_diff))/4); % if correct, should be an array of 120 for 1Hz pulses

% Generate new matrices for 1000ms plot

% Preallocate matrix with zeros
stim_voltage_flicker_1000 = zeros(120,1*sam_rate);

% Include voltage data during pulse only
stim_voltage = c002_Voltage(pulse_onset*sam_rate+1:pulse_onset*sam_rate+pulse_duration*sam_rate);

% Set time point intervals to display, i.e. 1000ms
idx_120 = 1:10000:1200000;

for aa=1:120
    stim_voltage_flicker_1000(aa,:) = stim_voltage(idx_120(aa):idx_120(aa)+(1*(sam_rate))-1);
end
    
% Calculate mean and standard error across all pulses
stim_voltage_mean_1000 = nanmean(stim_voltage_flicker_1000);
stim_voltage_SE_1000 = nanstd(stim_voltage_flicker_1000,1)/sqrt(length(stim_voltage_flicker_1000(:,1)));

%% 250ms trace

handle_fig = figure('Color','white');
set(handle_fig, 'Position', [100 800 300 150])

% Plot raw traces of all pulses
stim_voltage_flicker_1000_graph = stim_voltage_flicker_1000';
plot(c001_Time_1000(1:250),stim_voltage_flicker_1000_graph(9751:10000,:),'k');
hold on
plot(c001_Time_1000(1:250),stim_voltage_mean_1000(9751:10000),'LineWidth',2.5,'Color','y');
plot(c001_Time_1000(251:2000),stim_voltage_flicker_1000_graph(1:1750,:),'k');
plot(c001_Time_1000(251:2000),stim_voltage_mean_1000(1:1750),'LineWidth',2.5,'Color','y');

% Subplot formatting
ylabel('Vm (mV)','FontSize',12);
% xlabel('Time (ms)','FontSize',12);
xlim([0 220]);
% ylim([-25 0]);
set(gca,'TickDir','out')
% set(gca, 'Visible', 'off')

end
