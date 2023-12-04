function X = proj_nonnegative(X_tilde)

X = X_tilde;
idx = find(X_tilde<0);
X(idx) = 0;

end

