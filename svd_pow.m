function [U, S, V] = svd_pow(A, k, tol, nmax)
    % SVD_POW computes the Singular Value Decomposition
    % of the matrix A.
    %     A = U*S*V'
    % 
    % [U, S, V] = SVD_QR(A, K, TOL, NMAX) computes the SVD 
    % of a matrix by compuring the eigenvalues and 
    % vectors for the matrix A'*A. Eigenvalues are computed using the
    % iterated power method in with deflation.
    % 
    
    [n, m] = size(A);
    trans = false;
    
    if n < m
        A = A';
        trans = true;
        [n, m] = size(A);
    end
    
    if ~exist('k', 'var') || isempty(k); k = min(n, m); end
    if ~exist('tol', 'var') || isempty(tol); tol = 1.0e-9; end
    if ~exist('nmax', 'var') || isempty(nmax); nmax = 100; end
    
    U = zeros(n, k);
    S = zeros(k);
    V = zeros(k, m);
 
    for i = 1:k
        A_copy = A;
        
        % deflation of the matrix
        for j = 1:i
           A_copy = A_copy - S(j) * (U(:, j)*V(:, j)'); 
        end
        
        v = power_method(A_copy, tol, nmax);
        u_unnormalized = A*v;
        sigma = norm(u_unnormalized);
        u = u_unnormalized / sigma;
        
        U(:, i) = u;
        S(i) = sigma;
        V(:, i) = v;
    end
    
    if trans
        % matrix was transposed, we swap the matrices
        [U, V] = deal(V, U);
    end
return

