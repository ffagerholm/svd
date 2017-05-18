import qr_algorithm.*
load('data/fisher.mat');

% Type 0 is Setosa; type 1 is Verginica; and type 2 is Versicolor.
A = [PW, PL, SW];
% we center the data to obtain the principal components
A_c = bsxfun(@minus,A,mean(A));

figure;

rotate3d on;
sc3d = scatter3(A_c(:, 1), A_c(:, 2), A_c(:, 3), 30, Type, 'filled');
xlabel('Petal width');
ylabel('Petal length');
zlabel('Sepal width');
%legend(sc3d, 'Setosa', 'Verginica', 'Versicolor');


[U, S, V] = qr_algorithm.svd_qr(A_c);
fprintf('Error: %e \n', max(max(abs(A_c - U*S*V'))));

% Projection onto first two principal components
A_red = U(:, 1:2)*S(1:2, 1:2);

figure
scatter(A_red(:, 1), A_red(:, 2), 30, Type, 'filled');
xlabel('1st principal component');
ylabel('2nd principal component');
%legend('Setosa', 'Verginica', 'Versicolor');