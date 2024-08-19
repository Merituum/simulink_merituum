clear;
clc;
%COMPARASMENT of theoretical versus simulated error margin
% echo on 
% z=input(" ");
SNRindB1=0:0.1:12;
SNRindB2=0:0.1:12;
disp(length(SNRindB2));
for i=1:length(SNRindB1)
    %simulated error margin
    smltd_err_prb(i)=smldPe54(SNRindB1(i));
end


%teoretical error margin
for x=1:length(SNRindB2)
    SNR=exp(SNRindB2(i)*log(10)/10);
    theoretical(i)=q_function_calc(sqrt(SNR));
end

% disp(length(SNRindB2));
% 
% disp(length(theoretical))

% Debugging: Check lengths of vectors
disp(['Length of SNRindB2: ', num2str(length(SNRindB2))])
disp(['Length of theoretical: ', num2str(length(theoretical))])

% Create the first figure for simulation
figure;
title('Simulation');
semilogy(SNRindB1, smltd_err_prb, '*b'); % Blue stars for simulated data
xlabel('SNR (dB)');
ylabel('Error Probability');
grid on;

% Create the second figure for theory
figure;
title('Theory');
semilogy(SNRindB2, theoretical, 'r'); % Red crosses for theoretical data
xlabel('SNR (dB)');
ylabel('Error Probability');
grid on;
