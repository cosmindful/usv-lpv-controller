%% This file computes the LTIu controller w/ OFb
%
% We define the frequency range of interest for the design to be 0.01 rad/s
% to 1000 rad/s, mainly for convenience in plotting. Further some options
% for bodeplots are invoked.
clear all, clc
tic
w = {1e-7,1e3};
b = bodeoptions;
b.xlim = [1e-5 1e3];
b.ylim = [-1e2 1e2];
b.Grid = 'on';
% Let's first define the uncertain parameters. These are exactly the
% time-varying paramters 'u', 'v', 'n' and 'delta'. We presume them as
% not being measurable online.
toMpS = 0.51444;
toRad = pi/180;
toRPS = 1/60;
tic

gridDensity = 5;
u      = linspace(1*toMpS,15*toMpS,gridDensity);%m/s
v      = linspace(-1*toMpS,1*toMpS,gridDensity);%m/s
n      = linspace(10*toRPS,80*toRPS,gridDensity);%rps
delta  = linspace(-10*toRad,10*toRad,gridDensity);%rad
toc
% Now we evaluate the affine LPV model from the nonlinear system and
% compute an LTI system for each value of the scheduling parameters
tic
disp('linearising...(this may take)');
modelType = 'Fossen';
[Gp,countedRanks]      = getLinearShipsUSS(u,v,n,delta);
toc


% figure(1)
% bodemag(Gp,b,w)
% figure(2)
% sigma(Gp,w)
% toc
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
%% Robust controller design by constructing the uncertain state-space model manually

% To extract the plant matrices A0, Bw and Cz the Matlab function
% lftdata(.) (see help) can be used.
[G_nom, DELTA] = lftdata(G);         % extract the uncerrtainity in LFT form
[nmeas,ncont] = size(G); 

% To extract the correct plant matrices we need to know the size of the
% DELTA block
mdelta = size(DELTA, 1);
ndelta = size(DELTA, 2);

% Now we extract the matrix A0 of the nominal state space model
A0 = G_nom.a;
B = G_nom.b(:,mdelta+1:end);
C = G_nom.c(ndelta+1:end,:);

% The input and output matrices of the uncertainty channel Bw and Cz 
% are contained in the first mdelta columns of B and the first ndelta rows
% of C of the uncertain state-space model, but we have to extract them
Bw = G_nom.b(:,1:mdelta);
Cz = G_nom.c(1:ndelta,:);
Dw = G_nom.D;

% Now we are ready to construct the generalized plant for the robust
% controller design problem (-C since the controller is designed for
% positive feedback)
GSYS = ssbal(ss(A0, [Bw B], [Cz; -C], Dw ));

% optimal synthesis to obtain the best possible gam
[~,~,gam,~] = hinfsyn(GSYS, nmeas, ncont, 'method', 'lmi');
% suboptimal synthesis in which a controller with 1.1*gam is sufficient
[K_u,CL,gam] = hinfsyn(GSYS, nmeas, ncont, 'method', 'lmi', 'GMIN', 1.1*gam);
gam
K_u
% Norm from w to z, if < 1 => Robust Stability
disp('###################################')
disp(['Hinf norm from w to z (Approach 1): ' num2str(gam)]) 
disp('###################################')
disp(char(10))
%%

% S/KS closed-loop shaping filter design

% While we could use the parameterization from the ORC lecture
% notes and build the filters manually as tf objects, a build-in command
% that we can use is makeweight(dcgain, bandwidth, feedthroughgain).
% For W1, the dcgain determines our error constant, the bandwidth the speed
% of response and the feedthroughgain limits the peak of S
% create sensitivity filter - Fossen, less param
ws1 = 9e-2; Ms1 = .01;%9e2,.01 bigger, faster
ws2 = 9e-2; Ms2 = .65;%9e2,.6. bigger, faster
Ws1 = tf([ws1/Ms1],[1 ws1])
Ws2 = tf([ws2/Ms2],[1 ws2])
W_S  = mdiag(Ws1, Ws2);

% For W2, the dcgain determines available control effort, the bandwidth
% corresponds to the actuator rates and the feedthroughgain limits
% authority at high frequencies
% create control sensitivity filter - Fossen,any
wk1 = 1e0; Mk1 = 9e2;c1 = 1e3; %1e1,9e3,1e3
wk2 = 1e0; Mk2 = 9e2;c2 = 1e3; %1e1,1e4,1e3
% wk1 = 1e0; Mk1 = 2e4;c1 = 1e3; %1e0,9e-1,1e3
% wk2 = 1e0; Mk2 = 8e3;c2 = 1e3; %1e0,9e-1,1e3
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
GSYSu = sysic

