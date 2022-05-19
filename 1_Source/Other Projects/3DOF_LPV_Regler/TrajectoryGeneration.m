%% Trajectory Generation
function [qr, qrd, qrdd, qr_bnd, qrd_bnd, time] = TrajectoryGeneration()


Ts     = 0.001;
Tend   = 10;
Tstart = 0;
t      = Tstart:Ts:Tend;
t_zero = 0:Ts:(1-Ts);

qr1_bnd = [ -170    170     ];
qr1_bnd = [ -90      90     ];%[ -45      45     ];
qr2_bnd = [ -40      40     ];%[ -45      45     ];
qr3_bnd = [ -10     135     ];
qr3t_bnd = qr2_bnd + qr3_bnd - [90 90];
qr1_range = qr1_bnd(2) - qr1_bnd(1);
qr2_range = qr2_bnd(2) - qr2_bnd(1);
qr3_range = qr3_bnd(2) - qr3_bnd(1);

qr1 =  ((qr1_range/2 - qr1_range/5 - qr1_range/10)*sin(2*pi/(Tend-Tstart) * 1*t) + (qr1_range/5)*sin(2*pi/(Tend-Tstart) * 4*t));
qr2 =  ((qr2_range/2 - qr2_range/3)*sin(2*pi/(Tend-Tstart) * 6*t) + (qr2_range/3)*sin(2*pi/(Tend-Tstart) * 8*t));
qr3 = -((qr3_range/2 - qr3_range/3)*sin(2*pi/(Tend-Tstart) * 3*t) + (qr3_range/3)*sin(2*pi/(Tend-Tstart) * 8*t)) + ((qr3_range/3)*sin(2*pi/(Tend-Tstart) * 0.5*t));
qr3t = qr2 + qr3;
% qr1 = 20*sin(2*pi/(Tend-Tstart) * t) + 10*sin(2*pi/(Tend-Tstart) * 5*t);

qr1(qr1 > qr1_bnd(2)) = qr1_bnd(2);
qr1(qr1 < qr1_bnd(1)) = qr1_bnd(1);
qr2(qr2 > qr2_bnd(2)) = qr2_bnd(2);
qr2(qr2 < qr2_bnd(1)) = qr2_bnd(1);
qr3(qr3 > qr3_bnd(2)) = qr3_bnd(2);
qr3(qr3 < qr3_bnd(1)) = qr3_bnd(1);

qr_zero = zeros(1, length(t_zero));
qr1 =  [qr_zero, qr1, qr_zero];
qr2 =  [qr_zero, qr2, qr_zero];
qr3 =  [qr_zero, qr3, qr_zero];
qr3t =  [qr_zero, qr3t, qr_zero];
t   = 0:Ts:(Tend+2);
qr4 =  zeros(1, length(t));
qr5 =  zeros(1, length(t));
qr6 =  zeros(1, length(t));

[Bf, Af] = butter(1, 10/(5/Ts), 'low');
qr1 = filtfilt(Bf, Af, qr1);
qr2 = filtfilt(Bf, Af, qr2);
qr3 = filtfilt(Bf, Af, qr3);
qrd3t = filtfilt(Bf, Af, qr3t);
qrd1  = derv1(Ts, qr1);
qrd2  = derv1(Ts, qr2);
qrd3  = derv1(Ts, qr3);
qrd3t = derv1(Ts, qr3t);
qrd4  = derv1(Ts, qr4);
qrd5  = derv1(Ts, qr5);
qrd6  = derv1(Ts, qr6);

qrdd1  = derv1(Ts, qrd1);
qrdd2  = derv1(Ts, qrd2);
qrdd3  = derv1(Ts, qrd3);
qrdd3t = derv1(Ts, qrd3t);
qrdd4  = derv1(Ts, qrd4);
qrdd5  = derv1(Ts, qrd5);
qrdd6  = derv1(Ts, qrd6);

qr1_bnd(1) = min(qr1);
qr1_bnd(2) = max(qr1);
qr2_bnd(1) = min(qr2);
qr2_bnd(2) = max(qr2);
qr3_bnd(1) = min(qr3);
qr3_bnd(2) = max(qr3);
qr3t_bnd(1) = min(qr3t);
qr3t_bnd(2) = max(qr3t);
qrd1_bnd(1) = min(qrd1);
qrd1_bnd(2) = max(qrd1);
qrd2_bnd(1) = min(qrd2);
qrd2_bnd(2) = max(qrd2);
qrd3_bnd(1) = min(qrd3);
qrd3_bnd(2) = max(qrd3);
qrd3t_bnd(1) = min(qrd3t);
qrd3t_bnd(2) = max(qrd3t);

qr   = [qr1'  , qr2'  , qr3'  , qr4'  , qr5'  , qr6'  ];
qrd  = [qrd1' , qrd2' , qrd3' , qrd4' , qrd5' , qrd6' ];
qrdd = [qrdd1', qrdd2', qrdd3', qrdd4', qrdd5', qrdd6'];
time = t';

qr_bnd = [qr1_bnd  ;...
          qr2_bnd  ;...
          qr3_bnd ];
      
qrd_bnd = [qrd1_bnd  ;...
           qrd2_bnd  ;...
           qrd3_bnd ];

% subplot(3,1,1)
% plot(t, qr1)
% subplot(3,1,2)
% plot(t, qr2)
% subplot(3,1,3)
% plot(t, qr3)

function der1=derv1(T,q);
    n=length(q);
    for i=2:n-1
        d(i)=(q(i+1)-q(i-1))/(2*T);
    end
    d(1)=d(2);
    d(n)=d(n-1);
    der1=d';

