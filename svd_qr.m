function [U, S, V] = svd_qr(A)
    [m, n] = size(A);
    
    % A^T*A and A*A^T have the same eigenvalues
    if m > n
        covariance_matrix = A' * A;
    else 
        covariance_matrix = A * A';
    end
    
    [D, E] = qr_eigs(covariance_matrix);
    S = arrayfun(@sqrt, D);
    U = E;
    V = E;
return