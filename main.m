close all
clear all
clc

%% Load data
% X \in R^{#channels \times #pixels}
% pixels = #x-pixels \times #y^pixels
M = load('data');

%% ADMM parameters
params_algo.rho_1_init = 1e1; % Probably fixed
params_algo.rho_2_init = params_algo.rho_1_init;
params_algo.tol = 1e-3; % Probably fixed
params_algo.max_iter = 1000; % Probably fixed

%% Regularization parameters
params_algo.mu_lr = 5e1; % Please adjust
params_algo.mu_tv = 1e2; % Please adjust
%params_algo.method = "simple_smoothing"; % Uses only mu_tv for smoothing
params_algo.method = "full"; % Uses both mu_lr and mu_tv

% X_denoised \in R^{#channels \times #pixels}
X_denoised = denoise_lr_tv(M, params_algo);
