function [D, U] = qr_eigs(A, tol, nmax)
    % QR_EIGS computes all the eigenvalues of a matrix A.
    % D = QR_EIG(A, TOL, NMAX) computes by QR iterations all
    % the eigenvalues of A within a tolerance TOL and a
    % maximum number of iteration NMAX. The convergence of
    % this method is not always guaranteed.
    [n, m] = size(A);
    
    if n ~= m, 
        error('The matrix must be square'); 
    end

    if ~exist('tol', 'var') || isempty(tol); tol = 1.0e-9; end
    if ~exist('nmax', 'var') || isempty(nmax); nmax = 100; end
    
    T = A;
    U = eye(n);
    niter = 0; 
    test = max(max(abs(tril(A,-1))));
    
    while niter <= nmax && test > tol
        [Q, R] = qr_householder(T); 
        T = R * Q;
        U = U * Q;
        niter = niter + 1;
        test = max(max(abs(tril(T,-1))));
    end

    if niter > nmax
        warning(['The method does not converge '...
            'in the maximum number of iterations \n']);
    else
        fprintf(['The method converges in '...
                    '%i iterations \n'],niter);
    end
    D = diag(T);
return