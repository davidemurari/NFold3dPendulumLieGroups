function [q0,w0,z0] = initializeSE3N_smallVariation(N)

    %Initializes the starting point of the integration in such a way that
    %it is nearer to the stable equilibrium point of the system than the
    %one obtained with initializeSE3N_largeVariation(N)

    w0 = [0;0;0];
    q0 = w0;
    z0 = zeros(6*N,1);
    
    a = pi/20;
    qref = [sin(a);0;-cos(a)];
    
    for i = 1:N
        z0(6*i-5:6*i) = [qref;w0];
    end
    
    q0 = extractq(z0);
    w0 = extractw(z0);
        
end