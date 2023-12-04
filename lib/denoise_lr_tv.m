function X = denoise_lr_tv(M,params_algo)

mu_lr = params_algo.mu_lr;
mu_tv = params_algo.mu_tv;
max_iter = params_algo.max_iter;
tol = params_algo.tol;
method = params_algo.method;

disp('Denoising started...');

%% Parameters
X = M;
% Lagrange multipliers
Phi_1  = zeros(size(M));
Phi_2  = zeros(size(M));
% Penalty parameters
rho_1  = params_algo.rho_1_init;
rho_2  = params_algo.rho_2_init;
rho = rho_1;

%% Main loop
disp('Optimization started...');
for iter = 1:max_iter
    %% Current variable values
    X_k = X;
    
    %% 1 Update Y
    Y_tilde = X-Phi_1/rho_1;
    mu_lr_tilde = mu_lr/rho_1;
    if method == "full"
        Y = min_lr(Y_tilde,mu_lr_tilde);
    elseif method == "simple_smoothing"
        Y = Y_tilde;
    end
    
    %% 2 Update Z
    Z_tilde = X-Phi_2/rho_2;
    mu_tv_tilde = mu_tv/rho_2;
    Z = denoise_tv(Z_tilde,mu_tv_tilde);

    %% 3 Update X
    X_tilde = ((Y+Phi_1/rho_1)+(Z+Phi_2/rho_2))/2;
    X_temp = min_poisson(M,X_tilde,rho);
    X = proj_nonnegative(X_temp);

    %% Update Lagrange multipliers
    Phi_1 = Phi_1+rho_1*(Y-X);
    Phi_2 = Phi_2+rho_2*(Z-X);

    diff_Y = norm(Y-X,"fro");
    diff_Z = norm(Z-X,"fro");
    diff_P = 2*rho_1^2*norm(X-X_k,"fro");
    diff_prime = (diff_Y+diff_Z) / max( (norm(Y,"fro")+norm(Z,"fro")), 2*norm(X,"fro") );
    diff_dual = diff_P / (norm(Phi_1,"fro") + norm(Phi_2,"fro"));
    diff = max([diff_prime, diff_dual]);

    disp(['iter=' num2str(iter), ', diff=' num2str(diff)]); 
    
    if diff < tol
        disp('Finished.');
        break;
    end
end

end
