function [d, V] = qr_eigs(A, debug, nmax, tol)
    % QR_EIGS computes all the eigenvalues of a matrix A.
    % [D, V] = QR_EIGS(A, TOL, NMAX) computes by QR iterations all
    % the eigenvalues of A within a tolerance TOL and a
    % maximum number of iteration NMAX. The convergence of
    % this method is not always guaranteed.
    [n, m] = size(A);
    
    if n ~= m, 
        error('The matrix must be square'); 
    end
    
    T = A;
    V = eye(n);
    iter = 0; 
    test = max(max(abs(tril(A, -1))));
    
    while iter <= nmax && test > tol
        [Q, R] = qr_algorithm.qr_householder(T); 
        T = R * Q;
        V = V * Q;
        iter = iter + 1;
        test = max(max(abs(tril(T,-1))));
    end

    if iter > nmax && debug
        warning(['The method does not converge '...
            'in the maximum number of iterations %i\n'], nmax);
    else
        if debug
            fprintf(['The method converged'...
                    'in %i iteration(s)\n'], iter);
        end
    end
    d = diag(T);
return