clear;
clc;

function y = centroid(functionfcn, a, b, tol, varargin)
    % varargin are additional parameters given to the function 
    % CENTROID is used to calculate the level of quantization of a function
    % a and b are the range of the quantization of the function
    % tol - absolute error

    % Create a function handle for the original function
    func = @(x) functionfcn(x, varargin{:});

    % Create a function handle for the weighted function (x * functionfcn(x))
    weightedFunc = @(x) x .* functionfcn(x, varargin{:});

    % Calculate the integral of the weighted function
    y1 = integral(weightedFunc, a, b, 'AbsTol', tol);

    % Calculate the integral of the original function
    y2 = integral(func, a, b, 'AbsTol', tol);

    % Calculate the centroid
    y = y1 / y2;
end

function [mse, dist] = mean_square_error(functionfcn, a, tol, varargin)
    % mean_square_error - calculates the mean square error of quantization
    % [MSE, DIST] = mean_square_error(FUNCTIONFCN, a, tol, varargin)
    % functionfcn might have up to 3 additional arguments passed via varargin
    % a is a vector with the range of quantization

    % Init an array for storing centroids
    y = zeros(1, length(a) - 1);

    % Calculation of centroids for each range
    for i = 1:length(a) - 1
        y(i) = centroid(functionfcn, a(i), a(i + 1), tol, varargin{:});
    end

    % Variable that stores the total distance (error)
    dist = 0;

    % Calculation of the mean square error
    for i = 1:length(a) - 1
        % Definition of a new function to calculate MSE
        fun_2 = @(x) (x - y(i)).^2 .* functionfcn(x, varargin{:});

        % Calculation of the integral over the given range
        dist = dist + integral(fun_2, a(i), a(i + 1), 'AbsTol', tol);
    end

    % Calculation of mean square error
    mse = dist / (length(a) - 1);
end

% EXAMPLE
f = @(x) x.^2 + 2;
a = [0, 1, 2];
tol = 1e-6;

centroid_value = centroid(f, a(1), a(2), tol);
disp(['Centroid: ', num2str(centroid_value)]);

[mse_value, dist_value] = mean_square_error(f, a, tol);
disp(['MSE: ', num2str(mse_value)]);
disp(['Distance: ', num2str(dist_value)]);
