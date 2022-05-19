%% This file computes the qLPV controller w/ SFb (OFb no finished)
%
% We define the frequency range of interest for the design to be 0.01 rad/s
% to 1000 rad/s, mainly for convenience in plotting. Further some options
% for bodeplots are invoked.
clear all, clc
tic
w = {1e-6,1e3};
b = bodeoptions;
b.xlim = [1e-6 1e3];
b.ylim = [-1e2 1e2];
b.Grid = 'on';
% Let's first define the grid we want to use. It's spanned by the four
% parameters 'u', 'v', 'n' and 'delta', all of which are (of course) rate
% bounded.
toMpS = 0.51444;
toRad = pi/180;
toRPS = 1/60;
tic
disp('gridding...');
identifier = 'qLPV_data';
gridDensity = 3;
u      = linspace(1*toMpS,3.75*toMpS,gridDensity);%m/s backup
% u      = linspace(1*toMpS,15*toMpS,gridDensity);%m/s
v      = linspace(-1*toMpS,1*toMpS,gridDensity);%m/s
n      = linspace(10*toRPS,80*toRPS,gridDensity);%rps backup
% n      = linspace(10*toRPS,80*toRPS,gridDensity);%rps
delta  = linspace(-10*toRad,10*toRad,gridDensity);%rad

u  = pgrid('u',u,[-4*toMpS 4*toMpS]);%2.1 m/s
v  = pgrid('v',v,[-.1*toMpS .1*toMpS]);%1 m/s
n =  pgrid('n',n,[-2*toRPS 2*toRPS]);
delta = pgrid('delta',delta,[-2.33*toRad 2.33*toRad]);
dom = rgrid(u,v,n,delta);
toc
% Now we evaluate the affine LPV model from the nonlinear system and
% compute an LTI system for each value of the scheduling parameters
tic
disp('linearising...(this may take)');
modelType = 'Fossen';
[G_,countedRanks,badCombinations]      = getLinearShipsLPV(u.griddata,v.griddata,...
    n.griddata,delta.griddata);
toc
% This array is now combined with the underlying grid to form a
% parameter-dependent state space model
tic
disp('constructing pss');
Gp      = pss(G_,dom);
toc
% This pss object can be treated almost identical to an ss object, and we
% can perform tasks such as, e.g., bode or sigmaplots
tic
disp('plotting bode');
figure(1);clf
bodemag(Gp,b,w)
grid on
toc
tic
disp('plotting sigma');
figure(2);clf
sigma(Gp(1,:),'r',Gp(2,:),'b',w)
grid on
toc
% Furthermore we can manipulate the grid, with commands like
% lpvsplit, lpvinterp, ..
%% Initial Scaling
% Let's define the largest allowed input signals (in Nm)
umax = [80*toRPS -10*toRad];
% and the largest expected change in reference (in rad)
rmax = [15.5*toMpS 90*toRad];
% No both input and output are scaled with this values
Du = diag(umax);
Dr = diag(rmax);
G = Dr\Gp*Du;
% additionally, the system can be stored in order to save time in future
% save(fullfile(pwd,'Data',[modelType,'_',num2str(gridDensity),'_',identifier,date]));
% clear identifier

%% AUGMENTED STATE FEEDBACK DESIGN -Antonio
% S/KS closed-loop shaping filter design

% While we could use the parameterization from the ORC lecture
% notes and build the filters manually as tf objects, a build-in command
% that we can use is makeweight(dcgain, bandwidth, feedthroughgain).
% For W1, the dcgain determines our error constant, the bandwidth the speed
% of response and the feedthroughgain limits the peak of S
% create sensitivity filter
% attemmpts.............................
% ws1 = 9e-5; Ms1 = 1e-2;%9e-1,1e2
% ws2 = 9e-5; Ms2 = 1e-2;%9e-1,1e1
% ws1 = 1e-5; Ms1 = .01;%1e-5,.0001
% ws2 = 1e-5; Ms2 = .0001;%1e-5,.0004
% ws1 = 9e-1; Ms1 = 1e-2;%9e-5,1e-4
% ws2 = 9e-2; Ms2 = 1e-2;%9e-5,1e-4
% ws2 = 9e-0; Ms2 = 1e-1;%
% 
% ws1 = 9e2; Ms1 = .01;%9e2,.01 bigger, faster
% ws2 = 9e2; Ms2 = 6.5;%9e2,.65 bigger, faster

% ws1 = 9e-4; Ms1 = 0.00001;%9e2,.01 bigger, faster
% ws2 = 9e-5; Ms2 = 0.000065;%9e2,.65 bigger, faster

