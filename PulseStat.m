% This script calculates the average membrane potential during baseline, 
% stimulation, and the recovery section of the 1Hz light pulse stimulation
% experiments. The output variable prism_norm_noChR, prism_norm_ChR,
% and prism_norm_inxkd were exported to prism to generate box plots.
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

noChR_list{1,1} = 'Data\Ephys\2015-07-23';
noChR_list{1,2} = '2015-07-23-fly1-LFPcell-001.mat';
noChR_list{2,1} = 'Data\Ephys\2015-07-23';
noChR_list{2,2} = '2015-07-23-fly2-LFPcell-001.mat';
noChR_list{3,1} = 'Data\Ephys\2015-07-24';
noChR_list{3,2} = '2015-07-24-fly1-LFPcell-001.mat';
noChR_list{4,1} = 'Data\Ephys\2015-08-27';
noChR_list{4,2} = '2015-08-27-fly1-LFPcell-001.mat';

ChR_list{1,1} = 'Data\Ephys\2015-04-30';
ChR_list{1,2} = '2015-04-30-fly1-cell1-010.mat';
ChR_list{2,1} = 'Data\Ephys\2015-05-07';
ChR_list{2,2} = '2015-05-07-fly1-cell1-002.mat';
ChR_list{3,1} = 'Data\Ephys\2015-05-11';
ChR_list{3,2} = '2015-05-11-fly1-cell1-003.mat';
ChR_list{4,1} = 'Data\Ephys\2015-05-12';
ChR_list{4,2} = '2015-05-12-fly1-cell1-001.mat';
ChR_list{5,1} = 'Data\Ephys\2015-05-12';
ChR_list{5,2} = '2015-05-12-fly2-cell1-002.mat';
ChR_list{6,1} = 'Data\Ephys\2015-06-11';
ChR_list{6,2} = '2015-06-11-fly1-LFPcell1-001.mat';
ChR_list{7,1} = 'Data\Ephys\2015-06-18';
ChR_list{7,2} = '2015-06-18-fly1-cell1-005.mat';
ChR_list{8,1} = 'Data\Ephys\2015-06-30';
ChR_list{8,2} = '2015-06-30-fly1-LFPcell-001.mat';
ChR_list{9,1} = 'Data\Ephys\2015-07-09';
ChR_list{9,2} = '2015-07-09-fly1-LFPcell-001.mat';
ChR_list{10,1} = 'Data\Ephys\2015-07-29';
ChR_list{10,2} = '2015-07-29-fly1-LFPcell-004.mat';
ChR_list{11,1} = 'Data\Ephys\2015-08-14';
ChR_list{11,2} = '2015-08-14-fly1-LFPcell-001.mat';
ChR_list{12,1} = 'Data\Ephys\2015-09-02';
ChR_list{12,2} = '2015-09-02-fly1-LFPcell-001.mat';
ChR_list{13,1} = 'Data\Ephys\2015-09-08';
ChR_list{13,2} = '2015-09-08-fly1-LFPcell-001.mat';

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

%% noChR

for bb =1:4

% Select current directory
cd(root_directory)
dirname = noChR_list{bb,1};
cd(dirname);

% Load file
filename = noChR_list{bb,2};
load(filename);

% Convert unit V to mV
c002_Voltage = c002_Voltage*1000;

%% Calculate average membrane potential

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

% Get data for first 1min of recording (baseline)
stim_voltage_baseline_1min = c002_Voltage(1:600000);

% Calculate mean membrane potential for first 1min of recording
mean_baseline_Vm = nanmean(stim_voltage_baseline_1min);

% Get data for last 1 min of recording (recovery)
stim_voltage_recovery_1min = c002_Voltage(2400001:3000000);

% Calculate mean membrane potential for first 1min of recording
mean_recovery_Vm = nanmean(stim_voltage_recovery_1min);

% Get data for first 100ms
stim_voltage_mean_100 = stim_voltage_mean_1000(1:1000);

% Calculate mean membrane potential for first 50ms of stimulus
mean_100ms_Vm = nanmean(stim_voltage_mean_100);

