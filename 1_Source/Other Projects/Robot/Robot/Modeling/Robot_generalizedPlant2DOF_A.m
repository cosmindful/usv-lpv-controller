function [PLFR, GLFR, WS, WK, WR, nu, ne] = robot2DOF_generalizedPlant2DOF(MRLFR);

s = tf('s');

ny = size(MRLFR, 1);
nu = size(MRLFR, 2);

Mb=1000; wb=1000;
Wb=Mb/(s+wb)*eye(nu);
Wi=ss(Wb);
Wi = I(nu);
Wo = I(ny); 

% MRLFR = Wo*MRLFR*Wi;
MRLFR = simplify(MRLFR, 'full');

[M_MRLFR, Delta_MRLFR, Blkstruct_MRLFR, Normunc_MRLFR] = lftdata(MRLFR);

nwPth = size(Delta_MRLFR, 1);
nzPth = size(Delta_MRLFR, 1);
nxP   = size(M_MRLFR.a  , 1);

A       = M_MRLFR.a;
B_th    = M_MRLFR.b(  :          , (1:nwPth)      );
C_th    = M_MRLFR.c((1:nzPth)    ,   :            );
D_thth  = M_MRLFR.d((1:nzPth)    , (1:nwPth)      );

B_u     = M_MRLFR.b(        :    , ((nwPth+1):end));
C_y     = M_MRLFR.c((nzPth+1:end),           :    );
D_thu   = M_MRLFR.d((1:nzPth)    , ((nwPth+1):end));
D_yth   = M_MRLFR.d((nzPth+1:end), (1:nwPth)      );
D_yu    = M_MRLFR.d((nzPth+1:end), ((nwPth+1):end));
   
    
%% Construct generalized plant for 2DOF Design
nu     = size(MRLFR, 2);
ne     = size(MRLFR, 1);

nzPp   = ne + nu;
nwPp   = ne;

% if (nwPp < nzPp)
%     nwPp = nzPp;
% end

B_p   = O(nxP, nwPp);
C_p   = [           -C_y ;...
              O(nu, nxP) ];
C_e   = [ O(ne, nxP)  ;...
          C_y        ];
D_thp = O(nzPth, nwPp  );
D_pth = O(nzPp , nwPth );
D_pp  = I(nzPp , nwPp  );
D_pu  = [ O(nzPp-nu, nu );...
          I(nu)         ];
D_eth = [ O(ne, nwPth)  ;...
          D_yth         ];
D_ep  = [ I(ne)         ;...
          O(ne, nwPp)   ];
D_eu  = [ O(ne, nu)     ;...
          O(ne, nu)     ];
      
nu = nu;
ne = 2*ne;

%%
PLFR_temp = [];
PLFR_temp.A = A;
PLFR_temp.B = [B_th, B_p, B_u];
PLFR_temp.C = [C_th;...
               C_p ;...
               C_e];
PLFR_temp.D = [D_thth, D_thp, D_thu;...
               D_pth , D_pp , D_pu ;...
               D_eth , D_ep , D_eu ];
             
PLFR_temp.ss = ss(PLFR_temp.A, PLFR_temp.B, PLFR_temp.C, PLFR_temp.D);
PLFR         = lft(Delta_MRLFR, PLFR_temp.ss);

%% Shaping Filter Design
    
Mr2 = 20; wr2 = 20;
Mr3 = 20; wr3 = 20;
Wr2 = Mr2/(s+wr2);
Wr3 = Mr3/(s+wr3);
Wr  = mdiag(Wr2, Wr3);

ws2 = 8e-5; Ms2 = 1e-6;
ws3 = 8e-5; Ms3 = 1e-6;
Ws2 = tf([ws2/Ms2],[1 ws2]);
Ws3 = tf([ws3/Ms3],[1 ws3]);
Ws  = mdiag(Ws2, Ws3);

wk  = 8e1; Mk = 1e3;c = 1e3;
Wk  = c/Mk*tf([1 wk],[1 c*wk])*eye(nu);

dWs2 = c2d(Ws2, 0.001, 'tustin');
dWs3 = c2d(Ws3, 0.001, 'tustin');
dWk  = c2d(Wk , 0.001, 'tustin');
figure;
sigma(1/dWs2, 1/dWs3, 1/dWk);

Wb = tf([1],[0.01 1])*eye(nu);
Wi = ss(Wb);


%% 
WS = ss(Ws);
WK = ss(Wk);
WR = ss(Wr);

Wo = mdiag(WS, WK, I(ne)); 
Wi = mdiag(WR,     Wi   );

%%
PLFR = Wo*PLFR*Wi;
PLFR = simplify(PLFR, 'full');