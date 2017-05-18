import qr_algorithm.*
load('data/multivariate_normal.mat');

scatter3(X, Y, Z);
xlabel('x-axis');
ylabel('y-axis');
zlabel('z-axis');

A = [X', Y', Z'];
[U, S, V] = qr_algorithm.svd_qr(A);
fprintf('Error: %e \n', max(max(abs(A - U*S*V'))));

% Projection onto first two principal components
A_red = U(:, 1:2)*S(1:2, 1:2);
scatter(A_red(:, 1), A_red(:, 2));