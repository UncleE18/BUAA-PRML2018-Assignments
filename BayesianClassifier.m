Class1 = [-3.9847,-3.5549,-1.2401,-0.9780,-0.7932,-2.8531,-2.7605,-3.7287,... 
          -3.5414,-2.2692,-3.4549,-3.0752,-3.9934,-0.9780,-1.5799,-1.4885,...
          -0.7431,-0.4221,-1.1186,-2.3462,-1.0826,-3.4196,-1.3193,-0.8367,...
          -0.6579,-2.9683];
Class2 = [2.8792,0.7932,1.1882,3.0682,4.2532,0.3271,0.9846,2.7648,2.6588];
P_c1 = 0.9;
P_c2 = 0.1;
A = [0 1;6 0];
n1 = length(Class1);
n2 = length(Class2);
mui1 = 0;
mui2 = 0;
sig1 = 0;
sig2 = 0;
for i = 1:n1
    mui1 = mui1 + Class1(i);
end
mui1 = mui1 / n1;
for i = 1:n1
    sig1 = sig1 + ( Class1(i) - mui1 )^2;
end
sig1 = sqrt(sig1 / n1);

for i = 1:n2
    mui2 = mui2 + Class2(i);
end
mui2 = mui2 / n2;
for i = 1:n2
    sig2 = sig2 + ( Class2(i) - mui2 )^2;
end
sig2 = sqrt(sig2 / n2);
x = -10:0.1:10;


P1_pri = 1/sqrt(2*pi)/sig1 * exp(-(x-mui1).^2./(2*sig1^2));
P2_pri = 1/sqrt(2*pi)/sig2 * exp(-(x-mui2).^2./(2*sig2^2));
figure(1);
plot(x,P1_pri,'r','linewidth',2);
hold on;
plot(x,P2_pri,'b','linewidth',2);
hold on;
title('Probability density curve');
xlabel('X');ylabel('P(X|\omega_i)');
legend('Class_1','Class_2');


P1_post = P1_pri*P_c1;
P2_post = P2_pri*P_c2;
P1_post = P1_post./(P1_post + P2_post);
P2_post = P2_post./(P1_post + P2_post);
G_LE = P1_post - P2_post;
figure(2);
plot(x,P1_post,'r','linewidth',2);
hold on;
plot(x,P2_post,'b','linewidth',2);
hold on;
plot(x,G_LE,'--k','linewidth',2);
hold on;
title('Posteriori probability curve');
xlabel('X');ylabel('P(\omega_i|X)');
legend('Class_1','Class_2','Least error class decision function');

l1 = A(1,1) * P1_post + A(1,2) * P2_post;
l2 = A(2,1) * P1_post + A(2,2) * P2_post;
G_LR = l1 - l2;
figure(3);
plot(x,l1,'r','linewidth',2);
hold on;
plot(x,l2,'b','linewidth',2);
hold on;
plot(x,G_LR,'--k','linewidth',2);
hold on;
title('Cost function curve');
xlabel('X');ylabel('R(a_i|X)');
legend('Action_1','Action_2','Least risk class decision function');