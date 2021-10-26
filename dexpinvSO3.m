function A = dexpinvSO3(v,input)

    %both v and input are 3x1 vectors corresponding to elements in so(3) 
    B = hat(v);
    alpha = norm(v,2);
    tol = 1e-20;
    
    if alpha>tol
        func = ( 1-alpha * cot(alpha/2)/2 )/(alpha^2);
        dexpinvB = eye(3) - 0.5 * B + func*B*B;
    else
        funclow = 1/12 + alpha^2/720 + alpha^4/(30240);
        dexpinvB = eye(3)-0.5 * B + funclow*B*B;
    end
        
    A = dexpinvB * input;
end