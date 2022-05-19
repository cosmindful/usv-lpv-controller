function [G,countedRanks] = getLinearShipsUSS(p1,p2,p4,p5)

G= LPVplant(p1,p2,p4,p5);
countedRanks = rank(ctrb(G.A,G.B));


function G = LPVplant(u_r,v_r,n_r,delta_r)

thetaVector = getUSSFossen(u_r,v_r,n_r,delta_r);
A11vec = thetaVector(1,:);
A12vec = thetaVector(2,:);
A13vec = thetaVector(3,:);
A21vec = thetaVector(4,:);
A22vec = thetaVector(5,:);
A23vec = thetaVector(6,:);
A31vec = thetaVector(7,:);
A32vec = thetaVector(8,:);
A33vec = thetaVector(9,:);

B11vec = thetaVector(10,:);
B12vec = thetaVector(11,:);
B21vec = thetaVector(12,:);
B22vec = thetaVector(13,:);
B31vec = thetaVector(14,:);
B32vec = thetaVector(15,:);

A110 = mean(A11vec);
A120 = mean(A12vec);
A130 = mean(A13vec);
A210 = mean(A21vec);
A220 = mean(A22vec);
A230 = mean(A23vec);
A310 = mean(A31vec);
A320 = mean(A32vec);
A330 = mean(A33vec);

B110 = mean(B11vec);
B120 = mean(B12vec);
B210 = mean(B21vec);
B220 = mean(B22vec);
B310 = mean(B31vec);
B320 = mean(B32vec);

A11_range = [min(A11vec) max(A11vec)];
A12_range = [min(A12vec) max(A12vec)];
A13_range = [min(A13vec) max(A13vec)];
A21_range = [min(A21vec) max(A21vec)];
A22_range = [min(A22vec) max(A22vec)];
A23_range = [min(A23vec) max(A23vec)];
A31_range = [min(A31vec) max(A31vec)];
A32_range = [min(A32vec) max(A32vec)];
A33_range = [min(A33vec) max(A33vec)];

B11_range = [min(B11vec) max(B11vec)];
B12_range = [min(B12vec) max(B12vec)];
B21_range = [min(B21vec) max(B21vec)];
B22_range = [min(B22vec) max(B22vec)];
B31_range = [min(B31vec) max(B31vec)];
B32_range = [min(B32vec) max(B32vec)];

A11 = ureal('A11', A110, 'range', A11_range);
A12 = ureal('A12', A120, 'range', A12_range); 
A13 = ureal('A13', A130, 'range', A13_range); 
A21 = ureal('A21', A210, 'range', A21_range); 
A22 = ureal('A22', A220, 'range', A22_range); 
A23 = ureal('A23', A230, 'range', A23_range); 
A31 = ureal('A31', A310, 'range', A31_range); 
A32 = ureal('A32', A320, 'range', A32_range); 
A33 = ureal('A33', A330, 'range', A33_range);

B11 = ureal('B11', B110, 'range', B11_range);
B12 = ureal('B12', B120, 'range', B12_range); 
B21 = ureal('B21', B210, 'range', B21_range); 
B22 = ureal('B22', B220, 'range', B22_range); 
B31 = ureal('B31', B310, 'range', B31_range); 
B32 = ureal('B32', B320, 'range', B32_range); 

% generate system matrices
A = [A11 A12 A13 0;
    A21 A22 A23 0;
    A31 A32 A33 0
    0     0   1 0];
B = [B11 B12; B21 B22; B31 B32; 0 0];
C = [1 0 0 0;
     0 0 0 1];

% get LTIu system
G = ss(A,B,C,0);
% G.OutputName={'u','v','r'};
% G.OutputName={'u','v','psi'};
% G.OutputName={'psi'};
G.OutputName={'u','psi'};
G.InputName={'n','delta'};
% G.StateName={'u','v','r'};
G.StateName={'u','v','r','psi'};