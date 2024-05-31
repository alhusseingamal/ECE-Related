% AlHussein Gamal Hussein Ali - 1200399
function [BASK_BER_th, BASK_BER_sim] = BASK()
clc;
clear all;
signalWidth = 120000; % length of input signal
Eb = 1;
SNRdB = -2 : 1 : 10;
SNR = 10.^(SNRdB/10);

for i = 1 : length(SNR)
    No = Eb / SNR(i);
    differentBitsCount = 0;

    % Generate a random input bit stream
    inputSignal = randi([0 1], 1, signalWidth);
    mappedSignal = inputSignal;
    
    %Generate complex AWGN channel
    NI = sqrt(No/2) * Eb * randn(1, signalWidth);
    NQ = sqrt(No/2) * Eb * randn(1, signalWidth);
    channelNoise = NI + j * NQ;
    
    % Received Signal
    receivedSignal = mappedSignal + channelNoise;

    % Decision Device
    for k = 1 : signalWidth
        Z(k) = receivedSignal(k);
        if ((Z(k) > 0.5 && inputSignal(k) == 0) || (Z(k) < 0.5 && inputSignal(k) == 1))
            differentBitsCount = differentBitsCount + 1;
        end
    end
    BASK_BER_sim(i) = differentBitsCount / signalWidth;      % Simulated BER
end

BASK_BER_th = (1/2) * erfc(sqrt(SNR/4));       % Theoretical BER
    
end 