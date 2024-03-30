% Q.1 Generate an input modulating signal 𝑚(𝑡) shown in Fig. 1.
t = linspace(0,0.002,5000);
mt = sawtooth(-2*pi*1000*t + pi); % define the information signal
figure(1);
plot(t,mt);
xlabel('time in seconds');
ylabel('Amplitude in volts');
title('The information signal 𝑚(𝑡)');
grid on;
%-----------------------



% Q.2 Generate an AM DSB-LC signal with 𝑚(𝑡) using a carrier wave 𝑐(𝑡)of 1 Volt amplitude and 10 KHz frequency 𝐾a = 0.5 
Ka=0.5;

% carrier signal parameters
Ac=1;
fc=10000;

% the AM signal
St=Ac*(1+Ka*mt).*cos(2*pi*fc*t);

figure(2);
plot(t,St);
xlabel('time in seconds');
ylabel('Amplitude in volts');
title('AM signal at Ka=0.5');
grid on;
% the modulation index is relatively low and as such the amplitude variation is small 
%-----------------------


% Q.3 Repeat the previous steps for 𝐾a = 1 and 𝐾a = 2. 
% Ka = 1
Ka=1;
St=Ac*(1+Ka*mt).*cos(2*pi*fc*t);

figure(3);
plot(t,St);
xlabel('time in seconds');
ylabel('Amplitude in volts');
title('AM signal at Ka=1');
grid on;

% Ka = 2
Ka=2;
St=Ac*(1+Ka*mt).*cos(2*pi*fc*t);

figure(4);
plot(t,St);
xlabel('time in seconds');
ylabel('Amplitude in volts');
title('AM signal at Ka=2');
grid on;

% The change in amplitude is higher at the higher modulation index
%-----------------------


% Q.4 Generate an FM signal for the same carrier then Plot the FM signal
fs=200000;
Kf=1000;
% We need to calculate the integral of m(t)
% we will use the function cumtrapz
I=cumtrapz(t,mt);
St= Ac*cos((2*pi*fc).*t +2*pi* Kf*I);
figure(5)
plot(t,St);
axis([0 0.002 -1 1]);
xlabel('time in seconds');
ylabel('Amplitude in volts');
title('FM signal at Kf=1000');
grid on;
%-----------------------


% Q.5 Repeat the previous steps for 𝐾𝑓= 3000 and 𝐾𝑓= 5000.
% Kf = 3000
Kf=3000;
St= Ac*cos((2*pi*fc).*t +2*pi* Kf*I);

figure(6)
plot(t,St);
axis([0 0.002 -1 1]);
xlabel('time in seconds');
ylabel('Amplitude in volts');
title('FM signal at Kf=3000');
grid on;

% Kf = 5000
Kf=5000;
St= Ac*cos((2*pi*fc).*t +2*pi* Kf*I);

figure(7)
plot(t,St);
axis([0 0.002 -1 1]);
xlabel('time in seconds');
ylabel('Amplitude in volts');
title('FM signal at Kf=5000');
grid on;
%-----------------------