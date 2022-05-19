function theta = thetaOfrho(rho)

q2  = rho(1);
q3  = rho(2);
qd2 = rho(3);
qd3 = rho(4);

%define the identified dynamic parameters (no coulomb)
b1=0.0715;
b2=0.0058;
b3=0.0114;
b4=0.3264;
b5=0.3957;
b6=0.6253;
b7=0.0749;
b8=0.0705;
b9=1.1261;
b=[b1;b2;b3;b4;b5;b6;b7;b8;b9]';

%define the scheduling parameters
v = b7*b1+b7*cos(-q2+q3)*b3-b2*cos(-q2+q3)*b3+b2*b8-cos(-q2+q3)^2*b3^2+cos(-q2+q3)*b3*b8;

theta1  = 1/v;
theta2  = qd2*sin(-q2+q3)/v;
theta3  = cos(-q2+q3)/v;
theta4  = qd2*cos(-q2+q3)*sin(-q2+q3)/v;
theta6  = qd3*sin(-q2+q3)/v;
theta10 = qd3*cos(-q2+q3)*sin(-q2+q3)/v;

if q2 == 0
    theta5 = 1/v;
else
    theta5 = sin(q2)/q2/v;
end

if q3 == 0
    theta7 = 1/v;
else
    theta7 = sin(q3)/q3/v;
end

if q3 == 0
    theta8 = cos(-q2+q3)/v;
else
    theta8 = sin(q3)/q3*cos(-q2+q3)/v;
end

if q2 == 0
    theta9 = cos(-q2+q3)/v;
else
    theta9 = sin(q2)/q2*cos(-q2+q3)/v;
end

theta = [theta1;...
         theta2;...
         theta3;...
         theta4;...
         theta5;...
         theta6;...
         theta7;...
         theta8;...
         theta9;...
         theta10];
    