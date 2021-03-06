import qr_algorithm.*
load('data/multivariate_normal.mat');

% function for plotting 3D vectors starting from the origin
% v is vector with 3 components
% c is the color of the vector
plot_3d_vector = @(v, c) quiver3(0, 0, 0, v(1), v(2), v(3), c);

figure;
rotate3d on;
scatter3(X, Y, Z, 30);

axis equal;
xl = xlim();
yl = ylim();
zl = zlim();
hold on;
line(2*xl, [0,0], [0,0], 'LineWidth', 1, 'Color', 'k');
line([0,0], 2*yl, [0,0], 'LineWidth', 1, 'Color', 'k');
line([0,0], [0,0], 2*zl, 'LineWidth', 1, 'Color', 'k');

xlabel('x-axis');
ylabel('y-axis');
zlabel('z-axis');

% construct the data matrix
A = [X', Y', Z'];
% normalize the data for PCA 
A_c = bsxfun(@minus, A, mean(A))/sqrt(max(size(A)) - 1);

[U, S, V] = qr_algorithm.svd_qr(A_c);
% output maximum absolute difference between 
% actual data and SVD representation
fprintf('Error: %e \n', max(max(abs(A_c - U*S*V'))));

% 2 first principal vectors
v1 = V(:, 1);
v2 = V(:, 2);
% plot principal vectors
plot_3d_vector(3*v1, 'red');
plot_3d_vector(3*v2, 'red');
% find and plot plane spanned by the vectors
a = cross(v1, v2);
[x, y] = meshgrid([-3 3], [-3 3]);
z = -(a(1)*x + a(2)*y)/a(3);
s = surf(x, y, z);
set(s, 'FaceColor', [0 0 0], 'FaceAlpha', 0.3, 'EdgeAlpha', 0);

% Projection onto first two principal components
figure;
%grid on;
A_proj = U(:, 1:2)*S(1:2, 1:2);
scatter(A_proj(:, 1), A_proj(:, 2), 30, 'filled');

