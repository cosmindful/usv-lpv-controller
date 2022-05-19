%% This file computes the heuristic PID controller
% Ziegler-Nichols table is used. Use following link for guidance
% http://www.inpharmix.com/jps/PID_Controller_For_Lego_Mindstorms_Robots.html
toMpS = 0.51444;
toRad = pi/180;
toRPS = 1/60;

e_u_max = 7.97;
u_u_max = 1.334;
Kc_u =  u_u_max/e_u_max;

e_psi_max = 3.1415927;
u_psi_max = 0.1745;
Kc_psi = u_psi_max/e_psi_max;

dT = 0.1;
Pc = 25;

P_u = 2*.6*Kc_u;
I_u = .55*(2*P_u*dT/Pc);
D_u = 1*P_u*Pc/(8*dT);

P_psi = 25*.6*Kc_psi;
I_psi = 0.0*(2*P_psi*dT/Pc);
D_psi = 5*P_psi*Pc/(8*dT);

%% 3.1 Frequency Response Analysis w/ PID controller
%
% A first step in evaluating our controller can be a frequency response
% analysis. We can calculate all the six different transfer functions of
% interest using the loopsens command. These are the sensitivity S / input
% sensitivity Si, complementary sensitivity T , complementary input sensitivty Ti,
% as well as the transfer functions K*S and S*G (which are for square
% plants the same as Si*K and G*Si, respectively)

% pidCalc
C1 = tf(pid(P_u,I_u,D_u));
C2 = tf(pid(P_psi,I_psi,D_psi));
CFtf = [C1 0; 0 C2]
% CFss = ss(CFtf)

loops = loopsens(G, CFtf);
figure(4);
subplot(2,2,1)
sigma(loops.So,W_S^-1,w)
title('S')
subplot(2,2,2)
sigma(loops.PSi,w)
title('SG')
subplot(2,2,3)
sigma(loops.CSo,(W_K)^-1,w)
title('KS')
subplot(2,2,4)
sigma(loops.Ti,w)
title('Ti')

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
figure(6); 
 bodemag(K,'b',b,w)
 title('Controller with S/KS mixed sensitivity')
%%
clearvars -except P_u I_u D_u P_psi I_psi D_psi

thisdate = datestr(now,'yyyy-mm-dd_HH-MM');
save(fullfile(pwd,'B_Control\Data',['Classic_data_',thisdate,'.mat']));