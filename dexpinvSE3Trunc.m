function vec = dexpinvSE3Trunc(sigma, g)
    %compute the dexpinvSE3((hat(g11),g12),(hat(g21),g22)))
    %stopping at 3rd coefficient
    
    sigma1 = sigma(1:3);
    sigma2 = sigma(4:6);
    
    g1 = g(1:3);
    g2 = g(4:6);
    
    comm = adjointSE3(sigma1,sigma2,g1,g2);
    comm1 = adjointSE3(sigma1,sigma2,comm(1:3),comm(4:6));
    vec = [g1;g2] - 0.5 * comm + ...
        + 1/12 * comm1;
    
    
    
end