init_snr = 0;
max_snr = 20;
snr_step = 0.1;
snr_dB = init_snr:snr_step:max_snr;

% Initiation of vector with results
Pe = zeros(1, length(snr_dB));

for i = 1:length(snr_dB)
    % Conversion of SNR to dB
    snr = 10^(snr_dB(i)/10);
    
    % Calculation of Pe (Probability error) with use of erfc
    Pe(i) = 0.5 * erfc(sqrt(snr) / sqrt(2));
end

% Plotting
semilogy(snr_dB, Pe);
xlabel("10 log 10 E/No");
ylabel("Pe");
