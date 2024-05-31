clc;
clear all;

SNRdB = -2 : 1 : 10;
SNR = 10.^(SNRdB/10);

[BASK_BER_th, BASK_BER_sim] = BASK();
[BPSK_BER_th, BPSK_BER_sim] = BPSK();
[BFSK_BER_th, BFSK_BER_sim] = BFSK();
[DPSK_BER_th, DPSK_BER_sim] = DPSK();
[OOK_BER_th, OOK_BER_sim] = OOK();
[QAM4_BER_th, QAM4_BER_sim] = QAM(6);
[QAM8_BER_th, QAM8_BER_sim] = QAM(7);
[QAM16_BER_th, QAM16_BER_sim] = QAM(8);

%---------- Plotting the BER ----------%

darkRed = [0.8 0 0]; % Define the RGB triplet for dark red
plot(SNRdB, BASK_BER_th, 'Color', darkRed);
hold on;
plot(SNRdB, BASK_BER_sim, '*', 'Color', darkRed);
hold on;

plot(SNRdB, BPSK_BER_th, 'r');
hold on;
plot(SNRdB, BPSK_BER_sim, 'r*');
hold on;

plot(SNRdB, OOK_BER_th, 'g');
hold on;
plot(SNRdB, OOK_BER_sim, 'g*');
hold on;

plot(SNRdB, QAM4_BER_th, 'b');
hold on;
plot(SNRdB, QAM4_BER_sim, 'b*');
hold on;

plot(SNRdB, QAM8_BER_th, 'c');
hold on;
plot(SNRdB, QAM8_BER_sim, 'c*');
hold on;

plot(SNRdB, QAM16_BER_th, 'm');
hold on;
plot(SNRdB, QAM16_BER_sim, 'm*');
hold on;

plot(SNRdB, BFSK_BER_th, 'k');
hold on;
plot(SNRdB, BFSK_BER_sim, 'k*');
hold on;

plot(SNRdB, DPSK_BER_th, 'y');
hold on;
plot(SNRdB, DPSK_BER_sim, 'y*');
hold on;

xlabel('Eb/No (dB)');
ylabel('BER');
title('Overlaid Results');
set(gca, 'YScale', 'log');
legend('BASK-th', 'BASK-sim', 'BPSK-th', 'BPSK-sim', 'OOK-th', 'OOK-sim', 'QAM4-th', 'QAM4-sim', 'QAM8-th', 'QAM8-sim', 'QAM16-th', 'QAM16-sim', 'BFSK-th', 'BFSK-sim', 'DPSK-th', 'DPSK-sim');

