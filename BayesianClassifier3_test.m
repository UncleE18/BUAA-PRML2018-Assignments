P_c1 = 0.5;
P_c2 = 0.25;
P_c3 = 0.25;
A = [0 6 4;1 0 3;1 4 0];
mui1 = [0,0];
mui2 = [-3,-2];
mui3 = [3,2];
sig1 = [4,0;0,1];
sig2 = [1,0;0,2];
sig3 = [1,0;0,2];
randn('seed',0);
Test1 = mvnrnd(mui1,sig1,50);
randn('seed',0);
Test2 = mvnrnd(mui2,sig2,50);
randn('seed',0);
Test3 = mvnrnd(mui3,sig3,50);
er1_LE = 0;
er1_LR = 0;
c1 = 0;
er2_LE = 0;
er2_LR = 0;
c2 = 0;
er3_LE = 0;
er3_LR = 0;
c3 = 0;

for i = 1:50
    X = Test1(i,:);
    P1_pri(i) = 1/sqrt(2*pi)/det(sig1)^0.5 * exp(-(X-mui1)*sig1^-1*(X-mui1)'/2);
    P2_pri(i) = 1/sqrt(2*pi)/det(sig2)^0.5 * exp(-(X-mui2)*sig2^-1*(X-mui2)'/2);
    P3_pri(i) = 1/sqrt(2*pi)/det(sig3)^0.5 * exp(-(X-mui3)*sig3^-1*(X-mui3)'/2);
    P1_post(i) = P1_pri(i)*P_c1;
    P2_post(i) = P2_pri(i)*P_c2;
    P3_post(i) = P3_pri(i)*P_c3;
    P1_post(i) = P1_post(i)/(P1_post(i) + P2_post(i) + P3_post(i));
    P2_post(i) = P2_post(i)/(P1_post(i) + P2_post(i) + P3_post(i));
    P3_post(i) = P3_post(i)/(P1_post(i) + P2_post(i) + P3_post(i));
    [~,G_LE(i)] = max([P1_post(i),P2_post(i),P3_post(i)]);
    l1(i) = A(1,1) * P1_post(i) + A(1,2) * P2_post(i) + A(1,3) * P3_post(i);
    l2(i) = A(2,1) * P1_post(i) + A(2,2) * P2_post(i) + A(2,3) * P3_post(i);
    l3(i) = A(3,1) * P1_post(i) + A(3,2) * P2_post(i) + A(3,3) * P3_post(i);
    [~,G_LR(i)] = min([l1(i),l2(i),l3(i)]);
    
    if G_LE(i) ~= 1
        er1_LE = er1_LE + 1;
    end
    if G_LR(i) ~= 1
        er1_LR = er1_LR + 1;
        c1 = c1 + 1;
    end
end

for i = 1:50
    X = Test2(i,:);
    P1_pri(i) = 1/sqrt(2*pi)/det(sig1)^0.5 * exp(-(X-mui1)*sig1^-1*(X-mui1)'/2);
    P2_pri(i) = 1/sqrt(2*pi)/det(sig2)^0.5 * exp(-(X-mui2)*sig2^-1*(X-mui2)'/2);
    P3_pri(i) = 1/sqrt(2*pi)/det(sig3)^0.5 * exp(-(X-mui3)*sig3^-1*(X-mui3)'/2);
    P1_post(i) = P1_pri(i)*P_c1;
    P2_post(i) = P2_pri(i)*P_c2;
    P3_post(i) = P3_pri(i)*P_c3;
    P1_post(i) = P1_post(i)/(P1_post(i) + P2_post(i) + P3_post(i));
    P2_post(i) = P2_post(i)/(P1_post(i) + P2_post(i) + P3_post(i));
    P3_post(i) = P3_post(i)/(P1_post(i) + P2_post(i) + P3_post(i));
    [~,G_LE(i)] = max([P1_post(i),P2_post(i),P3_post(i)]);
    l1(i) = A(1,1) * P1_post(i) + A(1,2) * P2_post(i) + A(1,3) * P3_post(i);
    l2(i) = A(2,1) * P1_post(i) + A(2,2) * P2_post(i) + A(2,3) * P3_post(i);
    l3(i) = A(3,1) * P1_post(i) + A(3,2) * P2_post(i) + A(3,3) * P3_post(i);
    [~,G_LR(i)] = min([l1(i),l2(i),l3(i)]);
    if G_LE(i) ~= 2
        er2_LE = er2_LE + 1;
    end
    if G_LR(i) ~= 2
        er2_LR = er2_LR + 1;
        if G_LR(i) == 1
            c2 = c2 + 6;
        else
            c2 = c2 + 4;
        end
    end
end

for i = 1:50
    X = Test3(i,:);
    P1_pri(i) = 1/sqrt(2*pi)/det(sig1)^0.5 * exp(-(X-mui1)*sig1^-1*(X-mui1)'/2);
    P2_pri(i) = 1/sqrt(2*pi)/det(sig2)^0.5 * exp(-(X-mui2)*sig2^-1*(X-mui2)'/2);
    P3_pri(i) = 1/sqrt(2*pi)/det(sig3)^0.5 * exp(-(X-mui3)*sig3^-1*(X-mui3)'/2);
    P1_post(i) = P1_pri(i)*P_c1;
    P2_post(i) = P2_pri(i)*P_c2;
    P3_post(i) = P3_pri(i)*P_c3;
    P1_post(i) = P1_post(i)/(P1_post(i) + P2_post(i) + P3_post(i));
    P2_post(i) = P2_post(i)/(P1_post(i) + P2_post(i) + P3_post(i));
    P3_post(i) = P3_post(i)/(P1_post(i) + P2_post(i) + P3_post(i));
    [~,G_LE(i)] = max([P1_post(i),P2_post(i),P3_post(i)]);
    l1(i) = A(1,1) * P1_post(i) + A(1,2) * P2_post(i) + A(1,3) * P3_post(i);
    l2(i) = A(2,1) * P1_post(i) + A(2,2) * P2_post(i) + A(2,3) * P3_post(i);
    l3(i) = A(3,1) * P1_post(i) + A(3,2) * P2_post(i) + A(3,3) * P3_post(i);
    [~,G_LR(i)] = min([l1(i),l2(i),l3(i)]);
    
    if G_LE(i) ~= 3
        er3_LE = er3_LE + 1;
    end
    if G_LR(i) ~= 3
        er3_LR = er3_LR + 1;
        if G_LR(i) == 1
            c3 = c3 + 4;
        else
            c3 = c3 + 3;
        end
    end
end
C = (c1 + c2 + c3)/150;