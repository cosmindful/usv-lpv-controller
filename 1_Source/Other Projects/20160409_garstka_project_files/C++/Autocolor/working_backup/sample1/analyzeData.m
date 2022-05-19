% Michael garstka
clear all
close all
%% Initialize variables.
filename = 'E:\Eigene Dateien\Visual Studio 2012\Projects\sample1\sample1\data.txt';
delimiter = ' ';
startRow = 2;

formatSpec = '%f%f%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);

%% Close the text file.
fclose(fileID);


%% Allocate imported array to column variable names
x = dataArray{:, 1};
y = dataArray{:, 2};
t = dataArray{:, 3};

%% Clear temporary variables
clearvars filename delimiter startRow formatSpec fileID dataArray ans;
data = importdata('data.txt',' ',0);

figure(1);
subplot(2,1,1);
plot(t,x);
title('x(t)'); xlabel('t[s]'), ylabel('x [px]');grid on;

subplot(2,1,2);
plot(t,y);
title('y(t)'); xlabel('t [s]'), ylabel('y [px]');grid on;
