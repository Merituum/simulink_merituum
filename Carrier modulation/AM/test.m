% Parametry sygnału
T = 1;
fc = 40/T;
A_m = 1;

% Uruchomienie symulacji
simOut = sim('ModulacjaAMModel');

% Pobranie wyników z bloku Scope
yout = simOut.get('scopeData');  % Pobranie danych ze Scope

% Jeśli 'scopeData' jest struktura, wydobycie właściwych danych
if isstruct(yout)
    yout = yout.signals.values;
end

% Obliczenie FFT w MATLAB-ie
fft_result = fftshift(fft(yout));
freq_axis = linspace(-0.5, 0.5, length(fft_result)) * (1/T);

% Rysowanie widma
figure;
plot(freq_axis, abs(fft_result)); 
title('Widmo sygnału zmodulowanego');
xlabel('Częstotliwość (Hz)');
ylabel('Amplituda');
grid on;
