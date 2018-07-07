% This script produce sample membrane potential (Vm) traces for used in the 
% figures. Figures were later exported as vector graphics for addition of other 
% layers such as light stimulus final adjustments in Adobe Illustrator
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

%% Fig 3B right

% Prepare figure
handle_fig = figure('Color','white');
set(handle_fig, 'Position', [20 60 400 900])

% Subplot 1
subplot(4,1,1)
hold on

    % Specify directory and filename
    directory = 'Data\Ephys\2015-04-09\';
    filename = '2015-04-09-fly1-cell1-002.mat';

    % Set current directory and load file
    cd(directory);
    load(filename);

    % Extract membrane potential channel
    mp = c002_Voltage;

    % Trim to only 1sec long
    mp_1sec = mp(370001:380000);

    % Plot 1sec trace
    plot(mp_1sec,'LineWidth',2,'Color','k');

    % Plot scale bar
    plot([8000; 8000], [-0.03; -0.02], '-k',  [8000; 10000], [-0.03; -0.03], '-k', 'LineWidth', 2);
    % scale bar: 10mV 2s

    % Plot formatting
    set(gca,'TickDir','out')
    ylim([-0.05 -0.02]) %30mV range
    set(gca, 'Visible', 'off')

% Subplot 2
subplot(4,1,2)
hold on

    % Specify directory and filename
    cd(root_directory)
    directory = 'Data\Ephys\2015-07-23\';
    filename = '2015-07-23-fly1-LFPcell-002.mat';

    % Set current directory and load file
    cd(directory);
    load(filename);

    % Extract membrane potential channel
    mp = c002_Voltage;

    % Trim to only 1sec long
    mp_1sec = mp(2950001:2960000);

    % Plot 1sec trace
    plot(mp_1sec,'LineWidth',2,'Color','k');

    % Plot formatting
    set(gca,'TickDir','out')
    ylim([-0.055 -0.025]) % 30mV range
    set(gca, 'Visible', 'off')
    
% Subplot 3
subplot(4,1,3)
hold on

    % Specify directory and filename
    cd(root_directory)
    directory = 'Data\Ephys\2015-04-08\';
    filename = '2015-04-08-fly1-cell2-001.mat';

    % Set current directory and load file
    cd(directory);
    load(filename);

    % Extract membrane potential channel
    mp = c002_Voltage;

    % Trim to only 1sec long
    mp_1sec = mp(250001:260000);

    % Plot 1sec trace
    plot(mp_1sec,'LineWidth',2,'Color','k');

    % Plot formatting
    set(gca,'TickDir','out')
    ylim([-0.035 -0.005]) % 30mV range
    set(gca, 'Visible', 'off')
    
% Subplot 4
subplot(4,1,4)
hold on

    % Specify directory and filename
    cd(root_directory)
    directory = 'Data\Ephys\2015-05-11\';
    filename = '2015-05-11-fly1-cell1-001.mat';

    % Set current directory and load file
    cd(directory);
    load(filename);

    % Extract membrane potential channel
    mp = c002_Voltage;

    % Trim to only 1sec long
    mp_1sec = mp(280001:290000);

    % Plot 1sec trace
    plot(mp_1sec,'LineWidth',2,'Color','k');

    % Plot formatting
    set(gca,'TickDir','out')
    ylim([-0.06 -0.03]) % 30mV range
    set(gca, 'Visible', 'off')

%% Fig 3B left

% Prepare figure
handle_fig = figure('Color','white');
set(handle_fig, 'Position', [20 60 600 800])

% Subplot 1
subplot(2,1,1)
hold on

    % Specify directory and filename
    cd(root_directory)
    directory = 'Data\Ephys\';
    filename = 'ICStepPulse10pA.mat';
    
    % Set current directory and load file
    cd(directory);
    load(filename);
    
    % Plot current step pulses stimulus
    plot(c001_Time,c009_Command_Output,'DisplayName','c009_Voltage','LineWidth',2.5);
    hold all;
    plot(c001_Time,c012_Command_Output,'DisplayName','c012_Voltage','LineWidth',2.5);
    plot(c001_Time,c015_Command_Output,'DisplayName','c015_Voltage','LineWidth',2.5);
    plot(c001_Time,c018_Command_Output,'DisplayName','c018_Voltage','LineWidth',2.5);
    plot(c001_Time,c021_Command_Output,'DisplayName','c021_Voltage','LineWidth',2.5);
    hold off;
    set(gca,'TickDir','out')

