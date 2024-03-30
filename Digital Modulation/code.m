clear; clc;
fm = 20;
Tm = 1/fm;
fs = 2*fm; % Sampling frequency
Ts = 1/fs; % Sampling time
L = 16; % Number of levels
n = 4; % Number of bits
t = 0:1/1000:2*Tm; % 2 cycles of the signals
t1 = 0:Ts:50*Tm;
%%                  (1)
mt = cos(2*pi*fm*t);
mt1 = cos(2*pi*fm*t1);
Vmax = max(mt);
Vmin = -Vmax;
StepSize = (Vmax-Vmin)/L;
figure(1);
subplot(3,1,1);
% Plotting the analog signal
plot(t,mt);
xlabel('Time(s)');
ylabel('M(t)');
title('Analog Signal');
grid;
% Plotting the sampled signal
subplot(3,1,2)
hold on
plot(t,mt,'-.');
stem(t1,mt1);
xlim([0 0.1])
ylabel('M(t)');
xlabel('Time(s)');
title('Sampled M(t)');
grid;
% Calculating the PCM using mid rise
InputValues = Vmin:StepSize:Vmax;
OutputValues = Vmin-StepSize/2:StepSize:Vmax+StepSize/2;
%This is a function that returns the quantized valus of the signal in array & the coded values for every single level
[Index,QuantizedValues] = quantiz(mt1,InputValues,OutputValues);
% Index is used for encoding while Quantized values is used to find the PCM
for i=1:length(QuantizedValues)
    if(QuantizedValues(1,i) == (Vmin-StepSize/2))
        QuantizedValues(1,i) = Vmin+StepSize/2;
    end
end
% Plotting Quantized PCM
subplot(3,1,3)
stairs(t1,mt1);
ylim([-2 2]);
xlim([0 0.1])
ylabel('Mt')
xlabel('Time(s)')
title('Quantized PCM Signal')
for i=1:length(Index)
    if(Index(i)~=0)
        Index(i) = Index(i)-1; % To make the values form
    end
end
Encodedbinarydummy = de2bi(Index,'left-msb'); % converts the index into binary values for encoding
c = 1;
figure(2)
for i=1:length(Index)
    for j=1:4
        Encodedbinary(c) = Encodedbinarydummy(i,j);
        c = c+1;
    end
end
stairs(Encodedbinary);
xlim([0 20])
ylim([-1 2])
xlabel('Time (ms)');
title('Encoded PCM');
% Reconstruction
Decoded = reshape(Encodedbinary,n,length(Encodedbinary)/n);
DecodedTrue = bi2de(Decoded,'left-msb');
DecodedQuantized=StepSize*Index+Vmin+(StepSize/2);
figure(3)
stairs(t1,DecodedQuantized);
xlim([0 0.1])
title('Quantized Decoded ')
BitRate = fs*n;
%%                  (2)