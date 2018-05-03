P_c1 = 0.8;
P_c2 = 0.1;
P_c3 = 0.1;
A = [0 6 4;1 0 3;1 6 0];
% A = [0 1 1;1 0 1;1 1 0];
mui1 = [0,0];
mui2 = [-3,-2];
mui3 = [3,2];
sig1 = [4,0;0,1];
sig2 = [1,0;0,2];
sig3 = [1,0;0,2];
x1 = -10:0.1:10;
x1 = x1';
x2 = -10:0.1:10;
n = length(x1);
m = length(x2);

for i = 1:n
    for j = 1:m
        X = [x1(i),x2(j)];
        P1_pri(i,j) = 1/sqrt(2*pi)/det(sig1)^0.5 * exp(-(X-mui1)*sig1^-1*(X-mui1)'/2);
        P2_pri(i,j) = 1/sqrt(2*pi)/det(sig2)^0.5 * exp(-(X-mui2)*sig2^-1*(X-mui2)'/2);
        P3_pri(i,j) = 1/sqrt(2*pi)/det(sig3)^0.5 * exp(-(X-mui3)*sig3^-1*(X-mui3)'/2);
        P1_post(i,j) = P1_pri(i,j)*P_c1;
        P2_post(i,j) = P2_pri(i,j)*P_c2;
        P3_post(i,j) = P3_pri(i,j)*P_c3;
        P1_post(i,j) = P1_post(i,j)/(P1_post(i,j) + P2_post(i,j) + P3_post(i,j));
        P2_post(i,j) = P2_post(i,j)/(P1_post(i,j) + P2_post(i,j) + P3_post(i,j));
        P3_post(i,j) = P3_post(i,j)/(P1_post(i,j) + P2_post(i,j) + P3_post(i,j));
        [~,G_LE(i,j)] = max([P1_post(i,j),P2_post(i,j),P3_post(i,j)]);
        l1(i,j) = A(1,1) * P1_post(i,j) + A(1,2) * P2_post(i,j) + A(1,3) * P3_post(i,j);
        l2(i,j) = A(2,1) * P1_post(i,j) + A(2,2) * P2_post(i,j) + A(2,3) * P3_post(i,j);
        l3(i,j) = A(3,1) * P1_post(i,j) + A(3,2) * P2_post(i,j) + A(3,3) * P3_post(i,j);
        [~,G_LR(i,j)] = min([l1(i,j),l2(i,j),l3(i,j)]);
    end
end

for i = 1:n
    X1(1:n,i) = x1;
    X2(i,1:n) = x2;
end

figure(1);
subplot(2,2,1);
mesh(X1,X2,P1_pri);
title('Class_1 Probability density curve');
xlabel('X1');ylabel('X2');zlabel('P(X|\omega_i)');
hold on;

subplot(2,2,2);
mesh(X1,X2,P2_pri);
title('Class_2 Probability density curve');
xlabel('X1');ylabel('X2');zlabel('P(X|\omega_i)');
hold on;

subplot(2,2,3);
mesh(X1,X2,P3_pri);
title('Class_3 Probability density curve');
xlabel('X1');ylabel('X2');zlabel('P(X|\omega_i)');
hold on;

subplot(2,2,4);
mesh(X1,X2,P1_pri);
hold on;
mesh(X1,X2,P2_pri);
hold on;
mesh(X1,X2,P3_pri);
hold on;
title('Probability density curve');
xlabel('X1');ylabel('X2');zlabel('P(X|\omega_i)');
hold on;

figure(2);
subplot(2,2,1);
mesh(X1,X2,P1_post);
title('Class_1 Posteriori probability curve');
xlabel('X1');ylabel('X2');zlabel('P(\omega_i|X)');
hold on;

subplot(2,2,2);
mesh(X1,X2,P2_post);
title('Class_2 Posteriori probability curve');
xlabel('X1');ylabel('X2');zlabel('P(\omega_i|X)');
hold on;

subplot(2,2,3);
mesh(X1,X2,P3_post);
title('Class_3 Posteriori probability curve');
xlabel('X1');ylabel('X2');zlabel('P(\omega_i|X)');
hold on;
subplot(2,2,4);
mesh(X1,X2,G_LE);
title('Least error class decision function');
xlabel('X1');ylabel('X2');zlabel('P(\omega_i|X)');
hold on;

figure(3);
subplot(2,2,1);
mesh(X1,X2,l1);
title('Action_1 Cost function curve');
xlabel('X1');ylabel('X2');zlabel('R(a_i|X)');
hold on;

subplot(2,2,2);
mesh(X1,X2,l2);
title('Action_2 Cost function curve');
xlabel('X1');ylabel('X2');zlabel('R(a_i|X)');
hold on;

subplot(2,2,3);
mesh(X1,X2,l3);
title('Action_3 Cost function curve');
xlabel('X1');ylabel('X2');zlabel('R(a_i|X)');
hold on;

subplot(2,2,4);
mesh(X1,X2,G_LR);
title('Least risk class decision function');
xlabel('X1');ylabel('X2');zlabel('R(a_i|X)');
hold on;
