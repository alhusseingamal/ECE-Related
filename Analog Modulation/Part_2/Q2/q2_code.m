clc
clear all

% note about notation: small letter words refer to quanitities in time domain, while capital letter words refer to quanitities in frequency domain

% sampling and plotting variables
fs=95; % sampling frequency
t= 0:1/fs:1; % time samples for the info signal

% Q.1 Generate the sinusoidal message signal 𝑚(𝑡), with an amplitude of 2 volts and a frequency of 2 KHz and plot it.

% inforamtion signal data
Am=2; % Amplitude of inforamtion signal
fm=2000; % inforamtion signal frequency
mt=Am.*cos((2*pi*fm).*t);

% plotting
figure(1);
plot(t,mt);
xlabel('Time in seconds');
ylabel('Amplitude in Volts');
title('Information Signal');
grid on;
% ----------------------------


% Q.2 Generate the modulated signal, 𝑠(𝑡), output of the block shown in Fig. 2 using a carrier wave 𝑐(𝑡)
% of 1 Volt amplitude and 10 KHz frequency and plot USB and LSB.

fs=2015;
t= 0:1/fs:1; % time samples for the info signal

% the carrier signal data
Ac=1; % carrier signal Amplitude
fc=10000; % carrier signal frequency
Ct=Ac*cos((2*pi*fc).*t);
figure(2);
plot(t,Ct);
axis([0 0.1 -1 1]);
xlabel('Time in seconds');
ylabel('Amplitude in Volts');
title('Carrier Signal');
grid on;


fs=1e6; 
t=0:1/fs:1-1/fs;


% the LSB
Ylsb=Am*cos((2*pi*fm).*t).*cos((2*pi*fc).*t)+Am*sin((2*pi*fm).*t).*sin((2*pi*fc).*t);
figure(3);
plot(t,Ylsb);
axis([0 0.0004 -2 2]);
xlabel('Time in seconds');
ylabel('Amplitude in Volts');
title('LSB');
grid on;

% the USB
Yusb=Am*cos((2*pi*fm).*t).*cos((2*pi*fc).*t)-Am*sin((2*pi*fm).*t).*sin((2*pi*fc).*t);
figure(4);
plot(t,Yusb);
axis([0 0.0004 -2 2]);
xlabel('Time in seconds');
ylabel('Amplitude in Volts');
title('USB');
grid on;
% ----------------------------


% Q.3 Obtain the frequency spectrum of the modulated signal.

% We need to apply the FFT to get the signal in the frequency domain

% first we will need to alter the sampling frequency

N = length(t); % this is the number of points we have
f = (-N/2:N/2-1)*(fs/N);

% the LSB
YLSB = fft(Ylsb)/N;
figure(5);
plot(f, abs(fftshift(YLSB)));
axis([-15000 15000 0 2]);
title('LSB Signal in frequency Domain');
xlabel('frequency in Hz');
ylabel('mag');


% the USB
YUSB = fft(Yusb)/N;
figure(6);
plot(f, abs(fftshift(YUSB)));
axis([-15000 15000 0 2]);
title('USB Signal in frequency Domain');
xlabel('frequency in Hz');
ylabel('mag');

% The whole spectrum
figure(7);
plot(f, abs(fftshift(YUSB)) + abs(fftshift(YLSB)));
axis([-15000 15000 0 2]);
title('Signal spectrum in frequency Domain');
xlabel('frequency in Hz');
ylabel('mag');
%----------------------------


% Q.4 Implement a suitable demodulator to extract 𝑚(𝑡) from 𝑠(𝑡).

t = 0:1/fs:1-1/fs; 
fs = 1e6; 
Ct=Ac*cos((2*pi*fc).*t);
St_dash = Yusb .* (2*Ct); % coherent detection
% a factor of 2 is present to re-account for the multiplication by 1/2 in frequency domain
[b, a] = butter(4, fc/(fs/2), 'low'); 
% apply a LPF
mt_retrieved = filter(b, a, St_dash);

% Plot the Message Signal m(t) after Demodulation
figure(8);
plot(t, mt_retrieved);
axis([0 0.01 -5 5]);
title('The retrieved information signal m(t)');
xlabel('Time in seconds');
ylabel('Amplitude in Volts');
%----------------------------


% Q.5 Investigate the output of the previous step if the generator carrier wasn’t perfectly synchronized with
% the used one in modulator. Comment on the plots you obtain.

Ctprime = Ac*cos(2*pi*(fc)*t + 14); % The asynchronous carrier; a random phase alteration is added
sigprime = (Yusb) .* (2*Ctprime); 
[bprime, aprime] = butter(4, fc/(fs/2), 'low'); 
% apply a LPF
mtprime = filter(bprime, aprime, sigprime);
 

figure(9);
plot(t, mtprime);
axis([0 0.01 -5 5]);
title(' The information Signal with asynchronous carrier');
xlabel('Time in seconds');
ylabel('Amplitude in Volts');
%---------------------------