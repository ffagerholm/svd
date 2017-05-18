function [Q, R] = qr_householder(A)
    [m, n] = size(A);
    Q = eye(m);
    for i = 1:(n - (n == m))
       H = eye(m);
       H(i:m, i:m) = householder(A(i:m, i));
       Q = Q * H;
       A = H * A;
    end
    R = A;
return

function H = householder(a)
    v = (1.0 / (a(1) + (sign(a(1)) * norm(a)))) * a;
    v(1) = 1;
    H = eye(size(a, 1));
    H = H - (2.0/dot(v, v)) * (v*v');
return


