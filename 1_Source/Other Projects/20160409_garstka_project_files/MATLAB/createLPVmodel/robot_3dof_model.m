%% Design a LPV State Model and synthesize LFT-LPV Controller
% -------------------------------------------------------------------------
% script   : robot_3dof_model
% -------------------------------------------------------------------------
% Author   : Michael Garstka (based on Christian Hoffmann)
% Version  : March, 24th 2016
% Copyright: TUHH, 2016
% -------------------------------------------------------------------------
%
% Requires YALMIP and SDPT3
%
% This file first creates the LPV model for the 3DOF robot and then based
% on that synthesizes a LPV controller.
% 3 different models are created: one based on 9 LFT parameters (delta), one based
% on 16 affine LFT parameters (theta) and one reduced model (phi)

clear all 
close all

% add auxiliary files
addpath(genpath('.'))

% Define Model parameters
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

%% Load the parameter grid
% - generate grid based on the kinematic limits
% - for robot joint angles q1,q2,q3, and joint velocities q1dot,q2dot,q3dot
% - should be adjusted based on the operating range of the robot

qorig_bnd{1} = [ -135    10     ];
qorig_bnd{2} = [ -90      90     ];
qorig_bnd{3} = [  -100     45     ];

qdbounds{1} = [ -180        180   ]*pi/180;
qdbounds{2} = [ -180        180   ]*pi/180;
qdbounds{3} = [ -360        360  ]*pi/180;

% convert from deg to rad
qbounds{1} = qorig_bnd{1}*pi/180; 
qbounds{2} = qorig_bnd{2}*pi/180; 
qbounds{3} = (qorig_bnd{3} + qorig_bnd{2} - [90 90])*pi/180; 
% define grid density
qgriddensity = pi/8;

qgridvector{1}   = [ qbounds{1}(1):qgriddensity:qbounds{1}(2) ];
qgridvector{2}   = [ qbounds{2}(1):qgriddensity:qbounds{2}(2) ];
qgridvector{3}   = [ qbounds{3}(1):qgriddensity:qbounds{3}(2) ];

qdgriddensity = pi/8;

qdgridvector{1}   = [ qdbounds{1}(1):qdgriddensity:qdbounds{1}(2) ];
qdgridvector{2}   = [ qdbounds{2}(1):qdgriddensity:qdbounds{2}(2) ];
qdgridvector{3}   = [ qdbounds{3}(1):qdgriddensity:qdbounds{3}(2) ];
qgrid = combvec(qgridvector{2}, qgridvector{3}, qdgridvector{1}, qdgridvector{2}, qdgridvector{3});

q1  = qgrid(1, :)';
q2  = qgrid(2, :)';
q3  = qgrid(3, :)';
qd1 = qgrid(1, :)';
qd2 = qgrid(2, :)';
qd3 = qgrid(3, :)';


%% define scheduling signal vector rho (grid based) rho=(q2,q3tilde,q1dot,q2dot,q3tildedot)
rho = [q2, q3, qd1, qd2, qd3];
rho_bnd = [qbounds{2};qbounds{3};qdbounds{1};qdbounds{2};qdbounds{3}];
%% Calculate 16 affine LFT parameters theta = (theta1,...,theta16)
THETAGrid   = robot3DOFaffineLPVparams(rho);
Xi = THETAGrid;
ntheta      = size(Xi, 1);

% normalize rows of Xi to obtain Xi_n, PS saves the process settings
% syntax for function: [Y,PS] = mapminmax(X,YMIN,YMAX) (process X by
% normalizing the min and max value of each row to Ymin,Ymax)
[NTHETAGrid, Ntheta_NrmlzGrid] = mapminmax(Xi);

% calculates min max bounds for every theta
theta_bndGrid   = [Ntheta_NrmlzGrid.xmin, Ntheta_NrmlzGrid.xmax];
% calculates mid point for every theta
theta_midGrid   = (Ntheta_NrmlzGrid.xmax + Ntheta_NrmlzGrid.xmin)/2;
% calculates range for every theta: max-value - min-value
theta_rangeGrid =  Ntheta_NrmlzGrid.xrange;

