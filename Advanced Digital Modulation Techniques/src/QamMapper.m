function [qam_symbols, bits] = QamMapper(mode)
if mode==6 % 4-QAM
    % Define the number of bits
    num_bits = 120000;
    M=2;
    % Generate a series of random bits
    bits = randi([0 1], 1, num_bits);
    
    % Reshape the bits into 2-bit groups
    bits_2d = reshape(bits, M, num_bits/M);
    
    % Convert each 2-bit group into a binary string
    bits_concatenated = cell(num_bits/M, 1);
    for i = 1:num_bits/M
        bits_concatenated{i} = strcat(num2str(bits_2d(1,i)), num2str(bits_2d(2,i)));
    end
    % Convert the binary strings to logical arrays
    bits_bin = cellfun(@(x) logical(x-'0'), bits_concatenated, 'UniformOutput', false);
    
    % Shift the logical arrays to the right
    bits_shifted = cellfun(@(x) [false, x(1:end-1)], bits_bin, 'UniformOutput', false);
    
    % XOR the logical arrays with the shifted arrays
    bits_xor = cellfun(@xor, bits_bin, bits_shifted, 'UniformOutput', false);
    
    % Convert the XOR results back to binary strings
    bits_xor_bin = cellfun(@(x) sprintf('%02s', dec2bin(bin2dec(num2str(x)))), bits_xor, 'UniformOutput', false);
    
    % Display the XOR results
    % disp(bits_xor_bin);
    
    % Convert the XOR results to decimal numbers
    % bits_xor_dec = cellfun(@bin2dec, bits_xor_bin);
    
    % % Display the decimal numbers
    % disp(bits_xor_dec);
    % Define the mapping dictionary for 4-QAM
    mapping_dict = containers.Map({'00', '01', '10', '11'}, ...
        {[-1-1j], [-1+1j], [1-1j], [1+1j]});
    
    % Map the XOR results to their corresponding real and imaginary components
    qam_symbols = cellfun(@(x) mapping_dict(x), bits_concatenated, 'UniformOutput', false);
    
    % Convert the cell array to a column vector
    qam_symbols = vertcat(qam_symbols{:});
    % qam_symbols = round(real(qam_symbols)) + round(imag(qam_symbols))*1j;
    % Display the QAM symbols
    % disp(qam_symbols);
    hold on;
    % Plot the 4-QAM constellation
    % scatter(real(qam_symbols), imag(qam_symbols), 'filled');
    % Add x-axis and y-axis
    % xlim([-3, 3]);
    % ylim([-3, 3]);
    % line(xlim, [0 0], 'Color', 'k'); % x-axis
    % line([0 0], ylim, 'Color', 'k'); % y-axis
    % hold off;
    % xlabel('Real Part');
    % ylabel('Imaginary Part');
    % title('4-QAM Constellation');
    % grid on;
