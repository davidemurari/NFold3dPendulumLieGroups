function vec = FuncWedit(f,z)
    
    z = reorder(z);
    P = length(z)/6;
    vec = zeros(3*P,1);
    
    g = f(z);
    
    for i = 1:P
        vec(3*i-2:3*i) = hat(g(6*i-2:6*i))*z(6*i-5:6*i-3);
    end
end