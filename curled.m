function a = curled(q) %Gives a "measure" of how concentrated in a point are the pendulums

    P = length(q(:,1))/3;
    l = length(q(1,:));
    a = zeros(1,l);
        
    for k = 1:l
        
        for i = 1:P
            b = norm(q(3*i-2:3*i,k),2);
            if b>a(k)
                a(k) = b;
            end

        end
        
        
    end

end