end
if mode==7 % 8-QAM
    % Define the number of bits
    num_bits = 120000;
    M=3;
    % Generate a series of random bits
    bits = randi([0 1], 1, num_bits);
    
    % Reshape the bits into 3-bit groups
    bits_3d = reshape(bits, M, num_bits/M);
    
    % Convert each 3-bit group into a binary string
    bits_concatenated = cell(num_bits/M, 1);
    for i = 1:num_bits/M
        bits_concatenated{i} = strcat(num2str(bits_3d(1,i)), num2str(bits_3d(2,i)), num2str(bits_3d(3,i)));
    end
    % Convert the binary strings to logical arrays
    bits_bin = cellfun(@(x) logical(x-'0'), bits_concatenated, 'UniformOutput', false);
    
    % Shift the logical arrays to the right
    bits_shifted = cellfun(@(x) [false, x(1:end-1)], bits_bin, 'UniformOutput', false);
    
    % XOR the logical arrays with the shifted arrays
    bits_xor = cellfun(@xor, bits_bin, bits_shifted, 'UniformOutput', false);
    
    % Convert the XOR results back to binary strings
    bits_xor_bin = cellfun(@(x) sprintf('%03s', dec2bin(bin2dec(num2str(x)))), bits_xor, 'UniformOutput', false);
    
    % Define the mapping dictionary for 8-QAM
    mapping_dict = containers.Map({'000', '001', '010', '011', '100', '101', '110', '111'}, ...
        {[-3-1j], [-3+1j], [-1-1j], [-1+1j], [3-1j], [3+1j], [1-1j], [1+1j]});
    
    % Map the XOR results to their corresponding real and imaginary components
    qam_symbols = cellfun(@(x) mapping_dict(x), bits_xor_bin, 'UniformOutput', false);
    
    % Convert the cell array to a column vector
    qam_symbols = vertcat(qam_symbols{:});
    
    % Display the QAM symbols
    % disp(qam_symbols);
    hold on;
    % Plot the 8-QAM constellation
    % scatter(real(qam_symbols), imag(qam_symbols), 'filled');
    % Add x-axis and y-axis
    % xlim([-6, 6]);
    % ylim([-3, 3]);
    % line(xlim, [0 0], 'Color', 'k'); % x-axis
    % line([0 0], ylim, 'Color', 'k'); % y-axis
    % hold off;
    % xlabel('Real Part');
    % ylabel('Imaginary Part');
    % title('8-QAM Constellation');
    % grid on;
end
if mode==8 % 16-QAM
    % Define the number of bits
    num_bits = 120000;
    M=4; % Change this to 4 for 16-QAM
    % Generate a series of random bits
    bits = randi([0 1], 1, num_bits);
    
    % Reshape the bits into 4-bit groups
    bits_4d = reshape(bits, M, num_bits/M);
    
    % Convert each 4-bit group into a binary string
    bits_concatenated = cell(num_bits/M, 1);
    for i = 1:num_bits/M
        bits_concatenated{i} = strcat(num2str(bits_4d(1,i)), num2str(bits_4d(2,i)), num2str(bits_4d(3,i)), num2str(bits_4d(4,i)));
    end
    % Convert the binary strings to logical arrays
    bits_bin = cellfun(@(x) logical(x-'0'), bits_concatenated, 'UniformOutput', false);
    
    % Shift the logical arrays to the right
    bits_shifted = cellfun(@(x) [false, x(1:end-1)], bits_bin, 'UniformOutput', false);
    
    % XOR the logical arrays with the shifted arrays
    bits_xor = cellfun(@xor, bits_bin, bits_shifted, 'UniformOutput', false);
    
    % Convert the XOR results back to binary strings
    bits_xor_bin = cellfun(@(x) sprintf('%04s', dec2bin(bin2dec(num2str(x)))), bits_xor, 'UniformOutput', false);
    
    % Define the mapping dictionary for 16-QAM
    mapping_dict = containers.Map({'0000', '0001', '0010', '0011', '0100', '0101', '0110', '0111', '1000', '1001', '1010', '1011', '1100', '1101', '1110', '1111'}, ...
        {[-3-3j], [-3-1j], [-3+3j], [-3+1j], [-1-3j], [-1-1j], [-1+3j], [-1+1j], [3-3j], [3-1j], [3+3j], [3+1j], [1-3j], [1-1j], [1+3j], [1+1j]});
    
    % Map the XOR results to their corresponding real and imaginary components
    qam_symbols = cellfun(@(x) mapping_dict(x), bits_xor_bin, 'UniformOutput', false);
    
    % Convert the cell array to a column vector
    qam_symbols = vertcat(qam_symbols{:});
    
    % Display the QAM symbols
    % disp(qam_symbols);
    hold on;
    % Plot the 16-QAM constellation
    % scatter(real(qam_symbols), imag(qam_symbols), 'filled');
    % Add x-axis and y-axis
    % xlim([-6, 6]);
    % ylim([-6, 6]);
    % line(xlim, [0 0], 'Color', 'k'); % x-axis
    % line([0 0], ylim, 'Color', 'k'); % y-axis
    % hold off;
    % xlabel('Real Part');
    % ylabel('Imaginary Part');
    % title('16-QAM Constellation');
    % grid on;
end
end
