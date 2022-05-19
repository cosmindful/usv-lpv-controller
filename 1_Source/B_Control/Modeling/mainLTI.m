%% This files computes the LTI controller w/ OFb

% We define the frequency range of interest for the design to be 0.01 rad/s
% to 1000 rad/s, mainly for convenience in plotting. Further some options
% for bodeplots are invoked.
clear all, clc
tic
w = {1e-5,1e3};
b = bodeoptions;
b.xlim = [1e-5 1e3];
b.ylim = [-1e2 1e2];
b.Grid = 'on';
% Let's pick some values for the time-varying terms that would be
% representative for most use-case scenarios
toMpS = 0.51444;
toRad = pi/180;
toRPS = 1/60;
tic
disp('gridding...');
identifier = 'qLPV_data';
gridDensity = 7;
u      = 15*toMpS;%m/s
v      = 0;%m/s
n      = 80*toRPS;%rps
delta  = -1*toRad;%Rad
toc
% Now we construct the LTI state-space using the selected values of the
% varying paramters
tic
disp('linearising...(this may take)');
modelType = 'Fossen';
[Gp,countedRanks]      = getLinearShipsLTI(u,v,n,delta);
toc


figure(1)
bodemag(Gp,b,w)
figure(2)
sigma(Gp,w)
toc
% This pss object can be treated almost identical to an ss object, and we
% can perform tasks such as, e.g., bode or sigmaplots
% tic
% disp('plotting bode');
% figure(1);clf
% bodemag(Gp,b,w)
% toc
% tic
% disp('plotting sigma');
% figure(2);clf
% sigma(Gp,w)
% toc
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
% G = Gp;
% save(fullfile(pwd,'Data',[modelType,'_',num2str(gridDensity),'_',identifier,date]));
% clear identifier
%% AUGMENTED STATE FEEDBACK DESIGN
% S/KS closed-loop shaping filter design

% ws1 = 9e-5; Ms1 = 1e-2;%9e-5,1e-4
% ws2 = 9e-5; Ms2 = 1e-4;%9e-5,1e-41
ws1 = .00069; Ms1 = .01;%9e-4,.01 bigger, faster
ws2 = .00009; Ms2 = .005;%9e-5,.003. bigger, faster but ss error
Ws1 = tf([ws1/Ms1],[1 ws1])
Ws2 = tf([ws2/Ms2],[1 ws2])
W_S  = mdiag(Ws1, Ws2);

% wk1 = 1e1; Mk1 = 9000;c1 = 1e3; %1e0,9e-1,1e3
% wk2 = 1e1; Mk2 = 7000;c2 = 1e3; %1e0,9e-1,1e3
wk1 = 0.1; Mk1 = 100;c1 = 1e3; %1e1,9e3,1e3
wk2 = 0.1; Mk2 = 8000;c2 = 1e2; %1e1,1e4,1e3
Wk1  = c1/Mk1*tf([1 wk1],[1 c1*wk1])
Wk2  = c2/Mk2*tf([1 wk2],[1 c2*wk2])
W_K = mdiag(Wk1,Wk2);

% figure(3)
% subplot(211)
% sigma(W_S^-1)
% subplot(212)
% sigma(W_K^-1)

%% Generalized Plant formulation
%
% For our synthesis tools to work, we need to first assemble a generalized 
% plant that includes performance inputs/outputs that represent S and KS.
systemnames = 'G W_S W_K';
inputvar = '[w{2}; u{2}]';
input_to_G = '[u]';
input_to_W_S = '[w-G]';
input_to_W_K = '[u]';
outputvar = '[W_S; W_K; w-G]';
cleanupsysic = 'yes'; %this just deletes the temporary variables afterwards
P = sysic

% We can also use the command P = AUGW(G,W_S,W_K) [augment with weights] 
% to get our generalized plant. 
% P_verify = augw(G,W_S,W_K);
% figure(200)
% sigma(P,P_verify,w)   
% Make sure that your P and the P_verify look the same in the sigma plot
% shown in Figure 200

%% Synthesis

% We first get the number of available measurements and controls 
[nmeas,ncont] = size(G); 

% We can now run the synthesis code, which takes our generalized plant, the
% number of measured / control signals and returns a
% dynamic controller K as well as the performance index gamma.
% We use the 'lmi' formulation here, which is what is taught in class.

% Further we apply a balancing transformation to the generalized plant to
% help preventing numerical issues and further perform a suboptimal
% synthesis. We can get a suboptimal controller with a specified 
% loss-of-performance  calling the hinfsyn command twice, where the second 
% time we can just ask for a controller  that achieves 1.1*gam, i.e.
% that is at most 10% worse in the H-Infinity sense.

% optimal synthesis to obtain the best possible gam
[~,~,gam,~] = hinfsyn(ssbal(P), nmeas, ncont, 'method', 'lmi');
% suboptimal synthesis in which a controller with 1.1*gam is sufficient
[K,CL,gam] = hinfsyn(ssbal(P), nmeas, ncont, 'method', 'lmi', 'GMIN', 1.1*gam);
gam

% The first thing that we should always check is whether everything worked
% fine. Even if we do not get an error message, there could be mistakes
% made by us setting up the problem. So let's verify that the controller
% actually achieves stability and performance as it should.

% Let's now verify that the closed loop is stable
stab = isstable(CL)
% and that the Hinfnorm is less than gam
normOK = norm(CL,'inf')<gam

% What might also be of interest for implementation is the fastest 
% controller pole
fastestpole = max(abs(eig(K.a)))
% This is relatively fast, but since we have ~1100Hz available it should
% cause no serious problems
%% Save relevant data

clearvars -except K Du Dr toMpS toRad toRPS
thisdate = datestr(now,'yyyy-mm-dd_HH-MM');
save(fullfile(pwd,'B_Control\Data',['LTI_data_',thisdate,'.mat']));
%% Frequency Response Analysis
%
% A first step in evaluating our controller can be a frequency response
% analysis. We can calculate all the six different transfer functions of
% interest using the loopsens command. These are the sensitivity S / input
% sensitivity Si, complementary sensitivity T , complementary input sensitivty Ti,
% as well as the transfer functions K*S and S*G (which are for square
% plants the same as Si*K and G*Si, respectively)

loops = loopsens(G, K);
figure(4);
subplot(2,2,1)
sigma(loops.So,W_S^-1,w)
title('S')
grid on
subplot(2,2,2)
sigma(loops.PSi,w)
title('SG')
grid on
subplot(2,2,3)
sigma(loops.CSo,(W_K)^-1,w)
title('KS')
grid on
subplot(2,2,4)
sigma(loops.Ti,w)
title('Ti')
grid on

% We can identify quite a few relevant properties of our design by looking 
% at the frequency response of what is sometimes called "the gang of four".
% For example, we can see that we will achieve tracking of step responses 
% when the sensitivity function starts with a slope of +20db. Further, KS
% tells us, if the controller rolls off at high frequencies. 
%
% SG on the other hand shows the same peak as our open loop plant, which
% indicates poor damping an further the low frequency gain is large, which
% means that input disturbances are not supressed but even amplified! This
% is a consequence of the fact that the controller does not include 
% integral action but just makes use of the integral behavior of the plant.
% to satisfy the demand on the sensitivity. We can verify this by taking a 
% look at the frequency response of the controller.
figure(5);
step(loops.Ti)
% figure(5); 
%  bodemag(K,'b',b,w)
%  title('Controller with S/KS mixed sensitivity')
