import qr_algorithm.*
load('data/fisher.mat');

% function for plotting 3D vectors starting from the origin
% v is vector with 3 components
% c is the color of the vector
plot_3d_vector = @(v, c) quiver3(0, 0, 0, v(1), v(2), v(3), c);

% Type 0 is Setosa; type 1 is Verginica; and type 2 is Versicolor.
A = [PW, PL, SW];
% Mean center the data  
A_c = bsxfun(@minus, A, mean(A));
% prepare data for PCA
Y = A_c/sqrt(max(size(A)) - 1);

x_max = max(A_c(:,1));
x_min = min(A_c(:,1));
y_max = max(A_c(:,2));
y_min = min(A_c(:,2));

figure;
hold on;
rotate3d on;
grid on;
%axis([x_min x_max y_min y_max z_min z_max])

% 3D scatter plot pf data
sc3d = scatter3(Y(:, 1), Y(:, 2), Y(:, 3), 30, Type, 'filled');
xlabel('Petal width');
ylabel('Petal length');
zlabel('Sepal width');
%legend(sc3d, 'Setosa', 'Verginica', 'Versicolor');

xl = xlim();
yl = ylim();
zl = zlim();
line(xl, [0,0], [0,0], 'LineWidth', 1, 'Color', 'k');
line([0,0], yl, [0,0], 'LineWidth', 1, 'Color', 'k');
line([0,0], [0,0], zl, 'LineWidth', 1, 'Color', 'k');

% SVD of data
[U, S, PC] = qr_algorithm.svd_qr(Y);
% output maximum absolute difference between 
% actual data and SVD representation
fprintf('Error: %e \n', max(max(abs(Y - U*S*PC'))));

% Variances
V = S .* S;

axis tight;

% 2 first principal vectors
v1 = PC(:, 1);
v2 = PC(:, 2);
% plot principal vectors
plot_3d_vector(2*v1, 'red');
plot_3d_vector(2*v2, 'red');
% find and plot plane spanned by the vectors
a = cross(v1, v2);
[x, y] = meshgrid([x_min x_max], [y_min y_max]);
z = -(a(1)*x + a(2)*y)/a(3);
s = surf(x, y, z);
set(s, 'FaceColor', [0 0 0], 'FaceAlpha', 0.3, 'EdgeAlpha', 0);


% Projection onto first two principal components
A_red = U(:, 1:2)*S(1:2, 1:2);
%A_red = PC' * A_c';

figure;
s = scatter(A_red(:, 1), A_red(:, 2), 30, Type, 'filled');
xlabel('1st principal component');
ylabel('2nd principal component');
%legend('Setosa', 'Verginica', 'Versicolor');

fprintf('Explained variance: %f \n Ratio: %f \n', V(1,1) + V(2,2), (V(1,1) + V(2,2))/trace(V));