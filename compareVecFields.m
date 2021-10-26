clear all;
close all;

P = 4;

getq = @(v) extractq(v);
getw = @(v) extractw(v);

maa = 0;

for cc = 1:5000
    
    L = rand(P,1)+0.5; 
    m = rand(P,1)+0.5;
    
    Energy = @(q,w) 0.5*w'*assembleR(q,L,m)*w + potential(q,L,m);
    
    [q,w,z] = initializeSE3N(P);

    f = @(v) fManiToAlgebra(getq(v),getw(v),L,m); 

    ff = f(z);

    vec = zeros(6*P,1);

    for i = 1:P

       vec(6*i-5:6*i) = [hat(ff(6*i-5:6*i-3))*z(6*i-5:6*i-3); ...
                           hat(ff(6*i-2:6*i))*z(6*i-5:6*i-3)];
    end

    z = [extractq(z);extractw(z)];
    refVec = reorder([FuncQ(z);FuncW(z,L,m)]);

    maa = maa + norm(refVec-vec,2);
end

maa/5000