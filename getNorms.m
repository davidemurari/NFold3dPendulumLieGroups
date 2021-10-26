function v = getNorms(z)

    %It just computes the norms of the qs, so the output is going to be a
    %matrix v where in each row we have the norm, at any time instant, of a
    %a certain qi.
    
    %The way in which the solution is stored in z is that at each column we
    %have all the values [q1,w1,...,qN,wN] at a specific time step.

    N = length(z(:,1))/6; %Number of connected pendulums
    l = length(z(1,:)); %Number of time steps
    
    v = zeros(N,l);
    
    for i = 1:N
        v(i,:) = vecnorm(z(6*i-5:6*i-3,:));
    end

%     for i = 1:N
%         for j = 1:l
%             v(i,j) = 1-z(6*i-5:6*i-3,j)'*z(6*i-5:6*i-3,j);
%         end
%     end

      

end