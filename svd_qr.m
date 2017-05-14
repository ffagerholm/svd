function [U, S, V] = svd_qr(A)
    [n, m] = size(A);
    trans = false;
    
    if n < m
        A = A';
        trans = true;
    end
    
    covariance_matrix = A' * A;
    [D, V] = qr_eigs(covariance_matrix);
    S = arrayfun(@sqrt, D);
    U = A*V*(diag(arrayfun(@(x) 1.0/x, S)));
    
    if trans
        % matrix was transposed, we swap the matrices
        [U, V] = deal(V, U);
    end
return