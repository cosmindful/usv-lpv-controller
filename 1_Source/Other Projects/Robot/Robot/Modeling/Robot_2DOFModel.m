%% Affine and LFT Modeling of a 2-DOF Robotic Manipulator
% -------------------------------------------------------------------------
% script   : Robot_2DOFModel
% -------------------------------------------------------------------------
% Author   : Christian Hoffmann
% Version  : August, 2nd 2013
% Copyright: CH, 2013
% -------------------------------------------------------------------------
%
% 1. Model the plant as both reduced scheduling order polytopic LPV model
%    and as a full order LFT model
% 2. Generate generalized plant
%
% -------------------------------------------------------------------------

load 2DOFTrajectory; % Load measured typical data
generateGrid;        % ... or generate gridded data

% q1    - Angle of joint 1 in [rad]
% q2    - Angle of joint 2 in [rad]
% q3    - Angle of joint 3 in [rad]
% qd1   - Angular velocity of joint 1 in [rad/s]
% qd2   - Angular velocity of joint 2 in [rad/s]
% qd3   - Angular velocity of joint 3 in [rad/s]
% t     - Time in [s]

q   = [ q1;  q2;  q3];
qd  = [qd1; qd2; qd3];

%%
 q_bnd = [  min( q, [], 2)    max(q, [], 2) ];
qd_bnd = [  min(qd, [], 2)   max(qd, [], 2) ];

% Generate data matrix by horizontal concatenation of affine LPV parameter
% vector samples
THETA  = robot2DOFaffineLPVparams(q, qd);
ntheta = size(THETA, 1);

theta_bnd   = [  min(THETA, [], 2)    max(THETA, [], 2) ];
theta_mid   = (theta_bnd(:,2) + theta_bnd(:,1))/2;
theta_range =  theta_bnd(:,2) - theta_bnd(:,1);

%%
[NTHETA, Ntheta_Nrmlz] = mapminmax(THETA);
Ntheta_bnd      = [  min(NTHETA, [], 2)    max(NTHETA, [], 2) ];
Ntheta_mid      = (Ntheta_bnd(:,2) + Ntheta_bnd(:,1))/2;
Ntheta_range    = (Ntheta_bnd(:,2) - Ntheta_bnd(:,1));

% LFT Parameters
DELTA  = robot2DOFLFTLPVparams(q, qd);
ndelta = size(DELTA, 1);

delta_bnd   = [  min(DELTA, [], 2)    max(DELTA, [], 2) ];
delta_mid   = (delta_bnd(:,2) + delta_bnd(:,1))/2;
delta_range =  delta_bnd(:,2) - delta_bnd(:,1);

%% Parameter Set Mapping for Theta from Gridding
requiredAccuracy    = 80;      % Specify the required accuracy after PSM
requirednphi        = 2;       % Specify the number of reduced parameters (0 to let accuracy decide)
normalizationMethod = 'pm1';   % Specify the type of normalization: pm1 -> normalize to +-1

[NTHETA_hat, ...
 PHI       , ...
 phi_bnd   , ...
 Us        , ...
 nphi      , ...
 percerr   , ...
 dSIG      , ...
 Nrmlz_data      ] = parameterSetMapping(NTHETA              , ...
                                         requiredAccuracy    , ...
                                         requirednphi        , ...
                                         normalizationMethod       );
                                     
phi_mid   = (phi_bnd(:,2) + phi_bnd(:,1))/2;
                                     
%% Construct Convex Hull with Reduced Overbounding
% For finding a tight convex hull, we are making use of the fact, that the
% reduced parameter space is only two-dimensional by design
figure; hold on
scatter(PHI(1, 1:20:end), PHI(2, 1:20:end), '.');
xlabel('\phi_1');
ylabel('\phi_2');

phi_vertices12 = [-2.25 -0.25 ;...
                  -2.25  0.50 ;...
                   1.20  2.00 ;...
                   2.35  0.75 ;...
                   2.25 -0.75 ;...
                   0.90 -2.00 ];
               
phi_verticesBox12 = [ phi_bnd(1, 1), phi_bnd(2, 1) ;...
                      phi_bnd(1, 2), phi_bnd(2, 1) ;...
                      phi_bnd(1, 2), phi_bnd(2, 2) ;...
                      phi_bnd(1, 1), phi_bnd(2, 2) ];
            
line([phi_vertices12(:, 1); phi_vertices12(1, 1)], [phi_vertices12(:, 2); phi_vertices12(1, 2)]);
line([phi_verticesBox12(:, 1); phi_verticesBox12(1, 1)], [phi_verticesBox12(:, 2); phi_verticesBox12(1, 2)]);

vertices       = phi_verticesBox12;
nVerticesPhi   = size(vertices, 1);
pVerticesPhi   = pvec('box', phi_bnd);
v              = Polytope2D_GetNormals(vertices);

pv = pvec('pol', [vertices']);
pv = pvec('box', phi_bnd);
       
%% Identified Parameters
b1 = 0.0715;
b2 = 0.0058;
b3 = 0.0114;
b4 = 0.3264;
b5 = 0.3957;
b6 = 0.6253;
b7 = 0.0749;
b8 = 0.0705;
b9 = 1.1261;
b  = [b1;b2;b3;b4;b5;b6;b7;b8;b9]';

%% Construct Affine Model
Robot_AffineLPVModel;
%% Construct LFT Model
Robot_LFTLPVModel;
%% Construct Generalized Plant
PLFR_theta = Robot_generalizedPlant2DOF(MLFR_theta);
PLFR_delta = Robot_generalizedPlant2DOF(MLFR_delta);
PLFR_phi   = Robot_generalizedPlant2DOF_A(MLFR_phi  );

for ii = 1:nVerticesPhi
    PLFR_phi_vertices{ii} = usubs(PLFR_phi, 'phi01', phi_verticesBox12(ii, 1), 'phi02', phi_verticesBox12(ii, 2));
    PLFR_phi_vertices{ii} = ltisys(PLFR_phi_vertices{ii}.A, ...
                                   PLFR_phi_vertices{ii}.B, ...
                                   PLFR_phi_vertices{ii}.C, ...
                                   PLFR_phi_vertices{ii}.D);
end

%% Construct controller mask
nx   = size(PLFR_theta.A, 1);
nu   = 2;
ny   = 4;

[~ ,~ ,BlockStructure, ~] = lftdata(PLFR_delta);
nwth = sum([BlockStructure.Occurrences]);
nzth = nwth;


KLFRmask.A       = 1*indexMat(  nx  , nx  );
KLFRmask.B_u     = 1*indexMat(  nx  , ny  );
KLFRmask.C_y     = 1*indexMat(  nu  , nx  );
KLFRmask.D_yu    = 0*indexMat(  nu  , ny  );
KLFRmask.B_th    = 1*indexMat(  nx  , nwth);
KLFRmask.D_thth  = 0*indexMat(  nzth, nwth);
KLFRmask.D_yth   = 1*indexMat(  nu  , nwth);
KLFRmask.D_thu   = 1*indexMat(  nzth, ny  );
KLFRmask.C_th    = 1*indexMat(  nzth, nx  );
KLFRmask.THETAK  = 1*indexMat(  nzth, nwth);