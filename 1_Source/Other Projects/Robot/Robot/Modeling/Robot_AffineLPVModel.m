%% Affine LPV Modeling of a 2-DOF Robotic Manipulator
% -------------------------------------------------------------------------
% script   : Robot_AffineLPVModel
% -------------------------------------------------------------------------
% Author   : Christian Hoffmann
% Version  : August, 2nd 2013
% Copyright: CH, 2013
% -------------------------------------------------------------------------
%
% 1. Model the plant as an affine LPV model in a LFT representation
%    (uncertain state-space model)
% 2. Substitute reduced parameter vector
% -------------------------------------------------------------------------

 utheta01 = ureal('utheta01', theta_mid( 1), 'Range', [theta_bnd( 1, 1)  theta_bnd( 1, 2)]);
 utheta02 = ureal('utheta02', theta_mid( 2), 'Range', [theta_bnd( 2, 1)  theta_bnd( 2, 2)]);
 utheta03 = ureal('utheta03', theta_mid( 3), 'Range', [theta_bnd( 3, 1)  theta_bnd( 3, 2)]);
 utheta04 = ureal('utheta04', theta_mid( 4), 'Range', [theta_bnd( 4, 1)  theta_bnd( 4, 2)]);
 utheta05 = ureal('utheta05', theta_mid( 5), 'Range', [theta_bnd( 5, 1)  theta_bnd( 5, 2)]);
 utheta06 = ureal('utheta06', theta_mid( 6), 'Range', [theta_bnd( 6, 1)  theta_bnd( 6, 2)]);
 utheta07 = ureal('utheta07', theta_mid( 7), 'Range', [theta_bnd( 7, 1)  theta_bnd( 7, 2)]);
 utheta08 = ureal('utheta08', theta_mid( 8), 'Range', [theta_bnd( 8, 1)  theta_bnd( 8, 2)]);
 utheta09 = ureal('utheta09', theta_mid( 9), 'Range', [theta_bnd( 9, 1)  theta_bnd( 9, 2)]);
 utheta10 = ureal('utheta10', theta_mid(10), 'Range', [theta_bnd(10, 1)  theta_bnd(10, 2)]);

% Full Scheduling Order Plant Model   
    A = [-utheta02*(b3*b7-b3*b2) - utheta03*b3*b9         - utheta01*(b6*b7+b2*b9) + utheta04*b3^2 ,  utheta01*b2*b9 + utheta03*b3*b9 + utheta06*b7*b3                 , utheta05*b5*b7                  , utheta07*(b7*b4-b2*b4) - utheta08*b3*b4; ...
         -utheta02*(b3*b1+b3*b8) + utheta03*(b3*b9+b3*b6) + utheta01*(b1*b9-b6*b8)                 , -utheta01*b1*b9 - utheta03*b3*b9 + utheta06*b3*b8 - utheta10*b3^2 , utheta05*b5*b8 - utheta09*b5*b3 , utheta07*(b8*b4+b1*b4)                 ; ...
          1                                                                                        , 0                                                                 , 0                               , 0                                      ; ...
          0                                                                                        , 1                                                                 , 0                               , 0                                      ];
      
    B = [utheta01*b7            , -utheta01*b2 - utheta03*b3 ;...
         utheta01*b8-utheta03*b3,  utheta01*b1 + utheta03*b3 ;...
         0                      ,  0                         ;...
         0                      ,  0                         ];
     
    C = [0 , 0 , 1 , 0 ;...
         0 , 0 , 0 , 1  ];
     
    D = [0 , 0 ;...
         0 , 0 ];
    
MLFR_theta = uss(A, B, C, D);
MLFR_theta = simplify(MLFR_theta, 'full');

%% Substitute 
phi   = [];
for ii = 1:nphi
    uphi{ii}   = ureal(['phi', num2strChars(ii, 2)], phi_mid(ii), 'Range', [phi_bnd(ii, 1), phi_bnd(ii, 2)]);
    phi       = [phi; uphi{ii}];
end
    
Ntheta    = pinv(Us')*phi; % Ntheta = (Us*Us')\Us * phi;
for ii = 1:ntheta
    theta(ii)     = (Ntheta(ii) + 1)*theta_range(ii)/2 + theta_bnd(ii, 1);
end
   
% Substitute for Phi
MLFR_phi  = MLFR_theta;

for ii = 1:ntheta
    MLFR_phi = usubs(MLFR_phi, ['utheta', num2strChars(ii, 2)], theta(ii));
end
MLFR_phi = simplify(MLFR_phi, 'full');

%% Remove simplification "Schmutz"
MLFR_phi = uss(MLFR_phi.a, MLFR_phi.b, MLFR_theta.c, O(size(MLFR_phi.d)));
MLFR_phi = simplify(MLFR_phi, 'full');