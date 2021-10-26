function a = variation(z,dt) %Gives a "measure" of how fast is the solution changing

    a = zeros(1,l-1);
    for i = 1:l-1
        a(i) = norm(1/dt*(z(:,i+1)-z(:,i)),2);
    end
    

end