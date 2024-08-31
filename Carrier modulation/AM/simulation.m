% Zamknięcie istniejącego modelu, jeśli jest otwarty
if bdIsLoaded('ModulacjaAMModel')
    close_system('ModulacjaAMModel', 0); % 0 oznacza zamknięcie bez zapisywania
end

% Nazwa modelu
modelName = 'ModulacjaAMModel';

% Tworzenie nowego modelu Simulink
new_system(modelName); % Tworzenie nowego systemu

% Dodanie bloku Sine Wave do sygnału modulującego
add_block('simulink/Sources/Sine Wave', [modelName '/ModulatingSignal']);
set_param([modelName '/ModulatingSignal'], 'Frequency', '1/T'); % Ustawienie częstotliwości

% Dodanie bloku Product do modulacji sygnału
add_block('simulink/Math Operations/Product', [modelName '/Modulation']);
add_line(modelName, 'ModulatingSignal/1', 'Modulation/1');

% Dodanie bloku Sine Wave do generowania kosinusa (nośna)
add_block('simulink/Sources/Sine Wave', [modelName '/Carrier']);
set_param([modelName '/Carrier'], 'Frequency', '40/T');
add_line(modelName, 'Carrier/1', 'Modulation/2');

% Dodanie bloku Scope do wyświetlenia wyniku
add_block('simulink/Sinks/Scope', [modelName '/Scope']);
add_line(modelName, 'Modulation/1', 'Scope/1');

% Ustawienia Scope do eksportowania danych do MATLAB
set_param([modelName '/Scope'], 'SaveToWorkspace', 'on', 'SaveName', 'scopeData', 'LimitDataPoints', 'on');

% Ustawienia czasowe
set_param(modelName, 'Solver', 'FixedStepAuto', 'StopTime', '1');

% Zapisanie modelu
save_system(modelName);

% Otwarcie modelu
open_system(modelName);

% Uruchomienie symulacji
simOut = sim(modelName);
% Sprawdzenie zawartości Workspace
% whos
% vars = who;
% disp(vars);
% Sprawdzenie dostępnych sygnałów w obiekcie Simulink.SimulationOutput
disp(simOut);

% Wyświetlenie wszystkich dostępnych elementów
elements = simOut.get('ScopeData');  % Przykładowa nazwa, sprawdź rzeczywistą nazwę
disp(elements);
