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

raster_list{1,1} = 'Data\Ephys\2015-04-30';
raster_list{1,2} = '2015-04-30-fly1-cell1-010.mat';
raster_list{2,1} = 'Data\Ephys\2015-05-11';
raster_list{2,2} = '2015-05-11-fly1-cell1-003.mat';
raster_list{3,1} = 'Data\Ephys\2015-07-29';
raster_list{3,2} = '2015-07-29-fly1-LFPcell-004.mat';
raster_list{4,1} = 'Data\Ephys\2015-06-18';
raster_list{4,2} = '2015-06-18-fly1-cell1-005.mat';
raster_list{5,1} = 'Data\Ephys\2015-07-24';
raster_list{5,2} = '2015-07-24-fly1-LFPcell-001.mat';
raster_list{6,1} = 'Data\Ephys\2015-04-08';
raster_list{6,2} = '2015-04-08-fly1-cell1-005.mat';

inxkd_list{1,1} = 'Data\Ephys\2016-08-25';
inxkd_list{1,2} = '2016-08-25-fly1-LFPcell1-001.mat';
inxkd_list{2,1} = 'Data\Ephys\2016-08-25';
inxkd_list{2,2} = '2016-08-25-fly2-LFPcell1-001.mat';
inxkd_list{3,1} = 'Data\Ephys\2016-08-28';
inxkd_list{3,2} = '2016-08-28-fly1-LFPcell1-001.mat';
inxkd_list{4,1} = 'Data\Ephys\2016-08-31';
inxkd_list{4,2} = '2016-08-31-fly1-LFPcell1-001.mat';
inxkd_list{5,1} = 'Data\Ephys\2016-08-31';
inxkd_list{5,2} = '2016-08-31-fly2-LFPcell1-001.mat';
inxkd_list{6,1} = 'Data\Ephys\2016-09-01';
inxkd_list{6,2} = '2016-09-01-fly1-LFPcell1-006.mat';

for bb = 1:6

% Select current directory
cd(root_directory)
dirname = raster_list{bb,1};
cd(dirname);

% Load file
filename = raster_list{bb,2};
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

%% Generate 1000ms trace

% 1000ms x-axis
handle_fig = figure('Color','white');
set(handle_fig, 'Position', [100 750 800 200])

% Plot raw traces of all pulses
stim_voltage_flicker_1000_graph = stim_voltage_flicker_1000';
plot(c001_Time_1000,stim_voltage_flicker_1000_graph,'k');
hold on
plot(c001_Time_1000,stim_voltage_mean_1000,'LineWidth',2.5,'Color','y');
    
% Subplot formatting
ylabel('Vm (mV)','FontSize',12);
% xlabel('Time (ms)','FontSize',12);
xlim([0 1000]);
%ylim([-15 0]);
set(gca,'TickDir','out')

end


for cc = 1:6

% Select current directory
cd(root_directory)
dirname = inxkd_list{cc,1};
cd(dirname);

% Load file
filename = inxkd_list{cc,2};
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

%% Generate 1000ms trace

% 1000ms x-axis
handle_fig = figure('Color','white');
set(handle_fig, 'Position', [1000 750 800 200])

% Plot raw traces of all pulses
stim_voltage_flicker_1000_graph = stim_voltage_flicker_1000';
plot(c001_Time_1000,stim_voltage_flicker_1000_graph,'k');
hold on
plot(c001_Time_1000,stim_voltage_mean_1000,'LineWidth',2.5,'Color','y');
    
% Subplot formatting
ylabel('Vm (mV)','FontSize',12);
% xlabel('Time (ms)','FontSize',12);
xlim([0 1000]);
%ylim([-15 0]);
set(gca,'TickDir','out')

end

