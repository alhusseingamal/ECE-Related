% Mohamed Gamal Hussein Ali - 1200435
function [DPSK_BER_th, DPSK_BER_sim] = DPSK()
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
    inputSignal = randi([0 1], 1, signalWidth + 1);
    
    % Differential Encoding
    mappedSignal(1) = inputSignal(1);
    for h = 2 : signalWidth + 1
        mappedSignal(h) = xor(mappedSignal(h-1), inputSignal(h - 1));
    end
    % Modulation
    mappedSignal = 2 * mappedSignal - 1;
    
    %Generate complex AWGN channel
    NI = sqrt(No/2) * Eb * randn(1, signalWidth + 1);
    NQ = sqrt(No/2) * Eb * randn(1, signalWidth + 1);
    channelNoise = NI + j * NQ;
    
    % Received Signal
    receivedSignal = mappedSignal + channelNoise;

    % ---- Demapping ---- %
    for k = 1 : signalWidth + 1
        receivedSignal(k) = receivedSignal(k) > 0;
    end
    
    % Handling the first bit separately
    Z_prime(1) = receivedSignal(1) > 0.5;
    Z(1) = Z_prime(1);
    
    for k = 1 : signalWidth
        Z_prime(k + 1) = receivedSignal(k + 1) > 0.5;
        Z(k) = xor(Z_prime(k), Z_prime(k + 1));
        if ((Z(k) > 0.5 && inputSignal(k) == 0) || (Z(k) < 0.5 && inputSignal(k) == 1))
            differentBitsCount = differentBitsCount + 1;
        end
    end

    DPSK_BER_sim(i) = differentBitsCount / signalWidth;      % Simulated BER
end

DPSK_BER_th = erfc(sqrt(SNR)) - (1/2) * erfc(sqrt(SNR)).^2;       % Theoretical BER

end









