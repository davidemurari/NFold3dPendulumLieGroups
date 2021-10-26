function vv = genInf(f,z)

    vv = zeros(length(z),1);
    P = length(z)/6;
    
    a = f(z);
    
    for i = 1:P
        vv(6*i-5:6*i-3) = hat(a(6*i-5:6*i-3))*z(6*i-5:6*i-3);
        vv(6*i-2:6*i) = hat(a(6*i-2:6*i))*z(6*i-5:6*i-3);
    end

end