randn('seed',0);
Test1 = mvnrnd(mui1,sig1^2,50);
randn('seed',0);
Test2 = mvnrnd(mui2,sig2^2,50);
randn('seed',0);
Test3 = mvnrnd(mui3,sig3^2,50);
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
    if Test1(i) > -4.29 && Test1(i) < -2.85
        er1_LE = er1_LE + 1;
    elseif Test1(i) > 2.85 && Test1(i) < 4.29
        er1_LE = er1_LE + 1;
    end
    
    if Test1(i) > -5.08 && Test1(i) < -1.89
        er1_LR = er1_LR + 1;
        c1 = c1 + 1;
    elseif Test1(i) > 2.06 && Test1(i) < 4.95
        er1_LR = er1_LR + 1;
        c1 = c1 + 1;
    end
    
    if Test2(i) < -4.29 || Test2(i) > -2.85hhh
        er2_LE = er2_LE + 1;
    end
    if Test2(i) < -5.08 || Test2(i) > -1.89
        er2_LR = er2_LR + 1;
        c2 = c2 + 6;
    end
    
    if Test3(i) < 2.85 || Test3(i) > 4.29
        er3_LE = er3_LE + 1;
    end
    if Test3(i) < 2.06 || Test3(i) > 4.95
        er3_LR = er3_LR + 1;
        c3 = c3 + 4;
    end
end
Ac = (c1 + c2 + c3)/150;
