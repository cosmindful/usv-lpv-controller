function [DeltaK, MLFRDeltaK, DELTAK]  = construct_controllerSchedulingFunction(P, DeltaP);

% From    [  I     ]'   [  Re  Se' ]    [  I     ]
%         [    DD  ]    [  Se  Qe  ]    [    DD  ]
% 
% 
% [  I     ] = [  I     ]
% [    DD  ]   [     I  ]
%              [  DP    ]
%              [     DK ]
% 
% perform Schur to get
% 
% [  U       W' + DD' ] = [  Re - Se'Qe^-1Se   DD' + Se'Qe^-1 ]
% [  DD + W  V        ]   [  DD + Qe^-1Se     -Qe^-1          ]

nzDD = size(P, 2)/2;
nzD  = nzDD/2;

Re = P(                (1):(nzDD),             (1):(nzDD));
Se = P(           (nzDD+1):(end ),             (1):(nzDD));
Qe = P(           (nzDD+1):(end ),        (nzDD+1):(end ));

U  = Re - Se'*Qe^-1*Se;
W  =          Qe^-1*Se;
V  =         -Qe^-1   ;

[U11, U12, U21, U22] = mat2x2(U);
[W11, W12, W21, W22] = mat2x2(W);
[V11, V12, V21, V22] = mat2x2(V);


M = [ U11  W11'
      W11  V11 ];
  
B = [ U12 ;...
      W12 ];
  
Y = [ W21    V21 ];
  
MLFRDeltaK =  [ -M\I(nzDD)       -M\B      ;...
                 Y/M           Y*(M\B)-W22 ] ;
             
DELTAK     =  [ O(nzD),     DeltaP' ;...
                DeltaP,     O(nzD)  ];

DeltaK     = lft(DELTAK, MLFRDeltaK);