% We can also use the command P = AUGW(G,W_S,W_K) [augment with weights] 
% to get our generalized plant. 
% P_verify = augw(G,W_S,W_K);
% figure(200)
% sigma(P,P_verify,w)   
% Make sure that your P and the P_verify look the same in the sigma plot
% shown in Figure 200
% 2.3 Synthesis

% We first get the number of available measurements and controls 
[nmeas,ncont] = size(G); 

% Again we extract the LFR matrices contained in GSYS and the Delta block 
[GSYS, Delta] = lftdata(GSYSu);

% and apply the ssbal(.) function
GSYS = ssbal(GSYS);
        
% Compute the optimal Hinf norm of the closed loop
[~,~, hinf_Opt] = hinfsyn( GSYS, nmeas, ncont, 'Method', 'LMI', 'Display', 'off');

% and solve the suboptimal controller design problem in the second
% step
hinf_sub = 1.1*hinf_Opt;
[K_u,CL, hinf] = hinfsyn( GSYS, nmeas, ncont, 'Method', 'LMI', 'Display', 'off',...
    'GMIN', hinf_sub);

K_u = ssbal(K_u)

% The inputs of the closed loop CL are w = [wu' wp']' and the
% outputs are z = [zu' zp']'.
% To check for robust stability using the small gain theorem, we need to
% compute the Hinf norm from wu to zu
hinf_rob_stab = norm(CL(:,1), inf);

disp('###################################')
disp(['Hinf norm of the closed loop: ' num2str(hinf_sub)])
disp('###################################')
disp(char(10))
% Hinf norm from wu to zu => robust stability
disp('###################################')
disp(['Hinf norm from wu to zu: ' num2str(hinf_rob_stab)])  
disp('###################################')
disp(char(10))


%% Four block design

% In what is called a four block design, we explicitely consider input 
% disturbances and therefore avoid the cancellation problems.
% The only difference in the setup is an additional input disturbance
% weight Wd, which can be initally set to identity.

% disturbance weight
Wd = mdiag(0.01*toRPS,-.011*toRad);

% S / SG
% W_S1 = makeweight(100, 1, 0.2); 
% W_S2 = makeweight(100, 2, 0.2);
% W_S  = mdiag(W_S1, W_S2);

% KS / Ti
% W_K1 = makeweight(0.99, 50, 100);
% W_K2 = makeweight(0.99, 50, 100);
% W_K  = mdiag(W_K1, W_K2);


% The generalized plant now has an additional external input at the input
% of the plant. There are thus not two but four transfer functions involved
% in the problem.
systemnames = 'G Wd W_S W_K';
inputvar = '[w{2}; di{2}; u{2}]';
input_to_G = '[u+Wd]';
input_to_Wd = '[di]';
input_to_W_S = '[w-G]';
input_to_W_K = '[u]';
outputvar = '[W_S; W_K; w-G]';
cleanupsysic = 'yes'; %this just deletes the temporary variables afterwards
P = sysic;

[P_o, Delta] = lftdata(P);

% and apply the ssbal(.) function
P_o = ssbal(P_o);

% nmeas = 4+2; 
% ncont = 2;
% The synthesis is exactly the same as above
[~,~,gam,~] = hinfsyn(P_o, nmeas, ncont, 'method', 'lmi');
[K1,CL,gam,INFO] = hinfsyn(P_o, nmeas, ncont, 'method', 'lmi', 'GMIN', 1.1*gam);
gam

stab = isstable(CL)
normOK = norm(CL,'inf')<gam
fastestpole = max(abs(eig(K1.a)))
%% Save relevant data

clearvars -except K_u K1 Du Dr toMpS toRad toRPS
thisdate = datestr(now,'yyyy-mm-dd_HH-MM');
save(fullfile(pwd,'B_Control\Data',['LTI_USS_data_',thisdate,'.mat']));

%% Analyse obtained data using Gang of 4
% S,KS, T, SG, KSG
systemnames = 'G K';
inputvar    = '[r{2}]';
input_to_G = '[K]';
input_to_K  = '[r-G]';
outputvar   = '[r-G]';

S = sysic;  
KS = K_u*S;
T = 1-S;      
SG = S*G;  
KSG = K_u*SG;

 pzplot(G,'k', K_u, 'r', SG, 'b')
 set(gca, 'xlim', [-100 1], 'ylim', [-50 50])
 


