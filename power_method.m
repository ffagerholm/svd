function v = power_method(A, tol, nmax)
    [n, m] = size(A);
    
    x = randn(m, 1);
    x = x / norm(x);
    current_v = x;
    
    if n > m
        B = A' * A;
    else
        B = A * A';
    end
    
    iter = 0;
    
    while iter <= nmax
        iter = iter + 1;
        last_v = current_v;
        current_v = B * last_v;
        current_v = current_v / norm(current_v);
        
        if abs(dot(current_v, last_v)) > 1 - tol
            v = current_v;
            %fprintf('The method converged in %i iterations \n', iter);
            return
        end
    end
return