% ws1 = 9e-1; Ms1 = 0.0001;%9e2,.01 bigger, faster
% ws2 = 9e-3; Ms2 = 0.00065;%9e2,.65 bigger, faster
% ws1 = 0.04; Ms1 = 0.0001;% older
% ws2 = 0.00005; Ms2 = 0.0002;% older
% ws1 = 0.04; Ms1 = 0.000051;% backup
% ws2 = 0.00005; Ms2 = 0.0001;% backup

% ws1 = 0.3; Ms1 = 0.000031;% backup 2
% ws2 = 0.00003; Ms2 = 0.000041; % backup 2
% ws1 = 0.06; Ms1 = 0.000031;% best gamma/winning
% ws2 = 0.00001; Ms2 = 0.000041; % best gamma/winning
% ws1 = 9e-4; Ms1 = .01;%9e-4,.01 bigger, faster
% ws2 = 9e-5; Ms2 = .003;%9e-5,.003. bigger, faster but ss error

% ws1 = 9e2; Ms1 = 1;%9e-4,.01 bigger, faster
% ws2 = 9e-5; Ms2 = .03;%9e-5,.003. bigger, faster but ss error

% ws1 = 9e-5; Ms1 = 1e-2;% 9e-5,1e-2
% ws2 = 9e-5; Ms2 = 1e-2;% 9e-5,1e-2
%---------------------------------------------------------------------
ws1 = 0.06; Ms1 = 0.000031;% 
ws2 = 0.00001; Ms2 = 0.000041; % 
Ws1 = tf([ws1/Ms1],[1 ws1])
Ws2 = tf([ws2/Ms2],[1 ws2])
Ws1 = ss(Ws1); Ws2 = ss(Ws2);
WS  = mdiag(Ws1, Ws2);

% For W2, the dcgain determines available control effort, the bandwidth
% corresponds to the actuator rates and the feedthroughgain limits
% authority at high frequencies
% create control sensitivity filter 
% attemmpts.............................
% wk1 = 1e0; Mk1 = 9e-1;c1 = 1e3; %1e-1,9e-3,1e6
% wk2 = 1e0; Mk2 = 9e-1;c2 = 1e3; %1e-2,9e-3,1e6
% wk1 = 1e1; Mk1 = 9e3;c1 = 1e3; %1e0,9e-1,1e3
% wk2 = 1e1; Mk2 = 1e4;c2 = 1e3; %1e1,1e4,1e3

% wk1 = 0.1; Mk1 = 11000;c1 = 1e3; %backup
% wk2 = 0.01; Mk2 = 9000;c2 = 1e3; %backup
% wk1 = .1; Mk1 = 9000;c1 = 1e3; % backup 2
% wk2 = .01; Mk2 = 5000;c2 = 1e3; % backup 2

% wk1 = 0.1; Mk1 = 9000;c1 = 10; % best gamma
% wk2 = 0.09; Mk2 = 5100;c2 = 130; % best gamma

% wk1 = 0.1; Mk1 = 8997;c1 = 8; % winning
% wk2 = 0.09; Mk2 = 5000;c2 = 130; % wining

% wk1 = 1e-3; Mk1 = 9e8;c1 = 1e3; %1e1,9e3,1e3
% wk2 = 1e-3; Mk2 = 9e8;c2 = 1e3; %1e1,1e4,1e3

% wk1 = 1e1; Mk1 = 9e3;c1 = 1e3; %1e1,9e3,1e3
% wk2 = 1e1; Mk2 = 9e3;c2 = 1e3; %1e1,1e4,1e3

% wk1 = 1e0; Mk1 = 2e4;c1 = 1e3; %1e0,9e-1,1e3
% wk2 = 1e0; Mk2 = 8e2;c2 = 1e3; %1e0,9e-1,1e3
wk1 = 0.1; Mk1 = 8997;c1 = 8; % 
wk2 = 0.09; Mk2 = 5000;c2 = 130; %
Wk1  = c1/Mk1*tf([1 wk1],[1 c1*wk1])
Wk2  = c2/Mk2*tf([1 wk2],[1 c2*wk2])
Wk1 =ss(Wk1); Wk2 = ss(Wk2);
WK = mdiag(Wk1,Wk2);

% Generalized Plant formulation

% For our synthesis tools to work, we need to first assemble a generalized
% plant that includes our performance inputs/outputs.

