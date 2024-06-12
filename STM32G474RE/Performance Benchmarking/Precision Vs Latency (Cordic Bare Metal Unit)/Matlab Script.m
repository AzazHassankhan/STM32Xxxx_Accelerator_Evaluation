% Close all figures, clear workspace, and command window
close all;  % Close all open figure windows
clear all;  % Clear all variables from the workspace
clc;        % Clear the command window

% Setup and open the serial communication in Matlab
priorPorts = instrfind; % Find any existing serial port objects
delete(priorPorts);     % Delete any existing serial port objects

% Create a serial port object
STM32 = serial('COM5', 'BaudRate', 115200, 'InputBufferSize', 16388); % Specify COM port and settings
fopen(STM32); % Open the serial port

% Create and setup figures for plotting
f1 = figure; % Figure for CORDIC unit values
hold on;     % Hold on to the current plot

f2 = figure; % Figure for latency
hold on;     % Hold on to the current plot


% Initialize variables
CYCLES = 1;             % Start with the first cycle
Last_Cordic_Rx_Data = zeros(1, 4096); % Initialize last received CORDIC data
legendentries={};

% Loop until data for all cycles is received
while (CYCLES <= 15)
    % Check if the expected number of bytes is available
    if STM32.BytesAvailable == 16388
        % Read the data from the serial port
        rx_data_Cordic = fread(STM32, 4096, 'int32'); % Read CORDIC data
        rx_data_Latency = fread(STM32, 1, 'int32');  % Read latency data
        Difference = rx_data_Cordic - Last_Cordic_Rx_Data;
        

        % Plot the CORDIC data
        plot(rx_data_Cordic);
        title('CORDIC UNIT VALUES'); % Title for the plot
        xlabel('Number of Samples');
        ylabel('Amplitude');
        legendentries{end+1} = sprintf('Cycles %d', CYCLES); % Add legend entry
        legend(legendentries); % Update legend
        figure(f1); % Select the first figure

        % Plot the latency data horizontally
        barh(CYCLES, rx_data_Latency);
        text(rx_data_Latency, CYCLES, num2str(rx_data_Latency), 'VerticalAlignment', 'middle', 'HorizontalAlignment', 'right'); % Display latency value as text
        title('LATENCY OF DIFFERENT CYCLES'); % Title for the plot
        xlabel('Latency');
        ylabel('Cycles');
        figure(f2); % Select the second figure
        

        fprintf(" Transfer %i DONE \n", CYCLES); % Display transfer completion message
        % Increment the cycle count and update last received CORDIC data
        CYCLES = CYCLES + 1;
        Last_Cordic_Rx_Data = rx_data_Cordic;
        fwrite(STM32, 1, 'uint8'); % Send a signal indicating readiness for the next transfer

    end
end

% Close the serial port
fclose(STM32);
fprintf(" Script End \n"); % Display end of script message