theta_bnd       = theta_bndGrid;
theta_min       = theta_bnd(:, 1);
theta_mid       = theta_midGrid;
theta_range     = theta_rangeGrid;

%% Calculate 9 rational LFT parameters delta
DELTAGrid  = robot3DOFLFTLPVparams([q2, q3, qd1, qd2, qd3]);
ndelta     = size(DELTAGrid, 1);

% Generate delta bounds
[NDELTA, Ndelta_Nrmlz] = mapminmax(DELTAGrid);
delta_bndGrid   = [Ndelta_Nrmlz.xmin, Ndelta_Nrmlz.xmax];
delta_midGrid   = (Ndelta_Nrmlz.xmax + Ndelta_Nrmlz.xmin)/2;
delta_rangeGrid =  Ndelta_Nrmlz.xrange;

delta_bnd       = delta_bndGrid;
delta_mid       = delta_midGrid;
delta_range     = delta_rangeGrid;

%% Parameter Set Mapping for Theta from Gridded Data
% Parameter Set mappings can be used to generate an approximate LPV model
% with less LFT parameters
% Here the LPV-model based on theta is reduced from 16 (theta) to 4
% parameters (phi)
requiredAccuracy    = 90;      % Specify the required accuracy after PSM
requirednphi        = 4;    % Specify the number of reduced parameters (0 to let accuracy decide)
normalizationMethod = 'pm1';   % Specify the type of normalization: pm1 -> normalize to +-1

[NTHETA_hat, PHI, phi_bndGrid, UsGrid, nphiGrid, percerr, dSIG, Nrmlz_data] = psm_pca(NTHETAGrid, ...
                                                                              requiredAccuracy, ...
                                                                              requirednphi, ...
                                                                              normalizationMethod);
UsGrid(abs(UsGrid) < 0.1) = 0;
phi_bndGrid   = [-sum(abs(UsGrid'), 2), sum(abs(UsGrid'), 2)];
phi_midGrid   = (phi_bndGrid(:,2) + phi_bndGrid(:,1))/2;
phi_rangeGrid =  phi_bndGrid(:,2) - phi_bndGrid(:,1);
                                                                      
NTHETA_hat = UsGrid*UsGrid'*NTHETAGrid;                                                                      
PCA_errGrid = rms(rms(abs(NTHETAGrid - NTHETA_hat), 2));

