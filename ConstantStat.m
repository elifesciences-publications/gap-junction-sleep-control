% This script calculates the average membrane potential during baseline, 
% stimulation, and the recovery section of the constant light stimulation
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

%% Directories and filenames

noChR_list{1,1} = 'Data\Ephys\2015-07-23';
noChR_list{1,2} = '2015-07-23-fly1-LFPcell-002.mat';
noChR_list{2,1} = 'Data\Ephys\2015-07-23';
noChR_list{2,2} = '2015-07-23-fly2-LFPcell-002.mat';
noChR_list{3,1} = 'Data\Ephys\2015-07-24';
noChR_list{3,2} = '2015-07-24-fly1-LFPcell-002.mat';
noChR_list{4,1} = 'Data\Ephys\2015-08-27';
noChR_list{4,2} = '2015-08-27-fly1-LFPcell-002.mat';
noChR_list{5,1} = 'Data\Ephys\2015-04-28';
noChR_list{5,2} = '2015-04-28-fly1-cell1-001.mat';
noChR_list{6,1} = 'Data\Ephys\2015-04-29';
noChR_list{6,2} = '2015-04-29-fly1-cell1-001.mat';

ChR_list{1,1} = 'Data\Ephys\2015-04-09';
ChR_list{1,2} = '2015-04-09-fly1-cell1-002.mat';
ChR_list{2,1} = 'Data\Ephys\2015-04-10';
ChR_list{2,2} = '2015-04-10-fly1-cell1-002.mat';
ChR_list{3,1} = 'Data\Ephys\2015-04-10';
ChR_list{3,2} = '2015-04-10-fly1-cell2-001.mat';
ChR_list{4,1} = 'Data\Ephys\2015-04-30';
ChR_list{4,2} = '2015-04-30-fly1-cell1-001.mat';
ChR_list{5,1} = 'Data\Ephys\2015-05-07';
ChR_list{5,2} = '2015-05-07-fly1-cell1-009.mat';
ChR_list{6,1} = 'Data\Ephys\2015-05-11';
ChR_list{6,2} = '2015-05-11-fly1-cell1-001.mat';
ChR_list{7,1} = 'Data\Ephys\2015-05-12';
ChR_list{7,2} = '2015-05-12-fly1-cell1-003.mat';
ChR_list{8,1} = 'Data\Ephys\2015-05-12';
ChR_list{8,2} = '2015-05-12-fly2-cell1-004.mat';
ChR_list{9,1} = 'Data\Ephys\2015-06-11';
ChR_list{9,2} = '2015-06-11-fly1-LFPcell1-002.mat';
ChR_list{10,1} = 'Data\Ephys\2015-06-18';
ChR_list{10,2} = '2015-06-18-fly1-cell1-002.mat';
ChR_list{11,1} = 'Data\Ephys\2015-06-30';
ChR_list{11,2} = '2015-06-30-fly1-LFPcell-002.mat';
ChR_list{12,1} = 'Data\Ephys\2015-07-09';
ChR_list{12,2} = '2015-07-09-fly1-LFPcell-002.mat';
ChR_list{13,1} = 'Data\Ephys\2015-07-29';
ChR_list{13,2} = '2015-07-29-fly1-LFPcell-003.mat';
ChR_list{14,1} = 'Data\Ephys\2015-08-14';
ChR_list{14,2} = '2015-08-14-fly1-LFPcell-002.mat';
ChR_list{15,1} = 'Data\Ephys\2015-09-02';
ChR_list{15,2} = '2015-09-02-fly1-LFPcell-002.mat';
ChR_list{16,1} = 'Data\Ephys\2015-09-08';
ChR_list{16,2} = '2015-09-08-fly1-LFPcell-002.mat';

inxkd_list{1,1} = 'Data\Ephys\2016-08-25';
inxkd_list{1,2} = '2016-08-25-fly1-LFPcell1-002.mat';
inxkd_list{2,1} = 'Data\Ephys\2016-08-25';
inxkd_list{2,2} = '2016-08-25-fly2-LFPcell1-002.mat';
inxkd_list{3,1} = 'Data\Ephys\2016-08-28';
inxkd_list{3,2} = '2016-08-28-fly1-LFPcell1-002.mat';
inxkd_list{4,1} = 'Data\Ephys\2016-08-31';
inxkd_list{4,2} = '2016-08-31-fly1-LFPcell1-002.mat';
inxkd_list{5,1} = 'Data\Ephys\2016-08-31';
inxkd_list{5,2} = '2016-08-31-fly2-LFPcell1-002.mat';
inxkd_list{6,1} = 'Data\Ephys\2016-09-01';
inxkd_list{6,2} = '2016-09-01-fly1-LFPcell1-008.mat';

