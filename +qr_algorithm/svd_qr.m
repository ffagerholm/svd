function [U, S, V] = svd_qr(A, debug, nmax, tol)
    % SVD_QR computes the reduced Singular Value Decomposition
    % of the matrix A.
    % [U, S, V] = SVD_QR(A) computes the SVD by finding 
    % the eigenvalues and vectors of the covariance matrix
    % A^T*A for A. 
    % If A is a rank k n,m-matrix, then U is a n,k-matrix containing 
    % the right singular vectors of A, S is a k,k-matrix 
    % containing the singular values of A and V is a k,m-matrix 
    % containing the left singular vectors of A. k is the smaller
    % of n and m.
    % 
    % The orthogonal matrix V consists of the eigenvectors of 
    % A^T*A, and the singular values are the square roots of
    % the corresponding eigenvaleus.
    if ~exist('debug', 'var') || isempty(debug); debug = false; end
    if ~exist('nmax', 'var') || isempty(nmax); nmax = 100; end
    if ~exist('tol', 'var') || isempty(tol); tol = 1.0e-9; end
    
    [n, m] = size(A);
    trans = false;
    
    if n < m
        % There are more rows than columns
        % so we transpose the matrix to get
        % a smaller covariance matrix
        % A^T*A and A*A^T have the same 
        % eigenvalues 
        A = A';
        trans = true;
    end
    
    % create the symmetric matrix X
    X = A' * A;
    % compute the eigenvalues and vectors of X
    % since X is symmetric, the eigenvectors are orthogonal
    [d, V] = qr_algorithm.qr_eigs(X, debug, nmax, tol);
    s = arrayfun(@sqrt, d);
    S_inv = diag(arrayfun(@(x) 1 / x, s));
    U = A*V*S_inv;
    S = diag(s);
    
    if trans
        % matrix was transposed, we swap the matrices
        [U, V] = deal(V, U);
    end
return