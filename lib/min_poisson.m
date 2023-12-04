function X = min_betadiv(M,X_tilde,rho)

X = (2*rho*X_tilde-ones(size(X_tilde))+sqrt((2*rho*X_tilde-ones(size(X_tilde))).^2+8*rho*M))/(4*rho);

end