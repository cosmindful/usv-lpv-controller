function thetaVector = robot2DOFaffineLPVparams(q, qd)

q2  =  q(2, :);
q3  =  q(3, :);
qd2 = qd(2, :);
qd3 = qd(3, :);

b1 = 0.0715;
b2 = 0.0058;
b3 = 0.0114;
b4 = 0.3264;
b5 = 0.3957;
b6 = 0.6253;
b7 = 0.0749;
b8 = 0.0705;
b9 = 1.1261;
b  = [b1;b2;b3;b4;b5;b6;b7;b8;b9]';

delta1  = cos(-q2+q3); % cos(q3)*cos(q2) + sin(q3)*sin(q2)
delta2  = sin(-q2+q3); % sin(q3)*cos(q2) - sin(q2)*cos(q3)
delta3  = qd2;
delta4  = qd3;
delta5  = sinc(q2/pi);
delta6  = sinc(q3/pi);


v        = b7*b1 + b7*delta1*b3 - b2*delta1*b3 + b2*b8 -delta1.^2*b3^2 + delta1*b3*b8;
theta01  = 1./v;
theta02  = delta3.*delta2./v;
theta03  = delta1./v;
theta04  = delta3.*delta1.*delta2./v;
theta05  = delta5./v;
theta06  = delta4.*delta2./v;
theta07  = delta6./v;
theta08  = delta6.*delta1./v;
theta09  = delta5.*delta1./v;
theta10  = delta4.*delta1.*delta2./v;

thetaVector = [theta01; theta02; theta03; theta04; theta05; theta06; theta07; theta08; theta09; theta10];