% Subplot 2
subplot(2,1,2)
hold on
    
    % Specify directory and filename (Chrimson/23E10/INX)
    cd(root_directory)
    directory = 'Data\Ephys\2016-08-31\';
    filename = '2016-08-31-fly1-LFPcell1-004.mat';
    
    % Set current directory and load file
    cd(directory);
    load(filename);

    % Plot current step pulses recording
    plot(c001_Time,c009_Voltage,'DisplayName','c009_Voltage','LineWidth',2.5);
    hold all;
    plot(c001_Time,c012_Voltage,'DisplayName','c012_Voltage','LineWidth',2.5);
    plot(c001_Time,c015_Voltage,'DisplayName','c015_Voltage','LineWidth',2.5);
    plot(c001_Time,c018_Voltage,'DisplayName','c018_Voltage','LineWidth',2.5);
    plot(c001_Time,c021_Voltage,'DisplayName','c021_Voltage','LineWidth',2.5);
    hold off;
    set(gca,'TickDir','out')
    
%% Fig 3C left

% Prepare figure
handle_fig = figure('Color','white');
set(handle_fig, 'Position', [20 60 900 900])

% Subplot 1
h1 = subplot(3,1,1);

hold on

    % Specify directory and filename
    cd(root_directory)
    directory = 'Data\Ephys\2015-04-10\';
    filename = '2015-04-10-fly1-cell1-002.mat';

    % Set current directory and load file
    cd(directory);
    load(filename);

    % Extract membrane potential channel
    mp = c002_Voltage;
    
    % Trim trace
    mp_20sec = mp(575001:650000);

    % Plot 1sec trace
    plot(mp_20sec,'LineWidth',2,'Color','k');
    
    % Plot scale bar
    plot([40000; 40000], [-0.040; -0.030], '-k',  [40000; 50000], [-0.040; -0.040], '-k', 'LineWidth', 2);
    % scale bar: 10mV 1s
    
    % Plot formatting
    set(gca,'TickDir','out')
    ylim([-0.04 0]) %30mV range
    xlim([0 75000])
    set(gca, 'Visible', 'off')

% Subplot 2
h2 = subplot(3,1,2);
hold on

    % Specify directory and filename
    cd(root_directory)
    directory = 'Data\Ephys\2015-05-12\';
    filename = '2015-05-12-fly1-cell1-003.mat';

    % Set current directory and load file
    cd(directory);
    load(filename);

    % Extract membrane potential channel
    mp = c002_Voltage;

    % Trim trace
    mp_20sec = mp(575001:650000);

    % Plot 1sec trace
    plot(mp_20sec,'LineWidth',2,'Color','k');
    
    % Plot formatting
    set(gca,'TickDir','out')
    ylim([-0.04 0]) %30mV range
    xlim([0 75000])
    set(gca, 'Visible', 'off')
    
% Subplot 3
h3 = subplot(3,1,3);
hold on

    % Specify directory and filename
    cd(root_directory)
    directory = 'Data\Ephys\2015-07-23\';
    filename = '2015-07-23-fly1-LFPcell-002.mat';

    % Set current directory and load file
    cd(directory);
    load(filename);

    % Extract membrane potential channel
    mp = c002_Voltage;
    
    % Trim trace
    mp_20sec = mp(575001:650000);

    % Plot 1sec trace
    plot(mp_20sec,'LineWidth',2,'Color','k');

    % Plot formatting
    set(gca,'TickDir','out')
    ylim([-0.065 -0.025]) %30mV range
    xlim([0 75000])
    set(gca, 'Visible', 'off')

%% Fig 3.supp1A left  

% Prepare figure
handle_fig = figure('Color','white');
set(handle_fig, 'Position', [20 60 900 900])

% Subplot 1
subplot(3,1,1)
hold on
    
    % Specify directory and filename
    cd(root_directory)
    directory = 'Data\Ephys\2015-04-30\';
    filename = '2015-04-30-fly1-cell1-010.mat';

    % Set current directory and load file
    cd(directory);
    load(filename);

    % Extract membrane potential channel
    mp = c002_Voltage;

    % Trim trace
    mp_20sec = mp(575001:650000);

    % Plot 1sec trace
    plot(mp_20sec,'LineWidth',2,'Color','k');

    % Plot formatting
    set(gca,'TickDir','out')
    ylim([-0.015 0.005]) %20mV range
    xlim([0 75000])
    set(gca, 'Visible', 'off')

% Subplot 2
subplot(3,1,2)
hold on
    
    % Specify directory and filename
    cd(root_directory)
    directory = 'Data\Ephys\2015-07-09\';
    filename = '2015-07-09-fly1-LFPcell-001.mat';

    % Set current directory and load file
    cd(directory);
    load(filename);

    % Extract membrane potential channel
    mp = c002_Voltage;

    % Trim trace
    mp_20sec = mp(575001:650000);

    % Plot 1sec trace
    plot(mp_20sec,'LineWidth',2,'Color','k');
    
    % Plot scale bar
    plot([10000; 10000], [-0.032; -0.027], '-k',  [10000; 20000], [-0.032; -0.032], '-k', 'LineWidth', 2);
    % scale bar: 5mV 1s

    % Plot formatting
    set(gca,'TickDir','out')
    ylim([-0.045 -0.025]) %20mV range
    xlim([0 75000])
    set(gca, 'Visible', 'off')

