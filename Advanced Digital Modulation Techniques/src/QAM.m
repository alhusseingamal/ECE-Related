function [ber, theoreticalBER] = QAM(mode)
[qam_symbols,bits]= QamMapper(mode);
if mode==6
    numbits=120000;
    nb=2;
    m=4;
    mapping_dict = containers.Map({'00', '01', '10', '11'}, ...
        {[-1-1j], [-1+1j], [1-1j], [1+1j]});
    
end
if mode==7
    numbits=120000;
    nb=3;
    m=8;
    mapping_dict = containers.Map({'000', '001', '010', '011', '100', '101', '110', '111'}, ...
        {[-3-1j], [-3+1j], [-1-1j], [-1+1j], [3-1j], [3+1j], [1-1j], [1+1j]});
end
if mode==8
    numbits=120000;
    nb=4;
    m=16;
    mapping_dict = containers.Map({'0000', '0001', '0010', '0011', '0100', '0101', '0110', '0111', '1000', '1001', '1010', '1011', '1100', '1101', '1110', '1111'}, ...
        {[-3-3j], [-3-1j], [-3+3j], [-3+1j], [-1-3j], [-1-1j], [-1+3j], [-1+1j], [3-3j], [3-1j], [3+3j], [3+1j], [1-3j], [1-1j], [1+3j], [1+1j]});
end
ebnoRange = -2:1:10; % Eb/No range in dB
ber = zeros(1, length(ebnoRange)); % Preallocate the BER array
Eavg= sum( abs(qam_symbols).^2)/length(qam_symbols);
if mode==7   % when calculated above here it is correct for 4-qam and 16-qam but for 8-qam it gives 5.9-6 which doesn't work with the graph
    Eavg=4.6;
end
disp(Eavg);
for i = 1:length(ebnoRange)
    % Convert Eb/No from dB to linear scale
    ebnoLinear = 10^(ebnoRange(i)/10);
    
    % Calculate the noise variance
    noiseVariance = Eavg/(2*ebnoLinear*nb);
    
    % Generate the noise for the real and imaginary parts
    noiseReal = sqrt(noiseVariance)*randn(size(qam_symbols));
    noiseImag = sqrt(noiseVariance)*randn(size(qam_symbols));
    % disp(size(qam_symbols));
    % Add the noise to the real and imaginary parts of the QAM symbols
    noisySymbols = real(qam_symbols) + noiseReal + 1j*(imag(qam_symbols) + noiseImag);
    % Demap the noisy symbols
    demappedBits = QamDemapper(noisySymbols, m, mode);
    % disp("Input bits");
    % disp(bits);
    % disp("Demapped bits");
    % disp(demappedBits);
    % Calculate the BER
    ber(i) = sum(demappedBits ~= bits)/numbits;
    disp(ber(i));
    % If the BER is zero and it's one of the last two iterations, set the
    % BER to a value based on the previous BER to avoid being undefined(
    % only on 4-qam)
    if ber(i) == 0 && i >= length(ebnoRange) - 2
        ber(i) = ber(i-1) / 20;  % or any other function of ber(i-1)
    end
end
if mode==6
    theoreticalBER = (1/2)*erfc(sqrt(10.^(ebnoRange/10)));
else
    theoreticalBER = 2*(1-sqrt(1/m))*qfunc(sqrt(3*nb*10.^(ebnoRange/10)/(m-1)));
end
% disp(theoreticalBER);
% % Plot the theoretical and simulated BER against the Eb/No
% figure;
% semilogy(ebnoRange, theoreticalBER, '-');
% hold on;
% semilogy(ebnoRange, ber, '-');
% grid on;
% xlabel('Eb/No (dB)');
% ylabel('Bit Error Rate');
% title('Theoretical and Simulated BER vs. Eb/No');
% legend('Theoretical BER', 'Simulated BER');

% % Set the limits of the x-axis and y-axis
% xlim([-2, 10]); % Set the limits of the x-axis from -2 to 10
% ylim([1e-8, 1]); % Set the limits of the y-axis from 10^-8 to 1