% r-----------------+
%                   |
%          ------   v   ------
% u--+---->| G  |-->o-->| WS |--->e1
%    |     ------  -    ------
%    |                  ------
%    ------------------>| WK |--->e2
%                       ------
%
% A convinient way to do this is to use the sysic command
systemnames = 'G WS WK';
inputvar = '[r{2}; u{2}]';
outputvar = '[WS; WK]';
input_to_G = '[u]';
input_to_WS = '[r-G]';
input_to_WK = '[u]';
cleanupsysic = 'yes';
Psf = sysic;

% Verify that these leads to a state space representation
% |dx|   |A    B1   B2    |   |x|
% |e1| = |C11  DW1   0    | * |d|
% |e2|   |C12  0    DW2   |   |u|
%
Psf.Data(:,:,1)
% Synthesis LPV
%
% You know from class that a parameter-dependent Lyapunov matrix is less
% conservative since it takes rate variations into account. In order to
% arrive at a tractable formulation, we need to choose basis functions.
% There are no useful guidelines on how to do this other than trial and
% error. (Have a look at linearize_gyro to get a guess on the scheduling
% parameters). However, affine seems to be OK in most cases, so let's start
% with that. (We can try other basis functions later on)

% We define the basis functions in terms of the pgrid variables and need to
% provide their partial derivites with respect to the scheduling variables
% Pbasis = [];
Pbasis(1) = basis(1,0);
% Pbasis(2) = basis(u,'u',1);

% We can now run the synthesis code, which takes our generalized plant, the
% number of control signals and the basis function object and returns a
% state feedback gain F as well as the performance index gamma.
% The synthesis may take some time, since it's solving that large system of
% LMIs that you learned about in class.
[F,gam,info] = lpvsfsynth(ssbal(Psf),2,Pbasis);
% alternatively one can use the standard LPV synthesis function
% [F,gam,info] = lpvsyn(Psf,8,2);
gam
% The first thing that we should always check is whether everything worked
% fine. Even if we do not get an error message, could be mistakes made by
% us setting up the problem. So let's verify that the state feedback gain
% actually achieves stability and performance as it should.

% Let's first add the state outputs to our generalized plant and then form
% the closed-loop system by closing the loop with the gain F
P_aug = pss(Psf.a,Psf.b,[Psf.c; eye(8)], [Psf.d; zeros(8,4)]);

CL = lft(P_aug,F);

% Let's now verify that the closed loop is stable
LPVstab = double(lpvmin(isstable(CL)))
% and that the Hinfnorm at every gridpoint is less than our induced L2 norm
normOK = double(lpvmax(norm(CL,'inf')))<gam

fastestpole = max(abs(eig(F.a)))
%
% We first construct our unweighted closed loop, i.e., we reverse the
% weighting filters at the outputs.
uCL = mdiag(WS,WK)\CL;
S = uCL(1:2,:);
KS = uCL(3:4,:);
%% OUTPUT FEEDBACK SYNTHESIS - Not finished
%
% We add the 3rd and 4th state (v, r) to the outputs.
% The outputs are then u \\ psi \\ v \\ r \\.
Gv = pss(G.a,G.b,[G.c;zeros(2,1) eye(2) zeros(2,1)],[G.d;zeros(2)]);
Gv.StateName  = G.StateName;
Gv.OutputName = G.OutputName;
Gv.InputName  = G.InputName;

% W13, W14 and W14 are shaping filters for velocities. Remember that we are not
% tracking the velocities, but only q3 and q4.
% W11 = makeweight(1000, 10, 0.5);
% W12 = makeweight(1000, 10, 0.5);
% w11 = 9e-5; M11 = .01;%9e2,.01 bigger, faster
% w12 = 9e-5; M12 = .003;%9e2,.6. bigger, faster
w11 = 9e-3; M11 = .1;%9e2,.01 bigger, faster
w12 = 9e-3; M12 = .1;%9e2,.6. bigger, faster
w11 = 9e2; M11 = .01;%
w12 = 9e2; M12 = .65;%
W11 = ss(tf([w11/M11],[1 w11]));
W12 = ss(tf([w12/M12],[1 w12]));
W12 = 0.001;
W13 = 0.001;  
W14 = 0.001;
W1  = mdiag(W11,W12,W13,W14);

% W21 = makeweight(0.2, 25, 1000);
% W22 = makeweight(0.2, 25, 1000);
w21 = 1e1; Mk1 = 9e3;c1 = 1e3; %1e1,9e3,1e3
w22 = 1e1; Mk2 = 9e3;c2 = 1e3; %1e1,1e4,1e3
w21 = 1e0; Mk1 = 9e2;c1 = 1e3; %1e1,9e3,1e3
w22 = 1e0; Mk2 = 9e2;c2 = 1e3; %1e1,1e4,1e3
W21  = ss(c1/Mk1*tf([1 w21],[1 c1*w21]));
W22  = ss(c2/Mk2*tf([1 w22],[1 c2*w22]));
% W21 = .1;
% W22 = 3;
W2  = mdiag(W21,W22);