%% noChR

for aa =1:6

% Select current directory
cd(root_directory)
dirname = noChR_list{aa,1};
cd(dirname);

% Load file
filename = noChR_list{aa,2};
load(filename);

% Convert unit V to mV
c002_Voltage = c002_Voltage*1000;

%% Calculate average membrane potential

% Calculate mean membrane potential for first 1min of recording
mean_baseline_Vm = nanmean(c002_Voltage(1:600000));

% Calculate mean membrane potential for first 1min of activation
mean_activation_Vm = nanmean(c002_Voltage(1200001:1800000));

% Calculate mean membrane potential for last 1min of recording
mean_recovery_Vm = nanmean(c002_Voltage(2400001:3000000));

% Put in a prism-friendly variable
prism_mean_1min(aa,1) = mean_baseline_Vm; %#ok<SAGROW>
prism_mean_1min(aa,2) = mean_activation_Vm; %#ok<SAGROW>
prism_mean_1min(aa,3) = mean_recovery_Vm; %#ok<SAGROW>

end

% Normalise dataset and store as a new variable
mean_baseline = nanmean(prism_mean_1min(:,1));
prism_norm_noChR = prism_mean_1min-mean_baseline;

clearvars mean_baseline prism_mean_1min

%% ChR

for aa =1:16

% Select current directory
cd(root_directory)
dirname = ChR_list{aa,1};
cd(dirname);

% Load file
filename = ChR_list{aa,2};
load(filename);

% Convert unit V to mV
c002_Voltage = c002_Voltage*1000;

%% Calculate average membrane potential

% Calculate mean membrane potential for first 1min of recording
mean_baseline_Vm = nanmean(c002_Voltage(1:600000));

% Calculate mean membrane potential for first 1min of activation
mean_activation_Vm = nanmean(c002_Voltage(1200001:1800000));

% Calculate mean membrane potential for last 1min of recording
mean_recovery_Vm = nanmean(c002_Voltage(2400001:3000000));

% Put in a prism-friendly variable
prism_mean_1min(aa,1) = mean_baseline_Vm; %#ok<SAGROW>
prism_mean_1min(aa,2) = mean_activation_Vm; %#ok<SAGROW>
prism_mean_1min(aa,3) = mean_recovery_Vm; %#ok<SAGROW>

end

% Normalise dataset and store as a new variable
mean_baseline = nanmean(prism_mean_1min(:,1));
prism_norm_ChR = prism_mean_1min-mean_baseline;

clearvars mean_baseline prism_mean_1min

%% INX6 RNAi

for aa =1:6

% Select current directory
cd(root_directory)
dirname = inxkd_list{aa,1};
cd(dirname);

% Load file
filename = inxkd_list{aa,2};
load(filename);

% Convert unit V to mV
c002_Voltage = c002_Voltage*1000;

%% Calculate average membrane potential

% Calculate mean membrane potential for first 1min of recording
mean_baseline_Vm = nanmean(c002_Voltage(1:600000));

% Calculate mean membrane potential for first 1min of activation
mean_activation_Vm = nanmean(c002_Voltage(1200001:1800000));

% Calculate mean membrane potential for last 1min of recording
mean_recovery_Vm = nanmean(c002_Voltage(2400001:3000000));

% Put in a prism-friendly variable
prism_mean_1min(aa,1) = mean_baseline_Vm; %#ok<SAGROW>
prism_mean_1min(aa,2) = mean_activation_Vm; %#ok<SAGROW>
prism_mean_1min(aa,3) = mean_recovery_Vm; %#ok<SAGROW>

end

% Normalise dataset and store as a new variable
mean_baseline = nanmean(prism_mean_1min(:,1));
prism_norm_inxkd = prism_mean_1min-mean_baseline;