%% Construct affine model
% Define the 16 theta and the 16 normalized thetaN scheduling parameters of type uncertain real
utheta01 = ureal('utheta01', theta_midGrid( 1), 'Range', [theta_bndGrid( 1, 1)  theta_bndGrid( 1, 2)]);
utheta02 = ureal('utheta02', theta_midGrid( 2), 'Range', [theta_bndGrid( 2, 1)  theta_bndGrid( 2, 2)]);
utheta03 = ureal('utheta03', theta_midGrid( 3), 'Range', [theta_bndGrid( 3, 1)  theta_bndGrid( 3, 2)]);
utheta04 = ureal('utheta04', theta_midGrid( 4), 'Range', [theta_bndGrid( 4, 1)  theta_bndGrid( 4, 2)]);
utheta05 = ureal('utheta05', theta_midGrid( 5), 'Range', [theta_bndGrid( 5, 1)  theta_bndGrid( 5, 2)]);
utheta06 = ureal('utheta06', theta_midGrid( 6), 'Range', [theta_bndGrid( 6, 1)  theta_bndGrid( 6, 2)]);
utheta07 = ureal('utheta07', theta_midGrid( 7), 'Range', [theta_bndGrid( 7, 1)  theta_bndGrid( 7, 2)]);
utheta08 = ureal('utheta08', theta_midGrid( 8), 'Range', [theta_bndGrid( 8, 1)  theta_bndGrid( 8, 2)]);
utheta09 = ureal('utheta09', theta_midGrid( 9), 'Range', [theta_bndGrid( 9, 1)  theta_bndGrid( 9, 2)]);
utheta10 = ureal('utheta10', theta_midGrid(10), 'Range', [theta_bndGrid(10, 1)  theta_bndGrid(10, 2)]);
utheta11 = ureal('utheta11', theta_midGrid(11), 'Range', [theta_bndGrid(11, 1)  theta_bndGrid(11, 2)]);
utheta12 = ureal('utheta12', theta_midGrid(12), 'Range', [theta_bndGrid(12, 1)  theta_bndGrid(12, 2)]);
utheta13 = ureal('utheta13', theta_midGrid(13), 'Range', [theta_bndGrid(13, 1)  theta_bndGrid(13, 2)]);
utheta14 = ureal('utheta14', theta_midGrid(14), 'Range', [theta_bndGrid(14, 1)  theta_bndGrid(14, 2)]);
utheta15 = ureal('utheta15', theta_midGrid(15), 'Range', [theta_bndGrid(15, 1)  theta_bndGrid(15, 2)]);
utheta16 = ureal('utheta16', theta_midGrid(16), 'Range', [theta_bndGrid(16, 1)  theta_bndGrid(16, 2)]);
uNtheta01 = ureal('uNtheta01', 0); 
uNtheta02 = ureal('uNtheta02', 0);
uNtheta03 = ureal('uNtheta03', 0);
uNtheta04 = ureal('uNtheta04', 0);
uNtheta05 = ureal('uNtheta05', 0);
uNtheta06 = ureal('uNtheta06', 0);
uNtheta07 = ureal('uNtheta07', 0);
uNtheta08 = ureal('uNtheta08', 0);
uNtheta09 = ureal('uNtheta09', 0);
uNtheta10 = ureal('uNtheta10', 0);
uNtheta11 = ureal('uNtheta11', 0);
uNtheta12 = ureal('uNtheta12', 0);
uNtheta13 = ureal('uNtheta13', 0);
uNtheta14 = ureal('uNtheta14', 0);
uNtheta15 = ureal('uNtheta15', 0);
uNtheta16 = ureal('uNtheta16', 0);

%% LFT parameters delta = [delta_1,...,delta_9]
udelta1 = ureal('udelta1', delta_mid(1), 'Range', [delta_bnd(1, 1), delta_bnd(1, 2)]);
udelta2 = ureal('udelta2', delta_mid(2), 'Range', [delta_bnd(2, 1), delta_bnd(2, 2)]);
udelta3 = ureal('udelta3', delta_mid(3), 'Range', [delta_bnd(3, 1), delta_bnd(3, 2)]);
udelta4 = ureal('udelta4', delta_mid(4), 'Range', [delta_bnd(4, 1), delta_bnd(4, 2)]);
udelta5 = ureal('udelta5', delta_mid(5), 'Range', [delta_bnd(5, 1), delta_bnd(5, 2)]);
udelta6 = ureal('udelta6', delta_mid(6), 'Range', [delta_bnd(6, 1), delta_bnd(6, 2)]);
udelta7 = ureal('udelta7', delta_mid(7), 'Range', [delta_bnd(7, 1), delta_bnd(7, 2)]);
udelta8 = ureal('udelta8', delta_mid(8), 'Range', [delta_bnd(8, 1), delta_bnd(8, 2)]);
udelta9 = ureal('udelta9', delta_mid(9), 'Range', [delta_bnd(9, 1), delta_bnd(9, 2)]);

%% Define the rational LFT model matrizes Ad,Bd,Cd,Dd in terms of delta
% This is done by expressing theta(delta) and then substitute these into
% the matrices for theta -> yields a system in terms of delta

uv1 = (b6*udelta1^2 + b7*udelta2^2 + b5 + b3*udelta3*udelta4);
uv2 = ((b3^2*(udelta1*udelta2 + udelta3*udelta4)^2)/2 + 2*b17*b3*(udelta1*udelta2 + udelta3*udelta4) - 2*b13*b16 + 2*b14*b17);