Wdi = 0.0002*eye(2);
Wdo = 0.0002*eye(4);


% Generalized Plant formulation

% For our synthesis tools to work, we need to first assemble a generalized 
% plant that includes our performance inputs/outputs. We use a four block
% problem that looks like this:
%
%      di          d0     r
%      |           |      |
%      |           |      | 
%    -----       -----    | 
%   | Wdi |     | Wdo |   |
%    -----       -----    |
%      |           |      +---------------> (v2) 
%      |           |      |
%      v   ------  v      v   ------
% u--+-o-->| Gv |->o-+----o-->| W1 |------------------> (e1)
%    |     ------ -  |        ------
%    |               |
%    |               +--------------------> (v1) 
%    |
%    |                      ------
%    +--------------------->| W2 |------------------->(e2)
%                           ------
%
% A convinient way to do this is to use the sysic command

systemnames = 'Wdi Wdo Gv W1 W2';
inputvar = '[ di{2}; do{4}; r{2}; u{2}]';
outputvar = '[W1; W2; Wdo-Gv; r]';
input_to_Gv = '[u+Wdi]';
input_to_Wdi = '[di]';
input_to_Wdo = '[do]';
input_to_W1 = '[r+Wdo(1:2)-Gv(1:2);-Wdo(3:4)+Gv(3:4)]';
input_to_W2 = '[u]';
cleanupsysic = 'yes';
P = sysic;
% systemnames = 'Gv W1 W2';
% inputvar = '[r{2}; u{2}]';
% outputvar = '[W1; W2; -Gv; r]';
% input_to_Gv = '[u]';
% input_to_W1 = '[r-Gv(1:2);Gv(3:4)]';
% input_to_W2 = '[u]';
% cleanupsysic = 'yes';
% P = sysic;    
% Verify that these leads to a state space representation
% |dx|   |A    B1    B2  |   |x|
% |e | = |C1   D11   D12 | * |d|
% |v |   |C2   D21   D22 |   |u|
P.Data(:,:,1)

% Synthesis LPV
%Xb = [];
clear Xb
clear Yb
Xb(1) = basis(1,0);
% Xb(2) = basis(u,'u',1);
% Xb(3) = basis(q2,'q2',1);
% Xb(4) = basis(q3,'q3',1);

Yb(1) = basis(1,0);

% We can now run the synthesis code, which takes our generalized plant, the
% number of measurement and control signals and the basis function object and returns a
% dynamic controller K as well as the performance index gamma.
% The synthesis may take some time, since it's solving that large system of
% LMIs that you learned about in class. 
% You can try Sedumi instead of LMI lab as a solver by passing
% lpvsynOptions('solver','sedumi') as a sixth argument to lpvsyn. Note that
% you have to install Sedumi beforehand (just google it). It might be a little faster but
% usually is very prone to numerical problems and we don't really recommend
% to use it.
% Also it is not a necessity for Yb to be the same as Xb. 

[nmeas,ncont] = size(Gv);
nmeas = nmeas + 2; % input added separately in 4 block design
tic
[K,gam,info] = lpvsyn(P,nmeas,ncont,Xb,Yb);
toc
gam

CL = lft(P,K);

% Let's now verify that the closed loop is stable
LPVstab = double(lpvmin(isstable(CL)))
% and that the Hinfnorm at every gridpoint is less than our induced L2 norm
normOK = double(lpvmax(norm(CL,'inf')))<gam

%% Controller Post-Processing
% With parameter-dependent Lyapunov matrices, the controller also depends
% on scheduling rates. Usually this dependence can simply be ignored,
% although again, any theoretical guarantees are lost in doing so. 
% For the current case, we would require w1dotdot, w2dot and w3dot.
% It's your decision whether you want to implement the rate dependence with
% differentiation filters of ignore it. If we want to neglect it, we can
% simply interpolate the controller for zero rates:
K_rate = K;
K = lpvelimiv(lpvinterp(K_rate,'u',0,'v',0,'n',0,'delta',0));

K.InputGroup.y = [1:5];
K.InputGroup.r = [6:7];
Ky = K(:,'y');
Kr = K(:,'r');

