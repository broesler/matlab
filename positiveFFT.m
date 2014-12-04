% A Custom Function for fft to Obtain only the Positive Frequencies
% 
% from: http://blinkdagger.com/matlab/matlab-introductory-fft-tutorial
%
% The following function is a modification of the above function, and 
% will help you plot only the positive frequencies of the spectrum.
%
% % Sample usage code:
% fo = 4;   %frequency of the sine wave
% Fs = 100; %sampling rate
% Ts = 1/Fs; %sampling time interval
% t  = 0:Ts:1-Ts; %sampling period
% n  = length(t); %number of samples
% y  = 2*sin(2*pi*fo*t); %the sine curve
%  
% %plot the cosine curve in the time domain
% sinePlot = figure;
% plot(t,y)
% xlabel('time (seconds)')
% ylabel('y(t)')
% title('Sample Sine Wave')
% grid
% 
% % find the fft
% [YfreqDomain,frequencyRange] = positiveFFT(y,Fs);
% 
% % plot the fft
% positiveFFT = figure;
% stem(frequencyRange,abs(YfreqDomain));
% set(positiveFFT,'Position',[500,500,500,300])
% xlabel('Freq (Hz)')
% ylabel('Amplitude')
% title('Using the positiveFFT function')
% grid
% axis([0,20,0,1.5])
%
%
% Inputs:
%   x  = time domain signal
%   Fs = sampling rate of the signal
%
% Outputs:
%   X    = one-sided FFT of x
%   freq = frequencies used in the FFT

function [X,freq]=positiveFFT(x,Fs)

N    = length(x); % get the number of points
k    = 0:N-1;     % create a vector from 0 to N-1
T    = N/Fs;      % get the frequency interval
freq = k/T;       % create the frequency range
X    = fft(x)/N;  % normalize the data
 
%only want the first half of the FFT, since it is redundant
cutOff = ceil(N/2); 
 
%take only the first half of the spectrum
X = X(1:cutOff);
freq = freq(1:cutOff);