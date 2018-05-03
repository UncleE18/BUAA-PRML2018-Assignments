P_c1 = 0.5;
P_c2 = 0.25;
P_c3 = 0.25;
A = [0 6 4;1 0 3;1 4 0];
% A = [0 1 1;1 0 1;1 1 0];
mui1 = 0;
mui2 = -3;
mui3 = 3;
sig1 = 2;
sig2 = 1;
sig3 = 1;
x = -10:0.1:10;
n = length(x);

P1_pri = 1/sqrt(2*pi)/sig1 * exp(-(x-mui1).^2./(2*sig1^2));
P2_pri = 1/sqrt(2*pi)/sig2 * exp(-(x-mui2).^2./(2*sig2^2));
P3_pri = 1/sqrt(2*pi)/sig3 * exp(-(x-mui3).^2./(2*sig3^2));
figure(1);
plot(x,P1_pri,'r','linewidth',2);
hold on;
plot(x,P2_pri,'b','linewidth',2);
hold on;
plot(x,P3_pri,'g','linewidth',2);
hold on;
title('Probability density curve');
xlabel('X');ylabel('P(X|\omega_i)');
legend('Class_1','Class_2','Class_3');


P1_post = P1_pri*P_c1;
P2_post = P2_pri*P_c2;
P3_post = P3_pri*P_c3;
P1_post = P1_post./(P1_post + P2_post + P3_post);
P2_post = P2_post./(P1_post + P2_post + P3_post);
P3_post = P3_post./(P1_post + P2_post + P3_post);
for i = 1:n
    G_LE(i) = max([P1_post(i),P2_post(i),P3_post(i)]);
end
figure(2);
plot(x,P1_post,'r','linewidth',2);
hold on;
plot(x,P2_post,'b','linewidth',2);
hold on;
plot(x,P3_post,'g','linewidth',2);
hold on;
plot(x,G_LE,'--k','linewidth',2);
hold on;
title('Posteriori probability curve');
xlabel('X');ylabel('P(\omega_i|X)');
legend('Class_1','Class_2','Class_3','Least error class decision function');

l1 = A(1,1) * P1_post + A(1,2) * P2_post + A(1,3) * P3_post;
l2 = A(2,1) * P1_post + A(2,2) * P2_post + A(2,3) * P3_post;
l3 = A(3,1) * P1_post + A(3,2) * P2_post + A(3,3) * P3_post;
for i = 1:n
    G_LR(i) = min([l1(i),l2(i),l3(i)]);
end
figure(3);
plot(x,l1,'r','linewidth',2);
hold on;
plot(x,l2,'b','linewidth',2);
hold on;
plot(x,l3,'g','linewidth',2);
hold on;
plot(x,G_LR,'--k','linewidth',2);
hold on;
title('Cost function curve');
xlabel('X');ylabel('R(a_i|X)');
legend('Action_1','Action_2','Action_3','Least risk class decision function');

