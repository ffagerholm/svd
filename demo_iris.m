import qr_algorithm.*
load('data/fisher.mat');

plot_3d_vector = @(v, c) quiver3(0, 0, 0, v(1), v(2), v(3), c);

% Type 0 is Setosa; type 1 is Verginica; and type 2 is Versicolor.
A = [PW, PL, SW];
% we center the data to obtain the principal components
A_c = bsxfun(@minus, A, mean(A));

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

% SVD of data
[U, S, V] = qr_algorithm.svd_qr(A_c);
fprintf('Error: %e \n', max(max(abs(A_c - U*S*V'))));

axis tight;

% Plane spanned by two first principal components
v1 = V(:, 1);
v2 = V(:, 2);
plot_3d_vector(30*v1, 'red');
plot_3d_vector(30*v2, 'red');
a = cross(v1, v2);
[x, y] = meshgrid([x_min x_max], [y_min y_max]);
z = -(a(1)*x + a(2)*y)/a(3);
s = surf(x, y, z);
set(s, 'FaceColor', [0 0 0], 'FaceAlpha', 0.3, 'EdgeAlpha', 0);

%{

% Projection onto first two principal components
A_red = U(:, 1:2)*S(1:2, 1:2);

figure;
scatter(A_red(:, 1), A_red(:, 2), 30, Type, 'filled');
xlabel('1st principal component');
ylabel('2nd principal component');
%legend('Setosa', 'Verginica', 'Versicolor');

%}