function deltaVector = robot3DOFLFTLPVparams(rho)

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

delta1  = cos(q2);
delta2  = cos(q3);
delta3  = sin(q2);
delta4  = sin(q3);
delta5  = qd1;
delta6  = qd2;
delta7  = qd3;
delta8  = sinc(q2/pi);
delta9  = sinc(q3/pi);

deltaVector  = [delta1 delta2 delta3 delta4 delta5 delta6 delta7 delta8 delta9]';