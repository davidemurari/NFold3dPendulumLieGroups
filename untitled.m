clc;
clear all;
close all;

N = 5000;
ss = 0;

for i = 1:N
    
    q = rand(3,1);
    q = q/norm(q,2);
    v = rand(3,1);
    w = hat(q)*v;
    input = [q;w];
    
    u = rand(3,1);
    v = rand(3,1);
    B = expSE3([u;v]);
    
    c = actionSE3(B,input);
    qc = c(1:3);
    wc = c(4:6);
    
    ss = ss + (wc'*qc);
    
end

ss/N
