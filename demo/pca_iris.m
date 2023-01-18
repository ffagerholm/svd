clear all;

import('qr_algorithm.*')
load('data/fisher.mat');

plot_3d_vector = @(v, c) quiver3(0, 0, 0, v(1), v(2), v(3), c);

% Type 0 is Setosa; type 1 is Verginica; and type 2 is Versicolor.
A = [PW, PL, SW];
% z-score normalize data matrix
A_c = normalize(A);

% covariance matrix of the data for PCA 
C = cov(A_c);
% PCA
[V, D] = eig(C);

figure;
hold on;
rotate3d on;
grid on;
%axis([x_min x_max y_min y_max z_min z_max])

% 3D scatter plot pf data
sc3d = scatter3(A_c(:, 1), A_c(:, 2), A_c(:, 3), 30, Type, 'filled');
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


min_values = min(A_c, [], 1);
max_values = max(A_c, [], 1);

axis tight;

% Plane spanned by two first principal components
v1 = V(:, 2);
v2 = V(:, 3);
plot_3d_vector(2*v1, 'red');
plot_3d_vector(2*v2, 'red');
a = cross(v1, v2);
[x, y] = meshgrid([min_values(1) max_values(1)], [min_values(2) max_values(2)]);
z = -(a(1)*x + a(2)*y)/a(3);
s = surf(x, y, z);
set(s, 'FaceColor', [0 0 0], 'FaceAlpha', 0.3, 'EdgeAlpha', 0);