% A Matrix
uthetaofdelta01 = -(b1 + b2*udelta6*udelta1*udelta3 + b3*udelta6*udelta1*udelta4 + b3*udelta7*udelta2*udelta3 + b4*udelta7*udelta2*udelta4)/uv1;
uthetaofdelta02 =  (2*b16*b8*udelta8)/uv2;
uthetaofdelta03 = -(2*b9*(b14 - b16) + b3*b9*(udelta1*udelta2 + udelta3*udelta4))*udelta9/uv2;
uthetaofdelta04 = -(b12*udelta5*2*udelta4*udelta2*(2*b14 - 2*b16) - (b3^2*udelta5*(udelta1*udelta2 + udelta3*udelta4)*(udelta3*udelta2 + udelta1*udelta4))/4 + (b14*b3*udelta5*(udelta4*udelta1 - udelta2*udelta3))/2 + (b3^2*udelta5*(udelta1*udelta2 + udelta3*udelta4)*(udelta4*udelta1 - udelta2*udelta3))/4 + b3*udelta5*(udelta3*udelta2 + udelta1*udelta4)*(b14/2 - b17) - 2*b11*b16*udelta5*(2*udelta3*udelta1) + b12*b3*udelta5*(udelta1*udelta2 + udelta3*udelta4)*(2*udelta4*udelta2))/uv2;
uthetaofdelta05 =  (2*b10*b16 + 2*b14*b15 + b15*b3*(udelta1*udelta2 + udelta3*udelta4) - (b3^2*udelta6*(udelta1*udelta2 + udelta3*udelta4)*(udelta4*udelta1 - udelta2*udelta3))/2 - b3*udelta6*(udelta4*udelta1 - udelta2*udelta3)*(b14 - b16))/uv2;
uthetaofdelta06 = -(2*b14*b15 + b15*b3*(udelta1*udelta2 + udelta3*udelta4) + b16*b3*udelta7*(udelta4*udelta1 - udelta2*udelta3))/uv2;
uthetaofdelta07 = -(2*b17*b8 + b3*b8*(udelta1*udelta2 + udelta3*udelta4))*udelta8/uv2;
uthetaofdelta08 =  (b9*(2*b13 - 2*b17))*udelta9/uv2;
uthetaofdelta09 = -((b3*udelta5*(udelta3*udelta2 + udelta1*udelta4)*(b13 - 2*b17))/2 - b12*udelta5*(2*udelta4*udelta2)*(2*b13 - 2*b17) - (b3^2*udelta5*(udelta1*udelta2 + udelta3*udelta4)*(udelta3*udelta2 + udelta1*udelta4))/4 + (b13*b3*udelta5*(udelta3*udelta2 - udelta1*udelta4))/2 + (b3^2*udelta5*(udelta1*udelta2 + udelta3*udelta4)*(udelta3*udelta2 - udelta1*udelta4))/4 + 2*b11*b17*udelta5*(2*udelta3*udelta1) + b11*b3*udelta5*(udelta1*udelta2 + udelta3*udelta4)*(2*udelta3*udelta1))/uv2;
uthetaofdelta10 = -(2*b10*b17 + 2*b13*b15 + b3*(udelta1*udelta2 + udelta3*udelta4)*(b10 + b15) + b3*udelta6*(udelta3*udelta2 - udelta1*udelta4)*(b13 - b17))/uv2;
uthetaofdelta11 =  (2*b13*b15 + b15*b3*(udelta1*udelta2 + udelta3*udelta4) - b17*b3*udelta7*(udelta3*udelta2 - udelta1*udelta4) - (b3^2*udelta7*(udelta1*udelta2 + udelta3*udelta4)*(udelta3*udelta2 - udelta1*udelta4))/2)/uv2;
 
% B Matrix
uthetaofdelta12 =  1/uv1;
uthetaofdelta13 = -(2*b16)/uv2;
uthetaofdelta14 =  (2*b14 + b3*(udelta1*udelta2 + udelta3*udelta4))/uv2;
uthetaofdelta15 =  (2*b17 + b3*(udelta1*udelta2 + udelta3*udelta4))/uv2;
uthetaofdelta16 = -(2*b13 + b3*(udelta1*udelta2 + udelta3*udelta4))/uv2;

