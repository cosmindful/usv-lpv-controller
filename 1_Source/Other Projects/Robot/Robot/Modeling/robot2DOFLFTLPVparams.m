function deltaVector = robot2DOFLFTLPVparams(q, qd)

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

delta1  = cos(-q2+q3);
delta2  = sin(-q2+q3);
delta3  = qd2;
delta4  = qd3;
delta5  = sinc(q2/pi);
delta6  = sinc(q3/pi);

deltaVector  = [delta1; delta2; delta3; delta4; delta5; delta6];