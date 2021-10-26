function a = variation(z) %Gives a "measure" of how fast is the solution changing

    l = length(z(1,:));
    a = zeros(1,l-1);
    for i = 1:l-1
        a(i) = norm((z(:,i+1)-z(:,i)),inf);
    end
    

end