% To evaluate these transfer functions for all possible combinations of
% springs cells are defined.
S_cell = {};
SG_cell = {};
KSG_cell = {};
T_cell = {};
KS_cell = {};

for k = u
    for kk = v
        for kkk = n
            for kkkk = delta
                
                % To substitute values for uncertain parameters we can use the
                % function usubs(.) ,'n', kkk, 'delta', kkkk
                S_cell = [S_cell {usubs(S, 'u', k, 'v', kk,...
                    'n', kkk, 'delta', kkkk)}];
                SG_cell = [SG_cell {usubs(SG, 'u', k, 'v', kk,...
                    'n', kkk, 'delta', kkkk)}];
                KSG_cell = [KSG_cell {usubs(KSG, 'u', k, 'v', kk,...
                    'n', kkk, 'delta', kkkk)}];
                T_cell = [T_cell {usubs(T, 'u', k, 'v', kk,...
                    'n', kkk, 'delta', kkkk)}];
                KS_cell = [KS_cell {usubs(KS, 'u', k, 'v', kk,...
                    'n', kkk, 'delta', kkkk)}];
                
            end
        end
    end
end

% Next, the sigma plots of these transfer functions are generated
% and plotted.
figure(4)
s1 = subplot(221);   
sigma(S_cell{1}, S_cell{2}, S_cell{2}, S_cell{4},...
    S_cell{5}, S_cell{6}, inv(W_S),'r--', {1e-7, 1e4});    title('S')
grid on

s2 = subplot(223);   
sigma(KS_cell{1}, KS_cell{2}, KS_cell{2}, KS_cell{4},...
    KS_cell{5}, KS_cell{6}, inv(W_K),'r--', {1e-7, 1e4});   title('KS')
grid on

s3 = subplot(222);   
sigma(SG_cell{1}, SG_cell{2}, SG_cell{2}, SG_cell{4},...
    SG_cell{5}, SG_cell{6}, inv(W_S),'r--', {1e-7, 1e4});    title('SG')
grid on

% s4 = subplot(224);   
% sigma(T_cell{1}, T_cell{2}, T_cell{2}, T_cell{4},...
%     T_cell{5}, T_cell{6}, inv(W_K),'r--', {1e-7, 1e4});    title('T')
% grid on
s4 = subplot(224);   
sigma(KSG_cell{1}, KSG_cell{2}, KSG_cell{2}, KSG_cell{4},...
    KSG_cell{5}, KSG_cell{6}, inv(W_K),'r--', {1e-7, 1e4});    title('T')
grid on
        
        
% To scale the y axis the set(.) command can be used.
% set(s1, 'ylim', [-100, 50]);
        

% To check a posteriori for stability (small gain theorem is conservative)
% we use the Matlab function isstable(.) for all possible T's.
stability_check = [isstable(T_cell{1}) isstable(T_cell{2})...
    isstable(T_cell{3}) isstable(T_cell{4})...
    isstable(T_cell{5}) isstable(T_cell{6})];

if isequal(stability_check, ones(1,6))
disp('###################################')
disp('All closed-loop systems are stable!')
disp('###################################')
disp(char(10))

% Furthermore, the gain and phasemargins are computed
% disp('Stability margins:')
% 
% for k = u
%     for kk = v
%         for kkk = n
%             for kkkk = delta
%                 Gi = usubs(G,'u', k, 'v', kk,...
%                     'n', kkk, 'delta', kkkk);
%                 disp('###################################')
%                 disp(['u = ' num2str(k) 'm/s, v = ' num2str(kk) 'm/s'...
%                     'n = ' num2str(kkk) 'rps, delta = ' num2str(kkkk) 'rad']);
%                 disp(loopmargin(Gi*K));
%                 disp('###################################')
%                 disp(char(10))
%             end
%         end
%     end
% end

else
    str = ['There exists a combination of parameters'...
        ' such that the closed-loop system is unstable!'];

    disp(str)       
end

%% Frequency Response Analysis
%
% A first step in evaluating our controller can be a frequency response
% analysis. We can calculate all the six different transfer functions of
% interest using the loopsens command. These are the sensitivity S / input
% sensitivity Si, complementary sensitivity T , complementary input sensitivty Ti,
% as well as the transfer functions K*S and S*G (which are for square
% plants the same as Si*K and G*Si, respectively)

loops = loopsens(G, K_u);
figure(5);
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
figure(6);
step(loops.Ti)
figure(5); 
 bodemag(K,'b',b,w)
 title('Controller with S/KS mixed sensitivity')