figure(6)
bodemag(K,b,w) 
fastestpole = max(double(lpvmax(abs(eig(K.a)))))

%% Linear Analysis: Frequency Response at Grid Points

%for state feedback
Gaug = pss(G.a,G.b,[G.c;eye(5)],0);

%this just builds the four transfer functions [SG S ; Ti KS]
systemnames = 'Gaug Ksf';
inputvar = '[di{2}; r{2}]';
outputvar = '[r-Gaug(1:2); Ksf]';
input_to_Gaug = '[di+Ksf]';
input_to_Ksf = '[r-Gaug(1:2);Gaug(3:7)]';
cleanupsysic = 'yes';
CL = sysic;

figure(7);clf 
subplot(2,2,1)
sigma(CL(1:2,3:4),pss(WS^-1),w)
title('S')
subplot(2,2,2)
sigma(CL(1:2,1:2),pss(WS^-1),w)
title('SG')
subplot(2,2,3)
sigma(CL(3:4,3:4),pss(WK^-1),w)
title('KS')
subplot(2,2,4)
sigma(CL(3:4,1:2),pss(WK^-1),w)
title('Ti')

% This looks nice, but we are really assuming PERFECT measurements of all
% states in the inner loop.

% For Output feedback
loops = loopsens(Gv,Ky);

figure(8);clf 
subplot(2,3,1)
sigma(lpvgetfield(loops,'So'),pss(W1^-1),w)
title('S')
subplot(2,3,2)
sigma(lpvgetfield(loops,'PSi'),pss(W1^-1),w)
title('SG')
subplot(2,3,4)
sigma(lpvgetfield(loops,'CSo'),pss(W2^-1),w)
title('KS')
subplot(2,3,5)
sigma(lpvgetfield(loops,'Ti'),pss(W2^-1),w)
title('Ti')

forwardS = lpvgetfield(loops,'PSi')*Kr;
subplot(2,3,3)
sigma(eye(2)-forwardS(1:2,:),pss(W1^-1),w)
title('I-SGKr')
subplot(2,3,6)
sigma(lpvgetfield(loops,'Si')*Kr,pss(W2^-1),w)
title('SiKr')

ShowAllFig([7 8])


%% Linear Analysis: Step Response at Grid Points

%Reference Following
figure(9);clf; 
SG = lpvgetfield(loops,'PSi');
step(SG(1:2,:)*K(:,6:7),10)             %this is SGKr

%Disturbance rejection
figure(10);clf; 
step(SG(1:2,:),10)                      %this is SG

%Reference Following
figure(11);clf; 
step(eye(2)-CL(1:2,3:4),10)             %this is I-S = T

%Disturbance rejection
figure(12);clf; 
step(-CL(1:2,1:2),10)                   %this is SG

ShowAllFig([9 10 ; 11 12])


%% Linear Analysis: Loop Margins at Grid Points

[~,~,~,~,~,~,MMIO]= loopmargin(Gv,Ky);

GM = lpvgetfield(MMIO,'GainMargin');
PM = lpvgetfield(MMIO,'PhaseMargin');
minGM = db(lpvmin(GM(2)))
minPM = min(lpvmin(PM(2)))


%% Save relevant data

clearvars -except WS WK F Du Dr toMpS toRad toRPS
thisdate = datestr(now,'yyyy-mm-dd_HH-MM');
save(fullfile(pwd,'B_Control\Data',['QLPV_data_',thisdate,'.mat']));
%%
% We can then plot these closed-loop shapes against the corresponding
% (scaled) weighting filters
tic
figure(3);clf
splot = subplot(2,1,1);
% sigma(S(1,:),'b',S(2,:),'k',S(3,:),'g',WS\gam,'r',{1e-5,1e+5});title('S')
sigma(S(1,:),'b',S(2,:),'k',WS\gam,'r',{1e-15,1e0});title('S');
axis([1e-15 1e0 -80 40])
% sigma(S(1,:),'b',WS\gam,'r',{1e-25,1e+25});title('S');
% legend('error_u','error_v','error_psi');
legend('error u','error psi');
grid on
% legend('error_psi-');
ksplot = subplot(2,1,2);
sigma(KS(1,:),'m',KS(2,:),'c',WK\gam,'r',{1e-15,1e15});title('KS')
axis([1e-15 1e15 -200 200])
% sigma(KS(1,:),'m',WK\gam,'r',{1e-25,1e25});title('KS')
legend('effort n','effort delta');
grid on
% set(findall(gcf,'type','line'),'linewidth',1.5)
% set(findall(gcf,'type','axes'),'FontSize',12)
toc