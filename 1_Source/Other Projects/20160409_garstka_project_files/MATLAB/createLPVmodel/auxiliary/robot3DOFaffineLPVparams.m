function thetaVector = robot3DOFaffineLPVparams(rho)


q2  = rho(:, 1);
q3  = rho(:, 2);
qd1 = rho(:, 3);
qd2 = rho(:, 4);
qd3 = rho(:, 5);


b = [0.470091599453794;0.109418341915402;0.0150755236825785;0.0591418047608331;0.0626075441704894;0.0228908011151473;-0.00539850284850664;-0.00514026909942715;0.00973817158587389;0.774105191257197;0.234459645047533;0.0730925725604626;0.199116392744754;0.0602523168574383;0.721817144288153;0.103275065307657;0.0906152329636370]';
b1  = b(1);
b2  = b(2);
b3  = b(3);
b4  = b(4);
b5  = b(5);
b6  = b(6);
b7  = b(7);
b8  = b(8);
b9  = b(9);
b10 = b(10);
b11 = b(11);
b12 = b(12);
b13 = b(13);
b14 = b(14);
b15 = b(15);
b16 = b(16);
b17 = b(17);

v1 = (b6.*cos(q2).^2 + b7.*cos(q3).^2 + b5 + b3.*sin(q2).*sin(q3));
v2 = ((b3.^2.*(cos(q2).*cos(q3) + sin(q2).*sin(q3)).^2)./2 + 2.*b17.*b3.*(cos(q2).*cos(q3) + sin(q2).*sin(q3)) - 2.*b13.*b16 + 2.*b14.*b17);

% A Matrix
theta01 = -(b1 + b2.*qd2.*cos(q2).*sin(q2) + b3.*qd2.*cos(q2).*sin(q3) + b3.*qd3.*cos(q3).*sin(q2) + b4.*qd3.*cos(q3).*sin(q3))./v1;
theta02 =  (2.*b16.*b8.*sinc(q2/pi))./v2;
theta03 = -(2.*b9.*(b14 - b16) + b3.*b9.*(cos(q2).*cos(q3) + sin(q2).*sin(q3))).*sinc(q3/pi)./v2;
theta04 = -(b12.*qd1.*2.*sin(q3).*cos(q3).*(2.*b14 - 2.*b16) - (b3.^2.*qd1.*(cos(q2).*cos(q3) + sin(q2).*sin(q3)).*(sin(q2).*cos(q3) + cos(q2).*sin(q3)))./4 + (b14.*b3.*qd1.*(sin(q3).*cos(q2) - cos(q3).*sin(q2)))./2 + (b3.^2.*qd1.*(cos(q2).*cos(q3) + sin(q2).*sin(q3)).*(sin(q3).*cos(q2) - cos(q3).*sin(q2)))./4 + b3.*qd1.*(sin(q2).*cos(q3) + cos(q2).*sin(q3)).*(b14./2 - b17) - 2.*b11.*b16.*qd1.*(2.*sin(q2).*cos(q2)) + b12.*b3.*qd1.*(cos(q2).*cos(q3) + sin(q2).*sin(q3)).*(2.*sin(q3).*cos(q3)))./v2;
theta05 =  (2.*b10.*b16 + 2.*b14.*b15 + b15.*b3.*(cos(q2).*cos(q3) + sin(q2).*sin(q3)) - (b3.^2.*qd2.*(cos(q2).*cos(q3) + sin(q2).*sin(q3)).*(sin(q3).*cos(q2) - cos(q3).*sin(q2)))./2 - b3.*qd2.*(sin(q3).*cos(q2) - cos(q3).*sin(q2)).*(b14 - b16))./v2;
theta06 = -(2.*b14.*b15 + b15.*b3.*(cos(q2).*cos(q3) + sin(q2).*sin(q3)) + b16.*b3.*qd3.*(sin(q3).*cos(q2) - cos(q3).*sin(q2)))./v2;
theta07 = -(2.*b17.*b8 + b3.*b8.*(cos(q2).*cos(q3) + sin(q2).*sin(q3))).*sinc(q2/pi)./v2;
theta08 =  (b9.*(2.*b13 - 2.*b17)).*sinc(q3/pi)./v2;
theta09 = -((b3.*qd1.*(sin(q2).*cos(q3) + cos(q2).*sin(q3)).*(b13 - 2.*b17))./2 - b12.*qd1.*(2.*sin(q3).*cos(q3)).*(2.*b13 - 2.*b17) - (b3.^2.*qd1.*(cos(q2).*cos(q3) + sin(q2).*sin(q3)).*(sin(q2).*cos(q3) + cos(q2).*sin(q3)))./4 + (b13.*b3.*qd1.*(sin(q2).*cos(q3) - cos(q2).*sin(q3)))./2 + (b3.^2.*qd1.*(cos(q2).*cos(q3) + sin(q2).*sin(q3)).*(sin(q2).*cos(q3) - cos(q2).*sin(q3)))./4 + 2.*b11.*b17.*qd1.*(2.*sin(q2).*cos(q2)) + b11.*b3.*qd1.*(cos(q2).*cos(q3) + sin(q2).*sin(q3)).*(2.*sin(q2).*cos(q2)))./v2;
theta10 = -(2.*b10.*b17 + 2.*b13.*b15 + b3.*(cos(q2).*cos(q3) + sin(q2).*sin(q3)).*(b10 + b15) + b3.*qd2.*(sin(q2).*cos(q3) - cos(q2).*sin(q3)).*(b13 - b17))./v2;
theta11 =  (2.*b13.*b15 + b15.*b3.*(cos(q2).*cos(q3) + sin(q2).*sin(q3)) - b17.*b3.*qd3.*(sin(q2).*cos(q3) - cos(q2).*sin(q3)) - (b3.^2.*qd3.*(cos(q2).*cos(q3) + sin(q2).*sin(q3)).*(sin(q2).*cos(q3) - cos(q2).*sin(q3)))./2)./v2;
 
% B Matrix
theta12 =  1./v1;
theta13 = -(2.*b16)./v2;
theta14 =  (2.*b14 + b3.*(cos(q2).*cos(q3) + sin(q2).*sin(q3)))./v2;
theta15 =  (2.*b17 + b3.*(cos(q2).*cos(q3) + sin(q2).*sin(q3)))./v2;
theta16 = -(2.*b13 + b3.*(cos(q2).*cos(q3) + sin(q2).*sin(q3)))./v2;

thetaVector = [theta01 theta02 theta03 theta04 theta05 theta06 theta07 theta08 theta09 theta10 theta11 theta12 theta13 theta14 theta15 theta16]';