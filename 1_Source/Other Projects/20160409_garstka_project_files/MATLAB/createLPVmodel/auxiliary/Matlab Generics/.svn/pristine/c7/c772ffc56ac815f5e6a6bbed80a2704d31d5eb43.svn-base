clc; clear all; close all; warning off;
tic


syms q2 q3 w1 th1 th2 th3 th4 th5 th6 th7 th8 th9 th10 th11 th12 th13 th14 th15

load traj19
load LPVfull

N = length(q_2);

nth=length(th);

theta=[];

% Generate Theta trajectory data
for i=1:N,
%     for j=1:nth,
%         theta(j,i)=subs(th(j),[q2,q3,w1],[q_2(i),q_3(i),w_1(i)]);
%     end
q2=q_2(i);
q3=q_3(i);
w1=w_1(i);
th1=(6279*w1*cos(q2)*cos(q3)*sin(q2)^2*sin(q3))/(- 18147*cos(q2)^2 + 37128*cos(q3)^2 + 71799) - (273*w1*cos(q2)*cos(q3)*sin(q3)*(23*sin(q2)^2 + 68))/(18147*sin(q2)^2 - 37128*sin(q3)^2 + 90780) - (59*(230000*sin(q2)^2*sin(q3)^2 + 756125*sin(q2)^2 - 867000*sin(q3)^2 + 3782500))/(5000*(18147*sin(q2)^2 - 37128*sin(q3)^2 + 90780));
th2=(273*w1*sin(q2)*sin(q3)^2*(23*sin(q2)^2 + 68))/(18147*sin(q2)^2 - 37128*sin(q3)^2 + 90780) - (273*w1*sin(q2)*(230000*sin(q2)^2*sin(q3)^2 + 756125*sin(q2)^2 - 867000*sin(q3)^2 + 3782500))/(10000*(18147*sin(q2)^2 - 37128*sin(q3)^2 + 90780)) + (621*cos(q2)*cos(q3)*sin(q2)*sin(q3))/(- 18147*cos(q2)^2 + 37128*cos(q3)^2 + 71799);
th3=(27*sin(q3)*(23*sin(q2)^2 + 68))/(18147*sin(q2)^2 - 37128*sin(q3)^2 + 90780) + (273*w1*cos(q2)*cos(q3)*(230000*sin(q2)^2*sin(q3)^2 + 756125*sin(q2)^2 - 867000*sin(q3)^2 + 3782500))/(10000*(18147*sin(q2)^2 - 37128*sin(q3)^2 + 90780)) - (6279*w1*cos(q2)*cos(q3)*sin(q2)^2*sin(q3)^2)/(- 18147*cos(q2)^2 + 37128*cos(q3)^2 + 71799);
th4=-(273*w1*sin(q2)*(- 230000*sin(q2)^2*sin(q3)^2 + 230000*sin(q2)^2 + 910000*sin(q3)^2 - 2225000))/(10000*(18147*sin(q2)^2 - 37128*sin(q3)^2 + 90780)) - (6279*w1*cos(q2)^2*cos(q3)^2*sin(q2))/(- 18147*cos(q2)^2 + 37128*cos(q3)^2 + 71799) - (2714*cos(q2)*cos(q3)*sin(q2)*sin(q3))/(- 18147*cos(q2)^2 + 37128*cos(q3)^2 + 71799);
th5=-(27*(- 230000*sin(q2)^2*sin(q3)^2 + 230000*sin(q2)^2 + 910000*sin(q3)^2 - 2225000))/(10000*(18147*sin(q2)^2 - 37128*sin(q3)^2 + 90780));
th6=(621*cos(q2)*cos(q3)*sin(q2))/(- 18147*cos(q2)^2 + 37128*cos(q3)^2 + 71799) + (273*w1*sin(q2)*sin(q3)*(- 230000*sin(q2)^2*sin(q3)^2 + 230000*sin(q2)^2 + 910000*sin(q3)^2 - 2225000))/(10000*(18147*sin(q2)^2 - 37128*sin(q3)^2 + 90780)) + (6279*w1*cos(q2)^2*cos(q3)^2*sin(q2)*sin(q3))/(- 18147*cos(q2)^2 + 37128*cos(q3)^2 + 71799);
th7=(6279*w1*cos(q2)*cos(q3)*sin(q2)^2)/(- 18147*cos(q2)^2 + 37128*cos(q3)^2 + 71799) - (273*w1*cos(q2)*cos(q3)*(230000*sin(q2)^2 + 680000))/(10000*(18147*sin(q2)^2 - 37128*sin(q3)^2 + 90780)) - (118*sin(q3)*(23*sin(q2)^2 + 68))/(18147*sin(q2)^2 - 37128*sin(q3)^2 + 90780);
th8=(621*cos(q2)*cos(q3)*sin(q2))/(- 18147*cos(q2)^2 + 37128*cos(q3)^2 + 71799) - (273*w1*sin(q2)*sin(q3)*(23*sin(q2)^2 + 68))/(18147*sin(q2)^2 - 37128*sin(q3)^2 + 90780) + (273*w1*sin(q2)*sin(q3)*(230000*sin(q2)^2 + 680000))/(10000*(18147*sin(q2)^2 - 37128*sin(q3)^2 + 90780));
th9=(27*(230000*sin(q2)^2 + 680000))/(10000*(18147*sin(q2)^2 - 37128*sin(q3)^2 + 90780)) + (273*w1*cos(q2)*cos(q3)*sin(q3)*(23*sin(q2)^2 + 68))/(18147*sin(q2)^2 - 37128*sin(q3)^2 + 90780) - (6279*w1*cos(q2)*cos(q3)*sin(q2)^2*sin(q3))/(- 18147*cos(q2)^2 + 37128*cos(q3)^2 + 71799);
th10=-(10000*cos(q3)*sin(q2)*sin(q3)*(23*sin(q2)^2 + 68))/(18147*sin(q2)^2 - 37128*sin(q3)^2 + 90780) - (230000*cos(q2)^2*cos(q3)*sin(q2)*sin(q3))/(- 18147*cos(q2)^2 + 37128*cos(q3)^2 + 71799);
th11=(230000*sin(q2)^2*sin(q3)^2 + 756125*sin(q2)^2 - 867000*sin(q3)^2 + 3782500)/(18147*sin(q2)^2 - 37128*sin(q3)^2 + 90780);
th12=(cos(q2)*(- 230000*sin(q2)^2*sin(q3)^2 + 230000*sin(q2)^2 + 910000*sin(q3)^2 - 2225000))/(18147*sin(q2)^2 - 37128*sin(q3)^2 + 90780) - (230000*cos(q2)*cos(q3)^2*sin(q2)^2)/(- 18147*cos(q2)^2 + 37128*cos(q3)^2 + 71799);
th13=(230000*cos(q2)*cos(q3)*sin(q2)*sin(q3))/(- 18147*cos(q2)^2 + 37128*cos(q3)^2 + 71799);
th14=-(cos(q3)*sin(q2)*(230000*sin(q2)^2 + 680000))/(18147*sin(q2)^2 - 37128*sin(q3)^2 + 90780) - (230000*cos(q2)^2*cos(q3)*sin(q2))/(- 18147*cos(q2)^2 + 37128*cos(q3)^2 + 71799);
th15=(10000*sin(q3)*(23*sin(q2)^2 + 68))/(18147*sin(q2)^2 - 37128*sin(q3)^2 + 90780);
theta=[theta [th1 th2 th3 th4 th5 th6 th7 th8 th9 th10 th11 th12 th13 th14 th15]'];
end

reqacc = 99;    % Specify the required accuracy after PSM
method = 'pm1'; % Specify the type of normalization: pm1 -> normalize to +-1

[NTHETAhat, PHI, PHI_bnd, Us, nphi, percerr, dSIG, Nrmlz_data] = psm_pca(theta, reqacc, method);

%vert = permute_bounds(PHI_bnd);

% Define new parameter vector Phi
      PV = pvec('box',PHI_bnd);
vert_phi = polydec(PV);
      nv = 2^nphi;
      
      
% Transform plant from S(Theta) to S(Phi)
Si=[];

for i=1:nv,
    thhat   = phi2thhat(Us,vert_phi(:,i),Nrmlz_data,'pm1');
    Aphi    = double(subs(Ath,[th(1),th(2),th(3),th(4),th(5),th(6),th(7),th(8),th(9)],thhat(1:9)'));
    Bphi    = double(subs(Bth,[th(10),th(11),th(12),th(13),th(14),th(15)],thhat(10:15)'));
    C       = [1 0 0 0 0;0 1 0 0 0];
    D       = zeros(2);
    sys     = ltisys(Aphi,Bphi,C,D);
    Si      = [Si,sys];
    G{i}    = ss(Aphi,Bphi,C,D);
    ABCD{i} = [Aphi Bphi;C D];
end

Sphi=psys(Si);

% Check for quadratic stabilizability
[is_stab,is_det] = quad_stab_det(Sphi);

toc
