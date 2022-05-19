%% LFT Model of 3-DOF Robotic Manipulator
%% Identified parameters
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
%% Grid state space
load  ref_large_fil_raw.mat
q2orig = q2; %ref2;
q3orig = q3; %ref3;

traj = char('msfiltered70000'); %invdyn_2dof_inf_traj
Ts   = 0.001;
ti   = 30001;  %20000;
te   = 43000;      %90000;
time = time(ti:te);

%convert to radian
%convert from rady to fixed
q2=(q2orig(ti:te));
q3=(-90+(q2orig(ti:te)+q3orig(ti:te)));

%filter and generate derivatives
[Bf, Af] = butter(1,10/(.5/Ts),'low');
q2 = filtfilt(Bf, Af, q2);
q3 = filtfilt(Bf, Af, q3);
qd2= derv1(Ts,q2);
qd3= derv1(Ts,q3);

qgriddensity = pi/16;

qorig_bnd{1} = [ -30      30     ];%[ -45      45     ];
qorig_bnd{1} = [ -180    180     ];%[ -45      45     ];
qorig_bnd{2} = [ -30      30     ];%[ -45      45     ];
qorig_bnd{3} = [  45     135     ];%[  45      132    ]- [90 90];

[qr, qrd, qrdd, qr_bnd, qrd_bnd, t] = TrajectoryGeneration();
% qorig_bnd{1} = qr_bnd(1, :);
% qorig_bnd{2} = qr_bnd(2, :);
% qorig_bnd{3} = qr_bnd(3, :);

qbounds{1} = qorig_bnd{1}*pi/180; %[ -pi      pi     ];
qbounds{2} = qorig_bnd{2}*pi/180; %[ -pi/16   3*pi/16];
qbounds{3} = (qorig_bnd{3} + qorig_bnd{2} - [90 90])*pi/180; %[ -pi/4    3/8*pi ];
        
qgridvector{1}   = [ qbounds{1}(1):qgriddensity:qbounds{1}(2) ];
qgridvector{2}   = [ qbounds{2}(1):qgriddensity:qbounds{2}(2) ];
qgridvector{3}   = [ qbounds{3}(1):qgriddensity:qbounds{3}(2) ];

qdgriddensity = pi/16;

qdbounds{1} = [ -100        80   ]*pi/180;
qdbounds{2} = [ -100        80   ]*pi/180;
qdbounds{3} = [ -120        180  ]*pi/180;

% qdbounds{1} = qrd_bnd(1, :)*pi/180;
% qdbounds{2} = qrd_bnd(2, :)*pi/180;
% qdbounds{3} = qrd_bnd(3, :)*pi/180;
        
qdgridvector{1}   = [ qdbounds{1}(1):qdgriddensity:qdbounds{1}(2) ];
qdgridvector{2}   = [ qdbounds{2}(1):qdgriddensity:qdbounds{2}(2) ];
qdgridvector{3}   = [ qdbounds{3}(1):qdgriddensity:qdbounds{3}(2) ];

qgrid = combvec(qgridvector{2}, qgridvector{3}, qdgridvector{1}, qdgridvector{2}, qdgridvector{3});