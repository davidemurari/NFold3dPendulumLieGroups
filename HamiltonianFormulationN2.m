clear all;
close all;

P = 2;

L = rand(P,1)+0.5; 
m = rand(P,1)+0.5;

t0 = 0;
T = 3;
N = 1000;
time = linspace(t0,T,N);
dt = time(2)-time(1);

action = @(B,input) actionSE3N(B,input); 
vecField = @(sigma,p) dexpinvSE3N(sigma,f(action(exponentialSE3N(sigma),p))); 

%Initializations
q10 = rand(3,1);
q10 = q10/norm(q10,2);
q20 = rand(3,1);
q20 = q20/norm(q20,2);

R = @(q1,q2) [(m(1)+m(2))*L(1)^2 *eye(3) , -m(2)*L(1)*L(2)*hat(q1)*hat(q2);
               -m(2)*L(1)*L(2)*hat(q2)*hat(q1), m(2)*L(2)^2*eye(3)];

v10 = rand(3,1);
w10 = hat(q10)*v10;
v20 = rand(3,1);
w20 = hat(q10)*v20;

pi = R(q10,q20) * [w10; w20];
p10 = pi(1:3);
p20 = pi(4:6);

z0 = [q10;p10;q20;p20];

g = 9.81;
e3 = [0;0;1];

get1 = @(z) z(1:3);
get2 = @(z) z(4:6);
getw = @(v) R(v(1:3),v(7:9))\[v(4:6);v(10:12)];
w1 = @(v) get1(getw(v));
w2 = @(v) get2(getw(v));
U = @(v) (m(1)+m(2))*g*L(1)*e3'*v(1:3) + m(2)*g*L(2)*e3'*v(7:9);   
dU = [(m(1)+m(2))*g*L(1)*e3; m(2)*g*L(2)*e3];
Hq = @(v) m(2)*L(1)*L(2)*[hat(hat(v(7:9))*w2(v))*w1(v) + ...
                            hat(v(7:9))*hat(w1(v))*w2(v);
                       hat(v(1:3))*hat(w2(v))*w1(v) + ...
                        hat(hat(v(1:3))*w1(v))*w2(v)];

u1 = @(v) get1(getw(v)); %since the Pi derivative of H is R(q)Pi = R(q)Rinv(q)w  = w.
u2 = @(v) get2(getw(v));
v1 = @(v) get1(dU + Hq(v));
v2 = @(v) get2(dU + Hq(v));

f = @(v) [u1(v) ;  v1(v) ; u2(v) ; v2(v)];

H = @(v) 0.5 * [v(4:6); v(10:12)]' * getw(v) + U(v);



sol = zeros(6*P,N);
energy = zeros(1,N);
q = zeros(3*P,N);
sol(:,1) = z0;
energy(1) = H(z0);

Len = zeros(3*P,1);
for i = 1:P
    Len(3*i-2:3*i) = L(i)*ones(3,1);
end
Mat = diag(Len);
if P>1
    for i = 3:3:3*(P-1)
        Mat = Mat + diag(Len(1:3*P-i),-i);
    end
end

q(:,1) = Mat*[q10;q20];


for i = 1:N-1
        sol(:,i+1) = FreeRK4SE3N(f,action,dt,sol(:,i)); 
        energy(i+1) = H(sol(:,i+1));
        q(:,i+1) = Mat*extractq(sol(:,i+1));
end

figure;
for i = 1:N

    plot3([0,q(1,i)],[0,q(2,i)],[0,q(3,i)],'r-*',...
        [q(1,i),q(4,i)],[q(2,i),q(5,i)],[q(3,i),q(6,i)],...
         'k-o','Markersize',4);

    str = "Time evolution of the pendulum, current time t = "+string(time(i));
    axis([-sum(L) sum(L) -sum(L) sum(L) -sum(L) sum(L)]);
    title(str)
    pause(0.00000000001);
end

figure;
plot(time,energy,'r-*');