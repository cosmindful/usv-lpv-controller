function [G,countedRanks] = getLinearShipsLTI(p1,p2,p4,p5,modelType)

G= LPVplant(p1,p2,p4,p5);
countedRanks = rank(ctrb(G.A,G.B));


function G = LPVplant(u_r,v_r,n_r,delta_r)
% extract the LTI system as one member of the LTI family defining the LPV
% model
thetaVector = getqLPVFossen(u_r,v_r,n_r,delta_r);
A11 = thetaVector(:,1);
A12 = thetaVector(:,2);
A13 = thetaVector(:,3);
A21 = thetaVector(:,4);
A22 = thetaVector(:,5);
A23 = thetaVector(:,6);
A31 = thetaVector(:,7);
A32 = thetaVector(:,8);
A33 = thetaVector(:,9);

B11 = thetaVector(:,10);
B12 = thetaVector(:,11);
B21 = thetaVector(:,12);
B22 = thetaVector(:,13);
B31 = thetaVector(:,14);
B32 = thetaVector(:,15);

% generate system matrices
A = [A11 A12 A13 0;
    A21 A22 A23 0;
    A31 A32 A33 0
    0     0   1 0];
B = [B11 B12; B21 B22; B31 B32; 0 0];
C = [1 0 0 0;
     0 0 0 1];
 
% get LTI system
G = ss(A,B,C,0);
G.OutputName={'u','psi'};
G.InputName={'n','delta'};
G.StateName={'u','v','r','psi'};