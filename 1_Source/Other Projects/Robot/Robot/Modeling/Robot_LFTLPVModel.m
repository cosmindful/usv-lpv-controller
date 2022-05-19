%% LFT LPV Modeling of a 2-DOF Robotic Manipulator
% -------------------------------------------------------------------------
% script   : Robot_LFTLPVModel
% -------------------------------------------------------------------------
% Author   : Christian Hoffmann
% Version  : August, 2nd 2013
% Copyright: CH, 2013
% -------------------------------------------------------------------------
%
% 1. Model the plant as an LPV model with rational dependency on its 
%    parameters in a LFT representation (uncertain state-space model)
% -------------------------------------------------------------------------
% LFT parameters
udelta1 = ureal('udelta1', delta_mid(1), 'Range', [delta_bnd(1, 1), delta_bnd(1, 2)]);
udelta2 = ureal('udelta2', delta_mid(2), 'Range', [delta_bnd(2, 1), delta_bnd(2, 2)]);
udelta3 = ureal('udelta3', delta_mid(3), 'Range', [delta_bnd(3, 1), delta_bnd(3, 2)]);
udelta4 = ureal('udelta4', delta_mid(4), 'Range', [delta_bnd(4, 1), delta_bnd(4, 2)]);
udelta5 = ureal('udelta5', delta_mid(5), 'Range', [delta_bnd(5, 1), delta_bnd(5, 2)]);
udelta6 = ureal('udelta6', delta_mid(6), 'Range', [delta_bnd(6, 1), delta_bnd(6, 2)]);

uv               = b7*b1+b2*b8 + (b7-b2+b8 - udelta1*b3 )*udelta1*b3;
uthetaofdelta01  = 1                                              /uv;
uthetaofdelta02  =         udelta2*udelta3                        /uv;
uthetaofdelta03  = udelta1                                        /uv;
uthetaofdelta04  = udelta1*udelta2*udelta3                        /uv;
uthetaofdelta05  =                                 udelta5        /uv;
uthetaofdelta06  =         udelta2        *udelta4                /uv;
uthetaofdelta07  =                                         udelta6/uv;
uthetaofdelta08  = udelta1                                *udelta6/uv;
uthetaofdelta09  = udelta1                        *udelta5        /uv;
uthetaofdelta10  = udelta1*udelta2        *udelta4                /uv;

uthetaofdelta    = [ uthetaofdelta01 ;...
                     uthetaofdelta02 ;...
                     uthetaofdelta03 ;...
                     uthetaofdelta04 ;...
                     uthetaofdelta05 ;...
                     uthetaofdelta06 ;...
                     uthetaofdelta07 ;...
                     uthetaofdelta08 ;...
                     uthetaofdelta09 ;...
                     uthetaofdelta10 ];

%% Full Scheduling Order Plant Model   
    A = [-uthetaofdelta02*(b3*b7-b3*b2) - uthetaofdelta03*b3*b9         - uthetaofdelta01*(b6*b7+b2*b9) + uthetaofdelta04*b3^2 ,  uthetaofdelta01*b2*b9 + uthetaofdelta03*b3*b9 + uthetaofdelta06*b7*b3                        , uthetaofdelta05*b5*b7                         , uthetaofdelta07*(b7*b4-b2*b4) - uthetaofdelta08*b3*b4; ...
         -uthetaofdelta02*(b3*b1+b3*b8) + uthetaofdelta03*(b3*b9+b3*b6) + uthetaofdelta01*(b1*b9-b6*b8)                        , -uthetaofdelta01*b1*b9 - uthetaofdelta03*b3*b9 + uthetaofdelta06*b3*b8 - uthetaofdelta10*b3^2 , uthetaofdelta05*b5*b8 - uthetaofdelta09*b5*b3 , uthetaofdelta07*(b8*b4+b1*b4)                        ; ...
          1                                                                                                                    , 0                                                                                             , 0                                             , 0                                                    ; ...
          0                                                                                                                    , 1                                                                                             , 0                                             , 0                                                    ];
      
    B = [uthetaofdelta01*b7                     , -uthetaofdelta01*b2 - uthetaofdelta03*b3 ;...
         uthetaofdelta01*b8 - uthetaofdelta03*b3,  uthetaofdelta01*b1 + uthetaofdelta03*b3 ;...
         0                                      ,  0                                       ;...
         0                                      ,  0                                       ];
     
    C = [0 , 0 , 1 , 0 ;...
         0 , 0 , 0 , 1  ];
     
    D = [0 , 0 ;...
         0 , 0 ];
    
MLFR_delta = uss(A, B, C, D);
MLFR_delta = simplify(MLFR_delta, 'full');