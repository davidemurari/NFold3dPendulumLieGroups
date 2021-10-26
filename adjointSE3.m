function vec = adjointSE3 (a,b,c,d)

    A = [hat(a), b; zeros(1,3), 0];
    B = [hat(c), d; zeros(1,3), 0];
    
    C = A*B-B*A;
    
    u = invHat(C(1:3,1:3));
    v = C(1:3,end);
    
    vec = [u;v];

