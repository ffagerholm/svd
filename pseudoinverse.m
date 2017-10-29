% function for plotting 3D vectors starting from the origin
% v is vector with 3 components
% c is the color of the vector
plot_3d_vector = @(v, c) quiver3(0, 0, 0, v(1), v(2), v(3), c);

%%%% Solving overdetermined set of linear equations using the pseudoinverse
%%%% giving the least squares solution to the system

% singular matrix
load('data/pinv.mat');

% row vectors
v1 = A(1, :);
v2 = A(2, :);

figure;
rotate3d on;
hold on;
grid on;

xlabel('x-axis');
ylabel('y-axis');
zlabel('z-axis');

plot_3d_vector(v1, 'red');
plot_3d_vector(v2, 'red');
plot_3d_vector(b, 'green');

% find and plot the plane spanned by the row vectors
a = cross(v1, v2);
[x, y] = meshgrid([0 1], [0 1]);
z = -(a(1)*x + a(2)*y)/a(3);
s = surf(x, y, z);
set(s, 'FaceColor', [0 1 1], 'FaceAlpha', 0.3, 'EdgeAlpha', 0);


% SVD of matrix
[U, S, V] = qr_algorithm.svd_qr(A);
% output maximum absolute difference between 
% actual data and SVD representation
fprintf('Error: %e \n', max(max(abs(A - U*S*V'))));
fprintf('Condition number: %e \n', cond(A));


% Compute the pseudoinverse
S_inv = diag(arrayfun(@(x) qr_algorithm.minverse(x), diag(S)));
A_pinv = V*S_inv*U';

x = A_pinv*b;
plot_3d_vector(x, 'black');

normal = cross(v1, v2)';
b_proj = b - (b'*normal)/(normal'*normal)*normal;
%plot_3d_vector(b_proj, 'blue');

%%%% Comparing inverse to pseudoinverse
% for full rank matrices pseudoinverse should be equal to the inverse
% full rank matrix
A = [1, 2, 3; 5, 7, 2; 7, 3, 9];
% inverse of A
A_inv = inv(A);
% pseudoinverse of A
[U, S, V] = qr_algorithm.svd_qr(A);
S_inv = diag(arrayfun(@(x) minverse(x), diag(S)));
A_pinv = V*S_inv*U';
% Greatest difference
fprintf('Pseudoinverse error: %e \n', max(max(abs(A_inv - A_pinv))));