Ad        = umat(O(6, 6));
Ad(1:3, 4:end) = I(3);
Ad(4,4)   = uthetaofdelta01; % A(4,4) =  -(b1 + b2*qd2*cos(q2)*sin(q2) + b3*qd2*cos(q2)*sin(q3) + b3*qd3*cos(q3)*sin(q2) + b4*qd3*cos(q3)*sin(q3))/v1
Ad(5,2)   = uthetaofdelta02; % A(5,2) =  (2*b16*b8*sin(q2))/(q2*v2)
Ad(5,3)   = uthetaofdelta03; % A(5,3) =  -(2*b9*sin(q3)*(b14 - b16) + b3*b9*(cos(q2)*cos(q3) + sin(q2)*sin(q3))*sin(q3))/(q3*v2)
Ad(5,4)   = uthetaofdelta04; % A(5,4) =  -(b12*qd1*sin(2*q3)*(2*b14 - 2*b16) - (b3^2*qd1*(cos(q2)*cos(q3) + sin(q2)*sin(q3))*sin(q2 + q3))/4 + (b14*b3*qd1*(sin(q3)*cos(q2) - cos(q3)*sin(q2)))/2 + (b3^2*qd1*(cos(q2)*cos(q3) + sin(q2)*sin(q3))*(sin(q3)*cos(q2) - cos(q3)*sin(q2)))/4 + b3*qd1*sin(q2 + q3)*(b14/2 - b17) - 2*b11*b16*qd1*sin(2*q2) + b12*b3*qd1*(cos(q2)*cos(q3) + sin(q2)*sin(q3))*sin(2*q3))/v2
Ad(5,5)   = uthetaofdelta05; % A(5,5) =  (2*b10*b16 + 2*b14*b15 + b15*b3*(cos(q2)*cos(q3) + sin(q2)*sin(q3)) - (b3^2*qd2*(cos(q2)*cos(q3) + sin(q2)*sin(q3))*(sin(q3)*cos(q2) - cos(q3)*sin(q2)))/2 - b3*qd2*(sin(q3)*cos(q2) - cos(q3)*sin(q2))*(b14 - b16))/v2
Ad(5,6)   = uthetaofdelta06; % A(5,6) =   -(2*b14*b15 + b15*b3*(cos(q2)*cos(q3) + sin(q2)*sin(q3)) + b16*b3*qd3*(sin(q3)*cos(q2) - cos(q3)*sin(q2)))/v2
Ad(6,1)   = 0;
Ad(6,2)   = uthetaofdelta07; % A(6,2) =  -(2*b17*b8*sin(q2) + b3*b8*(cos(q2)*cos(q3) + sin(q2)*sin(q3))*sin(q2))/(q2*v2)
Ad(6,3)   = uthetaofdelta08; % A(6,3) =  (b9*sin(q3)*(2*b13 - 2*b17))/(q3*v2)
Ad(6,4)   = uthetaofdelta09; % A(6,4) =  -((b3*qd1*sin(q2 + q3)*(b13 - 2*b17))/2 - b12*qd1*sin(2*q3)*(2*b13 - 2*b17) - (b3^2*qd1*(cos(q2)*cos(q3) + sin(q2)*sin(q3))*sin(q2 + q3))/4 + (b13*b3*qd1*(sin(q2)*cos(q3) - cos(q2)*sin(q3)))/2 + (b3^2*qd1*(cos(q2)*cos(q3) + sin(q2)*sin(q3))*(sin(q2)*cos(q3) - cos(q2)*sin(q3)))/4 + 2*b11*b17*qd1*sin(2*q2) + b11*b3*qd1*(cos(q2)*cos(q3) + sin(q2)*sin(q3))*sin(2*q2))/v2
Ad(6,5)   = uthetaofdelta10; % A(6,5) =  -(2*b10*b17 + 2*b13*b15 + b3*(cos(q2)*cos(q3) + sin(q2)*sin(q3))*(b10 + b15) + b3*qd2*(sin(q2)*cos(q3) - cos(q2)*sin(q3))*(b13 - b17))/v2
Ad(6,6)   = uthetaofdelta11; % A(6,6) =  (2*b13*b15 + b15*b3*(cos(q2)*cos(q3) + sin(q2)*sin(q3)) - b17*b3*qd3*(sin(q2)*cos(q3) - cos(q2)*sin(q3)) - (b3^2*qd3*(cos(q2)*cos(q3) + sin(q2)*sin(q3))*(sin(q2)*cos(q3) - cos(q2)*sin(q3)))/2)/v2
 