% Put in a prism-friendly variable
prism_mean_100ms(bb,1) = mean_baseline_Vm; %#ok<SAGROW>
prism_mean_100ms(bb,2) = mean_100ms_Vm; %#ok<SAGROW>
prism_mean_100ms(bb,3) = mean_recovery_Vm; %#ok<SAGROW>

end

% Normalise dataset and store as a new variable
mean_baseline = nanmean(prism_mean_100ms(:,1));
prism_norm_noChR = prism_mean_100ms-mean_baseline;

clearvars mean_baseline prism_mean_100ms mean_baseline_Vm mean_100ms_Vm mean_recovery_Vm stim_voltage_mean_100 stim_voltage_mean_1000 stim_voltage_recovery_1min stim_voltage_baseline_1min stim_voltage_flicker_1000 stim_voltage

%% ChR

for bb =1:13

% Select current directory
cd(root_directory)
dirname = ChR_list{bb,1};
cd(dirname);

% Load file
filename = ChR_list{bb,2};
load(filename);

% Convert unit V to mV
c002_Voltage = c002_Voltage*1000;

%% Calculate average membrane potential

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

% Get data for first 1min of recording (baseline)
stim_voltage_baseline_1min = c002_Voltage(1:600000);

% Calculate mean membrane potential for first 1min of recording
mean_baseline_Vm = nanmean(stim_voltage_baseline_1min);

% Get data for last 1 min of recording (recovery)
stim_voltage_recovery_1min = c002_Voltage(2400001:3000000);

% Calculate mean membrane potential for first 1min of recording
mean_recovery_Vm = nanmean(stim_voltage_recovery_1min);

% Get data for first 100ms
stim_voltage_mean_100 = stim_voltage_mean_1000(1:1000);

% Calculate mean membrane potential for first 50ms of stimulus
mean_100ms_Vm = nanmean(stim_voltage_mean_100);

% Put in a prism-friendly variable
prism_mean_100ms(bb,1) = mean_baseline_Vm; %#ok<SAGROW>
prism_mean_100ms(bb,2) = mean_100ms_Vm; %#ok<SAGROW>
prism_mean_100ms(bb,3) = mean_recovery_Vm; %#ok<SAGROW>

end

% Normalise dataset and store as a new variable
mean_baseline = nanmean(prism_mean_100ms(:,1));
prism_norm_ChR = prism_mean_100ms-mean_baseline;

clearvars mean_baseline prism_mean_100ms mean_baseline_Vm mean_100ms_Vm mean_recovery_Vm stim_voltage_mean_100 stim_voltage_mean_1000 stim_voltage_recovery_1min stim_voltage_baseline_1min stim_voltage_flicker_1000 stim_voltage

%% INX6 RNAi

for bb =1:6

% Select current directory
cd(root_directory)
dirname = inxkd_list{bb,1};
cd(dirname);

% Load file
filename = inxkd_list{bb,2};
load(filename);

% Convert unit V to mV
c002_Voltage = c002_Voltage*1000;

%% Calculate average membrane potential

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

% Get data for first 1min of recording (baseline)
stim_voltage_baseline_1min = c002_Voltage(1:600000);

% Calculate mean membrane potential for first 1min of recording
mean_baseline_Vm = nanmean(stim_voltage_baseline_1min);

% Get data for last 1 min of recording (recovery)
stim_voltage_recovery_1min = c002_Voltage(2400001:3000000);

% Calculate mean membrane potential for first 1min of recording
mean_recovery_Vm = nanmean(stim_voltage_recovery_1min);

% Get data for first 100ms
stim_voltage_mean_100 = stim_voltage_mean_1000(1:1000);

% Calculate mean membrane potential for first 50ms of stimulus
mean_100ms_Vm = nanmean(stim_voltage_mean_100);

% Put in a prism-friendly variable
prism_mean_100ms(bb,1) = mean_baseline_Vm; %#ok<SAGROW>
prism_mean_100ms(bb,2) = mean_100ms_Vm; %#ok<SAGROW>
prism_mean_100ms(bb,3) = mean_recovery_Vm; %#ok<SAGROW>

end

% Normalise dataset and store as a new variable
mean_baseline = nanmean(prism_mean_100ms(:,1));
prism_norm_inxkd = prism_mean_100ms-mean_baseline;
