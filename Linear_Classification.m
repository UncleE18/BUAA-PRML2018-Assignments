% Experiment 1: Perceptron learning toward linear classification
% By 15231074 Òü¸»çç

%% Generate database
n = 100; % Number of points in each classes
m = 20; % Test points
x1 = ones(n,3);
x2 = ones(n,3);
randn('seed',0);
x1(:,2:3) = mvnrnd([8,0],[1,0;0,1],n);
randn('seed',0);
x2(:,2:3) = mvnrnd([0,0],[1,0;0,1],n);

%% Plot data points
figure(1);
plot(x1(1:n-m,2),x1(1:n-m,3),'r*'); % Training sets
hold on;
plot(x2(1:n-m,2),x2(1:n-m,3),'r+');
hold on;

plot(x1(n-m+1:n,2),x1(n-m+1:n,3),'b*'); % Testing sets
hold on;
plot(x2(n-m+1:n,2),x2(n-m+1:n,3),'b+');
hold on;
axis([-5,10,-5,8]);


%% Initialization
w = [-1 1 1];
J = 1; % Cost funcion
iter = 1;
max_iteration = 1000;
h = 0.025; % Learning rate
dw = zeros(1,3);
X0 = [-5,10];

%% Training
while(J ~= 0)
    
    Y0 = -(w(iter,1) + w(iter,2)*X0)/w(iter,3);
    plot(X0,Y0,'--g');
    hold on;
    drawnow;
    
    J = 0;
    dw = zeros(1,3);
    for i = 1:n - m
        d1 = dot(w(iter,:),x1(i,:));
        d2 = dot(w(iter,:),x2(i,:));
        if d1 < 0
            J = J - d1;
            dw = dw + h * (-x1(i,:));
        end
        
        if d2 > 0
            J = J + d2;
            dw = dw + h * x2(i,:);
        end
    end
    w(iter + 1,:) = w(iter,:) - dw;
    
    iter = iter + 1; 
    if iter >= max_iteration
        break;
    end
end

if J == 0
    display('Hyperplane found!');
else
    display('Can not find a possible solution!');
end

Y0 = -(w(iter,1) + w(iter,2)*X0)/w(iter,3);
plot(X0,Y0,'-k','linewidth',1);
hold on;

%% Testing
error1 = 0;
error2 = 0;
for i = n - m + 1 : n
    d1 = dot(w(iter,:),x1(i,:));
    d2 = dot(w(iter,:),x2(i,:));
    
    if d1 < 0
        error1 = error1 + 1;
    end
    if d2 > 0
        error2 = error2 + 1;
    end
    
end
legend('Class_1 Training points','Class_2 Training points',...
    'Class_1 Testing points','Class_2 Testing points','Hyperplane');

figure(2);
plot3(w(:,1),w(:,2),w(:,3),'g-*');
hold on;
plot3(w(end,1),w(end,2),w(end,3),'ko');
hold on;

display(error1);
display(error2);