Bd        = umat(O(6, 3));
Bd(4,1)   = uthetaofdelta12; % B(4,1) =  1/v1 
Bd(5,2)   = uthetaofdelta13; % B(5,2) =  -(2*b16)/v2
Bd(5,3)   = uthetaofdelta14; % B(5,3) =  (2*b14 + b3*(cos(q2)*cos(q3) + sin(q2)*sin(q3)))/v2   
Bd(6,1)   = 0;
Bd(6,2)   = uthetaofdelta15; % B(6,2) = (2*b17 + b3*(cos(q2)*cos(q3) + sin(q2)*sin(q3)))/v2
Bd(6,3)   = uthetaofdelta16; % B(6,3) =  -(2*b13 + b3*(cos(q2)*cos(q3) + sin(q2)*sin(q3)))/v2
% Matrix C
Cd = [eye(3) zeros(3,3)];    % output: joint positions

% Matrix D
Dd = zeros(3,3);


% create the uncertain state space system MRLFR_Ndelta
MRLFR_Ndelta = uss(Ad, Bd, Cd, Dd);
MRLFR_Ndelta = simplify(MRLFR_Ndelta, 'full');


%% Define the affine model matrizes A,B,C,D in terms of the uncertain affine parameter theta
A        = umat(zeros(6, 6));
A(1:3, 4:end) = eye(3);
A(4,4)   = utheta01; 
A(5,2)   = utheta02;
A(5,3)   = utheta03; 
A(5,4)   = utheta04; 
A(5,5)   = utheta05; 
A(5,6)   = utheta06; 
A(6,1)   = 0;
A(6,2)   = utheta07; 
A(6,3)   = utheta08; 
A(6,4)   = utheta09; 
A(6,5)   = utheta10; 
A(6,6)   = utheta11; 
 
B        = umat(zeros(6, 3));
B(4,1)   = utheta12; 
B(5,2)   = utheta13; 
B(5,3)   = utheta14;  
B(6,1)   = 0;
B(6,2)   = utheta15; 
B(6,3)   = utheta16; 

% Matrix C
C = [eye(3) zeros(3,3)];    % output: joint positions

% Matrix D
D = zeros(3,3);

% Define the uncertain state space system MRLFR_Ntheta and perform model reduction
MRLFR_Ntheta = uss(A, B, C, D);
MRLFR_Ntheta = simplify(MRLFR_Ntheta, 'full'); 

% lftdata decomposes an uncertain object into a fixed certain part and a normalized uncertain part. 
% here MR_Ntheta represents fixed certain part and uNTHETA represents the
% normalized uncertain part
% BLKSTRUCT(i) describes the i-th normalized uncertain element.
[MR_Ntheta, uNTHETA, MR_Ntheta_Blkstruct, ~] = lftdata(MRLFR_Ntheta);

rTHETA      = [MR_Ntheta_Blkstruct.Occurrences];
THETA_range = [];
THETA_min   = [];
for ii = 1:ntheta
    THETA_range      = mdiag(THETA_range      , eye(rTHETA(ii))*theta_range(ii)  );
    THETA_min        = mdiag(THETA_min        , eye(rTHETA(ii))*theta_bnd(ii, 1) );
    eval(['utheta(ii, 1)       = utheta' , num2strChars(ii, 2), ';']);
    eval(['uNtheta(ii, 1)      = uNtheta', num2strChars(ii, 2), ';']);
