% Copyright (c) 2021 ECE 341 Winter 2021 Section 3 Group 4
%
% Licensed under the Apache License, Version 2.0 (the "License");
% you may not use this file except in compliance with the License.
% You may obtain a copy of the License at
%
%     https://www.apache.org/licenses/LICENSE-2.0
%
% Unless required by applicable law or agreed to in writing, software
% distributed under the License is distributed on an "AS IS" BASIS,
% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
% See the License for the specific language governing permissions and
% limitations under the License.
%
% @file   index.m
% @author Anthony Kung <hi@anth.dev>
% @date   Created on March 4 2021, 10:54 AM

% REQUIREMENTS %
% Arduino Nano With `matlab.ino` loaded required
% Signal Processing Toolbox Installed on Matlab
% Sampling Frequency Set In Arduino `sampling2()`

% Global Constants
global LED1;
global LED2;
global LED3;
global LED4;
global LED5;
global LED6;
global LED7;
global LED8;
global numSams;

% Global Variables
global sams;
global freq;
global time;
global loc;
global arduinoObj;
global timeI;
global samFreq;

% Initialize
clear
clc
LED1 = 3;
LED2 = 4;
LED3 = 5;
LED4 = 6;
LED5 = 7;
LED6 = 8;
LED7 = 9;
LED8 = 10;
numSams = 128;
sams = zeros(numSams, 1);
freq = zeros(1000000, 1);
time = zeros(1000000, 1);
timeI = 1;
samFreq = 10500; % Sampling Frequency @ 10.5 kHz
loc = 1;
arduinoObj = serialport("COM5", 115200);        % CHANGE YOUR COM PORT %
configureTerminator(arduinoObj, "CR/LF");
flush(arduinoObj);
arduinoObj.UserData = struct("Data", [], "Count", 1);

while 1 == 1
  % Create Sampling Process

  if loc ~= numSams
    % Read the ASCII data from the serialport object.
    % Convert the string data to numeric type and save it in sams
    data = str2double(readline(arduinoObj));
    sams(loc) = data;

    % Update the Count value of the serialport object.
    loc = loc + 1;

    % Print Data
    fprintf('Data: ');
    disp(data);
  else
    % Call FFT
    % For every 128 samples
    % Sampling Frequency Set In Arduino
    %fftFun(sams, arduinoObj, freq, time, timeI);
    % Get FFT
    Y = fft(sams);
    forSNR = abs(Y);
    freqs = 0:10500/128:10500/2;
    freqs = freqs';
    Y = Y(1:128/2+1);
    res = abs(Y);
    Y(1) = [];
    [amp fI] = max(abs(Y));
    val = freqs(fI);
    freq(timeI) = val;

    % Print Frequency
    fprintf('Frequency: ');
    disp(val);

    % SNR
    SNR = snr(forSNR, sams);
    fprintf('SNR: ');
    disp(SNR);

    % Data
    subplot(3, 1, 1);
    plot(sams);
    title('Data', 'FontSize', 15);
    xlabel('Index', 'FontSize', 15);
    ylabel('Data', 'FontSize', 15);

    % FFT
    subplot(3, 1, 2);
    plot(freqs, res);
    title('Amplitude VS Frequency', 'FontSize', 15);
    xlabel('Frequency (Hz)', 'FontSize', 15);
    ylabel('Amplitude', 'FontSize', 15);

    % LED
    write(arduinoObj, val, "double");

    % Update Index
    curry = timeI * 95;
    curryI = timeI;
    curryI = curryI + 1;
    time(timeI + 1) = curry;
    timeI = timeI + 1;

    % Plot
    subplot(3, 1, 3);
    plot(time, freq);
    title('Frequency VS Time', 'FontSize', 15);
    xlabel('Time (us)', 'FontSize', 15);
    ylabel('Frequency (Hz)', 'FontSize', 15);

    % Reset Array
    sams = zeros;
    loc = 1;

    % Read the ASCII data from the serialport object.
    % Convert the string data to numeric type and save it in sams
    sams(loc) = str2double(readline(arduinoObj));

    % Update the Count value of the serialport object.
    loc = loc + 1;
  end
end

function fftFun(data, arduinoObj, freq, time, timeI)
  % Get FFT
  Y = fft(data);
  forSNR = abs(Y);
  freqs = 0:10500/128:10500/2;
  freqs = freqs';
  Y = Y(1:128/2+1);
  res = abs(Y);
  Y(1) = [];
  [amp fI] = max(abs(Y));
  val = freqs(fI);
  freq(timeI) = val;

  % Print Frequency
  fprintf('Frequency: ');
  disp(val);

  % SNR
  SNR = snr(forSNR, data);
  fprintf('SNR: ');
  disp(SNR);

  % Data
  subplot(3, 1, 1);
  plot(data);
  title('Data', 'FontSize', 15);
  xlabel('Index', 'FontSize', 15);
  ylabel('Data', 'FontSize', 15);

  % FFT
  subplot(3, 1, 2);
  plot(freqs, res);
  title('Amplitude VS Frequency', 'FontSize', 15);
  xlabel('Frequency (Hz)', 'FontSize', 15);
  ylabel('Amplitude', 'FontSize', 15);

  % LED
  write(arduinoObj, val, "double");

  % Update Index
  curry = timeI * 95;
  curryI = timeI;
  curryI = curryI + 1;
  time(timeI + 1) = curry;
  timeI = timeI + 1;

  % Plot
  subplot(3, 1, 3);
  plot(freq, time);
  title('Frequency VS Time', 'FontSize', 15);
  xlabel('Time (us)', 'FontSize', 15);
  ylabel('Frequency (Hz)', 'FontSize', 15);
end

function allOff()
  write(arduinoObj, 0, "int");
end

function onOne(num)
  allOff();
  % writeDigitalPin(a, (2 + num), 1);
  writeToArduino(num);
end

function ctrl(freq)
  if freq < 248
    allOff();
  elseif (freq > 248) && (freq <= 275)
    % C4 261.6256
    onOne(1);
  elseif (freq > 278) && (freq <= 309)
    % D4 293.6648
    onOne(2);
  elseif (freq > 313) && (freq <= 338)
    % E4 329.6276
    onOne(3);
  elseif (freq > 338) && (freq <= 367)
    % F4 349.2282
    onOne(4);
  elseif (freq > 372) && (freq <= 412)
    % G4 391.9954
    onOne(5);
  elseif (freq > 418) && (freq <= 462)
    % A4 440.0000
    onOne(6);
  elseif (freq > 469) && (freq <= 507)
    % B4 493.8833
    onOne(7);
  elseif (freq > 507) && (freq <= 550)
    % C5 523.2511
    onOne(8);
  else
    allOff();
  end
end

function writeToArduino(num)
  global arduinoObj;
  write(arduinoObj, num, "int");
end

function killFun()
  error('Terminating');
end