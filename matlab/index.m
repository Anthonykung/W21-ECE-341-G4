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

% Arduino Nano With `matlab.ino` loaded required
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
global a;

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
freq = zeros(numSams, 1);
time = zeros(numSams, 1);
loc = 1;
a = arduino('COM5','Nano3');
arduinoObj = serialport("COM5", 115200);
configureTerminator(arduinoObj,"CR/LF");
flush(arduinoObj);
arduinoObj.UserData = struct("Data", [], "Count", 1);
configureCallback(arduinoObj, "terminator", @readArduinoData);

function readArduinoData(src, ~)

  % Let The Function Know About Global
  global sams;
  global loc;
  global numSams;

  % Create Sampling Process

  if loc == numSams
    % Read the ASCII data from the serialport object.
    % Convert the string data to numeric type and save it in sams
    sams(loc) = str2double(readline(src));

    % Update the Count value of the serialport object.
    loc = loc + 1;
  else
    % Call FFT
    % For every 128 samples
    % Sampling Frequency Set In Arduino
    fftFun(sams);

    % Reset Array
    sams = zeros;
    loc = 0;

    % Read the ASCII data from the serialport object.
    % Convert the string data to numeric type and save it in sams
    sams(end + 1) = str2double(readline(src));

    % Update the Count value of the serialport object.
    loc = loc + 1;
  end
end


function fftFun(data)
  % Let The Function Know About Global
  global freq;
  global time;

  freq(time) = fft(data);
  time(end + 1) = time(end) + 95;

  % LED
  ctrl(freq);

  % Plot
  plot(freq, time, '-x');
  title('Frequency VS Time', 'FontSize', 15);
  xlabel('Time (us)', 'FontSize', 15);
  ylabel('Frequency (Hz)', 'FontSize', 15);
end

function allOff()
  % Let The Function Know About Global
  global LED1;
  global LED2;
  global LED3;
  global LED4;
  global LED5;
  global LED6;
  global LED7;
  global LED8;

  writeDigitalPin(a, LED1, 0);
  writeDigitalPin(a, LED2, 0);
  writeDigitalPin(a, LED3, 0);
  writeDigitalPin(a, LED4, 0);
  writeDigitalPin(a, LED5, 0);
  writeDigitalPin(a, LED6, 0);
  writeDigitalPin(a, LED7, 0);
  writeDigitalPin(a, LED8, 0);
end

function onOne(num)
  allOff();
  writeDigitalPin(a, (2 + num), 1);
end

function ctrl(freq)
  if freq < 248
    allOff();
  elseif freq > 248 && freq <= 275
    % C4 261.6256
    onOne(1);
  elseif freq > 278 && freq <= 309
    % D4 293.6648
    onOne(2);
  elseif freq > 313 && freq <= 338
    % E4 329.6276
    onOne(3);
  elseif freq > 338 && freq <= 367
    % F4 349.2282
    onOne(4);
  elseif freq > 372 && freq <= 412
    % G4 391.9954
    onOne(5);
  elseif freq > 418 && freq <= 462
    % A4 440.0000
    onOne(6);
  elseif freq > 469 && freq <= 507
    % B4 493.8833
    onOne(7);
  elseif freq > 507 && freq <= 550
    % C5 523.2511
    onOne(8);
  else
    allOff();
  end
end