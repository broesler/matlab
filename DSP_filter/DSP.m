%load('session.mat');
time = t;
dt = time(2)-time(1);               % Sampling interval
Fs = 1/dt;                          % Sampling rate

% F is side force, T is thrust
data = T;                           % Plug in F or T here

%% Time domain graph and filter
% Plot original data
figure(1), clf
subplot(2,1,1)
    plot(time, data)
    xlabel('time')
    title('RAW DATA')
    
% Remove high frequencies from the signal.
% Filter has 0.5 dB ripple in its passband, 60 dB stopband at 60 Hz
h = h60;
figure(2), clf
subplot(2,1,1)
    stem(0:length(h)-1, h, '.')
    grid on, axis tight
    xlabel('sample'), ylabel('h[n]')
    title('Lowpass filter impulse response')
    
Nf = 401;
subplot(2,1,2)
    [H, freq] = freqz(h, 1, Nf, 1/dt);
    plot(freq, db(abs(H), 'voltage'))
    grid on
    set(gca, 'ylim', [-80, 3])
    xlabel('Frequency (Hz)'), ylabel('dB')
    title('Frequency response')
    
dlp = filter(h, 1, data);
figure(1)
subplot(2,1,2)
    plot(time, dlp)
    xlabel('time')
    title('LOWPASS FILTERED')

%% Fourier spectra
%  Raw data
Nfft = 2^(nextpow2(length(data))+3);
df = Fs/Nfft;                       % Bin spacing
FT = fft(data, Nfft);                  % FFT, zero packed data
freq = (0:Nfft/2)*df;
figure(3)
subplot(3,1,1)
    plot(freq, db(abs(FT(1:Nfft/2+1)), 'voltage'))
    grid on
    xlabel('Frequency (Hz)')
    ylabel('Fourier magnitude')
    title('RAW DATA')
 
FTlp = fft(dlp, Nfft);
subplot(3,1,2)
    plot(freq, db(abs(FTlp(1:Nfft/2+1)), 'voltage'))
    grid on
    xlabel('Frequency (Hz)')
    ylabel('Fourier magnitude')
    title('FILTERED DATA')

range = 1:1500;
subplot(3,1,3)
   plot(freq(range), db(abs(FTlp(range)), 'voltage'))
   axis tight, grid on
   xlabel('Frequency (Hz)')
   ylabel('Fourier magnitude')
   title('DETAIL')

%% Post processing
f1 = 0.6161;                        % First peak, from the graph
t1 = 1/f1;                          % Estimated period of the data

dlp = dlp(length(h):end);           % Trim off filter transient
period_per_seg = 3;                 % #periods per segment
Nseg = round(period_per_seg * t1 / dt);    % #samples per segment

% Segment the data
Lseg = floor(length(dlp)/Nseg);
Dseg = reshape(dlp(1:Nseg*Lseg), Nseg, Lseg);
ts = time(1:Nseg);
Davg = mean(Dseg, 2);
Dtimeavg = mean(Davg);

figure(4)
subplot(2,1,1)
    plot(ts, Dseg)
    xlabel('time (s)')
    title([int2str(period_per_seg), '-PERIOD SEGMENTS'])
    grid on
    
subplot(2,1,2)
    plot(ts, Davg)
    xlabel('time (s)')
    title(['ENSEMBLE AVERAGE: TIME AVERAGE=', num2str(Dtimeavg)])
    grid on

