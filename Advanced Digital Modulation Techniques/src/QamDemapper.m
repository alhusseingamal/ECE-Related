function [bits] = QamDemapper(qam_symbols, M, mode)
% Calculate the number of bits per symbol
k = log2(M);

% Define the mapping for 4-QAM, 8-QAM and 16-QAM
if mode==6
    mapping_dict = containers.Map({'00', '01', '10', '11'}, ...
        {[-1-1j], [-1+1j], [1-1j], [1+1j]});
    % inverse Gray mapping for 4-QAM
    Inverse_gray_mapping = [0 1 2 3];
elseif mode==7
    mapping_dict = containers.Map({'000', '001', '010', '011', '100', '101', '110', '111'}, ...
        {[-3-1j], [-3+1j], [-1-1j], [-1+1j], [3-1j], [3+1j], [1-1j], [1+1j]});
    % inverse Gray mapping for 8-QAM
    Inverse_gray_mapping = [0 1 3 2 7 6 4 5];
elseif mode==8
    mapping_dict = containers.Map({'0000', '0001', '0010', '0011', '0100', '0101', '0110', '0111', '1000', '1001', '1010', '1011', '1100', '1101', '1110', '1111'}, ...
        {[-3-3j], [-3-1j], [-3+3j], [-3+1j], [-1-3j], [-1-1j], [-1+3j], [-1+1j], [3-3j], [3-1j], [3+3j], [3+1j], [1-3j], [1-1j], [1+3j], [1+1j]});
    % inverse Gray mapping for 16-QAM
    Inverse_gray_mapping = [0 1 3 2 7 6 4 5 15 14 12 13 8 9 11 10];
    
end

% Find the closest constellation point for each QAM symbol
decimal_symbols = zeros(size(qam_symbols));
constellation_points = cell2mat(values(mapping_dict));
for i = 1:length(qam_symbols)
    [~, index] = min(abs(qam_symbols(i) - constellation_points).^2);
    decimal_symbols(i) = index - 1;  % Indexing in MATLAB starts from 1
end

% Convert the decimal symbols to Gray code
gray_symbols = Inverse_gray_mapping(decimal_symbols + 1);

% Convert the Gray symbols to binary
binary_symbols = dec2bin(gray_symbols, k);

% Convert the binary symbols to a binary vector
bits = double(reshape(binary_symbols', 1, [])) - '0';
end