end

%% Generate the approximate LPV model based on the parameters phi
% Details are described in (Kwiatkowski, Werner; PCA-Based Parameter Set Mappings for LPV Models
% With Fewer Parameters and Less Overbounding)
% This system with reduced number of LPV parameters seems to be most
% realistic to work in real implementation


Us        = UsGrid; 
phi_bnd   = phi_bndGrid;
phi_range = phi_rangeGrid;
phi_mid   = phi_midGrid;
nphi      = nphiGrid;

% Create the uncertain parameter vector phi from the data obtained during
% the pca mapping
phi   = [];
for ii = 1:nphi
    uphi{ii}  = ureal(['phi', num2strChars(ii, 2)], phi_mid(ii), 'Range', [phi_bnd(ii, 1), phi_bnd(ii, 2)]);
    phi       = [phi; uphi{ii}];
end

% The overall goal is to substitute phi into the model matrices of
% P(theta). This can be done by substituting the thetas in P(theta) by
% theta_hats that are expressed through phi => theta_hat = N^(-1)*Us*phi,
% where N^(-1) reverts the scaling that was introduced  with mapminmax.
% 3 Steps:
% 1) eta = Us * phi;
% 2) theta_hat = N^-1{eta} (this reverses the scaling)
% 3) substitute theta_hat(phi) for theta in P(theta) to get P(phi)

% 1)
eta = Us*phi;  
% 2) This is the reverse scaling of mapminmax
% formula: y = (ymax-ymin)*(x-xmin)/(xmax-xmin) + ymin; (ymin=-1,ymax=1)
% reversed formula: x = (y + 1)*(xmax-xmin)/2 + xmin
theta_hat     = umat(zeros(ntheta, 1));
for ii = 1:ntheta
    theta_hat(ii)     = (eta(ii) + 1)*theta_range(ii)/2 + theta_bnd(ii, 1);
end
% 3) Substitute for Phi
MRLFR_Nphi = MRLFR_Ntheta;
for ii = 1:ntheta
    MRLFR_Nphi = usubs(MRLFR_Nphi, ['utheta', num2strChars(ii, 2)], theta_hat(ii));
end

MRLFR_Nphi = simplify(MRLFR_Nphi, 'full');
% Remove simplification schmutz
MRLFR_Nphi = uss(MRLFR_Nphi.a, MRLFR_Nphi.b, MRLFR_Ntheta.c, zeros(size(MRLFR_Nphi.d)));
% MRLFR_Nphi = uss(MRLFR_Nphi.a, MRLFR_Nphi.b, MRLFR_Ntheta.c, MRLFR_Nphi.d);
MRLFR_Nphi = simplify(MRLFR_Nphi, 'full');

[MR_Nphi , uNPHI,  MR_Nphi_Blkstruct, ~] = lftdata(MRLFR_Nphi);

rPHI      = [MR_Nphi_Blkstruct.Occurrences];
PHI_range = [];
PHI_min   = [];
for ii = 1:nphi
    PHI_range      = mdiag(PHI_range      , eye(rPHI(ii))*phi_range(ii)  );
    PHI_min        = mdiag(PHI_min        , eye(rPHI(ii))*phi_bnd(ii, 1) );
end

    uphiK   = Us'*(diag(2./theta_range)*(utheta - theta_min) - ones(ntheta,1));
    uphiK   = Us'*uNtheta;
    

    uPHIofTHETAK = uNPHI;
