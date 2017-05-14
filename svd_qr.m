function [U, S, V] = svd_qr(A)
    % SVD_QR computes the Singular Value Decomposition
    % of the matrix A.
    % [U, S, V] = SVD_QR(A) computes the SVD by finding 
    % the eigenvalues and vectors of the covariance matrix
    % A^T*A for A. 
    % If A is a n,m-matrix, then U is a n,k-matrix containing 
    % the right singular vectors of A, S is a vector of legth 
    % k containing the singular values of A and V is a k,m-matrix 
    % containing the left singular vectors of A. k is the smaller
    % of n and m.
    % 
    % The orthogonal matrix V consists of the eigenvectors of 
    % A^T*A, and the singular values are the square roots of
    % the corresponding eigenvaleus.
    [n, m] = size(A);
    trans = false;
    
    if n < m
        % There are more rows than columns
        % so we transpose the matrix to get
        % a smaller covariance matrix
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