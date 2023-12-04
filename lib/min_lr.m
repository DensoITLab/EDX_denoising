function Z = min_lr(Z_tilde,mu)

[U,S,V] = svd(Z_tilde,'econ');
S = diag(S);
r = length(find(S>mu));

if r >= 1
    S = S(1:r)-mu;
    Z = U(:,1:r)*diag(S)*V(:,1:r)';
else
    Z = zeros(size(Z_tilde));
end

end