%     uPHIofTHETAK = (2*PHI_range^-1*(uPHIofTHETAK - PHI_min) - I(size(uNPHI)));
    for ii = 1:nphi
        uPHIofTHETAK = usubs(uPHIofTHETAK, ['phi', num2strChars(ii, 2)], uphiK(ii));
    end
    
    uPHIofTHETAK = simplify(uPHIofTHETAK, 'full');
    
    [uPHIofTHETAKmat, uPHIofTHETAK_DELTA, Blkstruct_uPHIofTHETAK, ~] = lftdata(uPHIofTHETAK);
    rphiofthetaK       = sum(diag(rPHI)*abs(sign(Us')), 1);%[Blkstruct_uPHIofTHETAK.Occurrences];
    nphiofthetaK       = size(rphiofthetaK, 2);
    nPHIofTHETAK       = sum(rphiofthetaK);
    nzphiofthetaKth    = size(uPHIofTHETAK, 2);
    nwphiofthetaKth    = size(uPHIofTHETAK, 1);
    
    U11 = uPHIofTHETAKmat(         (1):(nPHIofTHETAK),          (1):(nPHIofTHETAK));
    U12 = uPHIofTHETAKmat(         (1):(nPHIofTHETAK), (nPHIofTHETAK+1):(end)     );
    U21 = uPHIofTHETAKmat((nPHIofTHETAK+1):(end )    ,          (1):(nPHIofTHETAK));
    U22 = uPHIofTHETAKmat((nPHIofTHETAK+1):(end )    , (nPHIofTHETAK+1):(end)     );
    
    maxx = sign(Us(:,1)');
    MAXX = [];
    for ii = 1:ntheta
        MAXX = mdiag(MAXX, maxx(ii)*eye(rphiofthetaK(ii)));
    end

%% Chose for which system you want to synthesis the controller
%MRLFR_NPhi; or MRLFR_Ntheta; or: MRLFR_Ndelta
selected_system = MRLFR_Ntheta; 

%% Construct Generalized Plant for the models, function returns it in uss-form

[PLFR,GLFR, WS, WK, WR,nu,ne ] = generalizedPlant_3DOF(selected_system);
[nominalsystem , uncertainty, Blkstruct,~] = lftdata(PLFR);

%% Construct controller mask
% This mask will be used in the controller synthesis algorithm
nx    = size(PLFR.A, 1);
nwup = size(uncertainty, 1);
nzup = size(uncertainty, 2);
nyP = 6;
ny = ne;
KLFRmask.A       = 1*indexMat(  nx  , nx  );
KLFRmask.B_u     = 1*indexMat(  nx  , nyP );
KLFRmask.C_y     = 1*indexMat(  nu  , nx  );
KLFRmask.D_yu    = 1*indexMat(  nu  , nyP );
KLFRmask.B_th    = 1*indexMat(  nx  , nwup);
KLFRmask.D_thth  = 1*indexMat(  nzup, nwup);
KLFRmask.D_yth   = 1*indexMat(  nu  , nwup);
KLFRmask.D_thu   = 1*indexMat(  nzup, nyP );
KLFRmask.C_th    = 1*indexMat(  nzup, nx  );
KLFRmask.THETAK  = 1*indexMat(  nzup, nwup);

%% Check Existence Condition (%choose DG or FBSM)
   [CLLFR]         = min_gamma_over_RSPi( PLFR, nu, ne, 'DG', LMIsolverParameterSet(1));
%% Controller Construction
    [KLFR, CLLFR]   = min_gamma_over_K( PLFR, KLFRmask, CLLFR, nu, ne, LMIsolverParameterSet(2));

%% Discretize controller to get struct dKLFR_sim --> used in SIMULINK - Simulation

 KLFR_sim = model_struct2uss(KLFR);
 dKLFR_sim = uc2d(KLFR_sim, 0.001, 'tustin');
 dKLFR_sim = model_uss2struct(dKLFR_sim, ny, nu);


%% save important data to file
%thisdate = datestr(now,'yyyy-mm-dd_HH-MM');
%save(['LPV_3DOF_controller_data_',thisdate,'.mat'],'WK','WR','WS','rho_bnd','theta_bnd','theta_mid','theta_min','theta_range','qdbounds','qbounds','MRLFR_Ndelta','MRLFR_Ntheta','KLFR_sim','dKLFR_sim','delta_bnd','delta_mid','delta_range');

