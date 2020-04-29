
%% Generate two Sin waves of different amplitude at 10Hz frequency and adding them
Fs = 500;
f = 10;
n = [1/Fs:1/Fs:1];
x = sin(2*pi*f*n)+sin(2*pi*f*n/5);
%plot(x);

%% Adding noise to the periodic signal
y = x + rand(1,length(x));
%plot(y);
%% Spectral analysis of the signal
L = length(y);
NFFT = 2^nextpow2(L);
y_fft = abs(fft(y,NFFT));
% creating frequency axis
freq = Fs/2*linspace(0,1,NFFT/2+1);
%plot(freq,y_fft(1:NFFT/2+1));
%% Design Filter and apply on the sound sequence
o = 5;
wn = [3 7]*2/Fs;
[b,a] = butter(o,wn,'bandpass');
% see frequency response of the filter
[h,w] = freqz(b,a,1024,Fs);
%subplot(2,2,3);
%plot(w,20*log10(abs(h)));
title('Magnitude Response of the Filter');
xlabel('Frequency (Hz)');
ylabel('Magnitude');grid on;
% Filter the signal
y_filt = filter(b,a,y);
%subplot(2,2,4);
plot(n,y_filt);
title('Filtered Signal');
xlabel('Time (s)');
ylabel('Amplitude');