% Subplot 3
subplot(3,1,3)
hold on
    
    % Specify directory and filename
    cd(root_directory)
    directory = 'Data\Ephys\2015-07-24\';
    filename = '2015-07-24-fly1-LFPcell-001.mat';

    % Set current directory and load file
    cd(directory);
    load(filename);

    % Extract membrane potential channel
    mp = c002_Voltage;

    % Trim trace
    mp_20sec = mp(575001:650000);

    % Plot 1sec trace
    plot(mp_20sec,'LineWidth',2,'Color','k');

    % Plot formatting
    set(gca,'TickDir','out')
    ylim([-0.045 -0.025]) %20mV range
    xlim([0 75000])
    set(gca, 'Visible', 'off')

%% Fig 6C left

% Prepare figure
handle_fig = figure('Color','white');
set(handle_fig, 'Position', [20 60 900 600])

% Subplot 1
subplot(2,1,1)
hold on
    
    % Specify directory and filename
    cd(root_directory)
    directory = 'Data\Ephys\2016-08-31';
    filename = '2016-08-31-fly1-LFPcell1-002.mat';

    % Set current directory and load file
    cd(directory);
    load(filename);

    % Extract membrane potential channel
    mp = c005_LFP;

    % Trim trace
    mp_20sec = mp(550001:650000);

    % Plot 1sec trace
    plot(mp_20sec,'LineWidth',1,'Color','k');
    
    % Plot scale bar
    plot([90000; 90000], [0.000003; 0.000002], '-k',  [90000; 100000], [0.000002; 0.000002], '-k', 'LineWidth', 2);
    % scale bar: 5uV 1s    
    
    % Plot formatting
    set(gca,'TickDir','out')
    % ylim([-0.015 0.005]) %20mV range
    xlim([0 100000])
    set(gca, 'Visible', 'off')

% Subplot 2
subplot(2,1,2)
hold on
    
    % Specify directory and filename
    cd(root_directory)
    directory = 'Data\Ephys\2016-08-31';
    filename = '2016-08-31-fly1-LFPcell1-002.mat';

    % Set current directory and load file
    cd(directory);
    load(filename);

    % Extract membrane potential channel
    mp = c002_Voltage;

    % Trim trace
    mp_20sec = mp(550001:650000);

    % Plot 1sec trace
    plot(mp_20sec,'LineWidth',1,'Color','k');
    
    % Plot scale bar
    plot([90000; 90000], [0; -0.005], '-k',  [90000; 100000], [-0.005; -0.005], '-k', 'LineWidth', 2);
    % scale bar: 5mV 1s

    % Plot formatting
    set(gca,'TickDir','out')
    % ylim([-0.045 -0.025]) %20mV range
    xlim([0 100000])
    set(gca, 'Visible', 'off')

%% Fig 6D left

% Prepare figure
handle_fig = figure('Color','white');
set(handle_fig, 'Position', [20 60 900 600])

% Subplot 1
subplot(2,1,1)
hold on
    
    % Specify directory and filename
    cd(root_directory)
    directory = 'Data\Ephys\2016-08-31';
    filename = '2016-08-31-fly1-LFPcell1-001.mat';

    % Set current directory and load file
    cd(directory);
    load(filename);

    % Extract membrane potential channel
    mp = c005_LFP;

    % Trim trace
    mp_20sec = mp(550001:650000);

    % Plot 1sec trace
    plot(mp_20sec,'LineWidth',1,'Color','k');

    % Plot scale bar
    plot([90000; 90000], [0.000003; 0.000002], '-k',  [90000; 100000], [0.000002; 0.000002], '-k', 'LineWidth', 2);
    % scale bar: 5uV 1s    
    
    % Plot formatting
    set(gca,'TickDir','out')
    % ylim([-0.015 0.005]) %20mV range
    xlim([0 100000])
    set(gca, 'Visible', 'off')

% Subplot 2
subplot(2,1,2)
hold on
    
    % Specify directory and filename
    cd(root_directory)
    directory = 'Data\Ephys\2016-08-31';
    filename = '2016-08-31-fly1-LFPcell1-001.mat';

    % Set current directory and load file
    cd(directory);
    load(filename);

    % Extract membrane potential channel
    mp = c002_Voltage;

    % Trim trace
    mp_20sec = mp(550001:650000);

    % Plot 1sec trace
    plot(mp_20sec,'LineWidth',1,'Color','k');
    
    % Plot scale bar
    plot([90000; 90000], [0; -0.005], '-k',  [90000; 100000], [-0.005; -0.005], '-k', 'LineWidth', 2);
    % scale bar: 5mV 1s

    % Plot formatting
    set(gca,'TickDir','out')
    % ylim([-0.045 -0.025]) %20mV range
    xlim([0 100000])
    set(gca, 'Visible', 'off')
