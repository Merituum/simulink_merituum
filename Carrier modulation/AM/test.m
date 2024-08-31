% Parametry sygnału
T = 1;
fc = 40/T;
A_m = 1;

% Pobranie wyników z obiektu Simulink.SimulationOutput
simOut = evalin('base', 'simOut');  % Pobranie obiektu Simulink.SimulationOutput z Workspace

% Pobranie danych z Dataset
scopeData = simOut.scopeData;  % Pobranie obiektu Dataset z pola scopeData
disp(scopeData);

% Sprawdzenie, ile sygnałów jest w Dataset
numSignals = numel(scopeData);

% Sprawdzenie, czy jest przynajmniej jeden sygnał
if numSignals < 1
    error('Nie znaleziono sygnałów w Dataset');
end

% Pierwszy sygnał (może to być sygnał modulujący lub zmodulowany)
signal1 = scopeData{1};  % Uzyskanie dostępu do sygnału za pomocą indeksu
y_signal1 = signal1.Values.Data;  % Pobranie danych sygnału
t_signal1 = signal1.Values.Time;  % Pobranie wektora czasu

% Rysowanie pierwszego sygnału
figure;
subplot(2,1,1);
plot(t_signal1, y_signal1);
title('Pierwszy sygnał');
xlabel('Czas (s)');
ylabel('Amplituda');
grid on;

% Sprawdzenie, czy istnieje drugi sygnał
if numSignals >= 2
    % Drugi sygnał (np. po modulacji)
    signal2 = scopeData{2};  % Uzyskanie dostępu do sygnału za pomocą indeksu
    y_signal2 = signal2.Values.Data;  % Pobranie danych sygnału
    t_signal2 = signal2.Values.Time;  % Pobranie wektora czasu

    % Rysowanie drugiego sygnału
    subplot(2,1,2);
    plot(t_signal2, y_signal2);
    title('Drugi sygnał');
    xlabel('Czas (s)');
    ylabel('Amplituda');
    grid on;
else
    disp('Nie znaleziono drugiego sygnału.');
end

% Sprawdzenie typu danych i konwersja, jeśli to konieczne
if ismatrix(y_signal1)
    y_signal1 = y_signal1(:);  % Upewnienie się, że to wektor kolumnowy
end

% Obliczenie FFT pierwszego sygnału w MATLAB-ie
fft_result = fftshift(fft(y_signal1));
freq_axis = linspace(-0.5, 0.5, length(fft_result)) * (1/T);

% Rysowanie widma pierwszego sygnału
figure;
plot(freq_axis, abs(fft_result)); 
title('Widmo pierwszego sygnału');
xlabel('Częstotliwość (Hz)');
ylabel('Amplituda');
grid on;
