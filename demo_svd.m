
% We construct a matrix with eigenvalues that are close to each other  
V = rand(10, 10);
L = diag([9, 9, 8, 7, 6, 5, 4, 3, 2, 1]);
A = V*L*inv(V);

[U, S, V] = qr_algorithm.svd_qr(A, true, 100);
[U1, S1, V1] = svd(A);

fprintf('Accuracy: %e \n', max(max(abs(A - U*S*V'))));

disp(max(max(abs(S1 - S))));
disp(max(max(abs(abs(U1) - abs(U)))));
disp(max(max(abs(abs(V1) - abs(V)))));
