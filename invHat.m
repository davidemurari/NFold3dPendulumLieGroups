function u = invHat(A)
    %This returns the 3x1 vector u such that hat(u) = A
    
    u = zeros(3,1);
    u(1) = -A(2,3);
    u(2) = A(1,3);
    u(3) = -A(1,2);

end