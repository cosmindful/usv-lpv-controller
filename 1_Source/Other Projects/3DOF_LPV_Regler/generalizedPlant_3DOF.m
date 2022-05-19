function [PLFR, GLFR, WS, WK, WR, nu, ne] = generalizedPlant_3DOF(MRLFR);

s = tf('s');

% get the number of outputs and number of inputs of the uss
ny = size(MRLFR, 1); %number 
nu = size(MRLFR, 2);
ne    =  ny; %error signal

% Decompose lft into nominal and uncertain part
[M_MRLFR, Delta_MRLFR, Blkstruct_MRLFR, Normunc_MRLFR] = lftdata(MRLFR);

% Determine sizes
nwPth = size(Delta_MRLFR, 1); %size of w-signal
nzPth = size(Delta_MRLFR, 1); %size of z-signal
nxP   = size(M_MRLFR.a  , 1); %number of states

% Define plant matrices

%       |     x |   w   |  u
%-----------------------------
% xdot  | A     | Bth   | Bu
% z     | Cth   | Dthth | Dthu
% y     | Cy    | Dyth  | Dyu

A       = M_MRLFR.a;
B_th    = M_MRLFR.b(  :          , (1:nwPth)      );
C_th    = M_MRLFR.c((1:nzPth)    ,   :            );
D_thth  = M_MRLFR.d((1:nzPth)    , (1:nwPth)      );

B_u     = M_MRLFR.b(        :    , ((nwPth+1):end));
C_y     = M_MRLFR.c((nzPth+1:end),           :    );
D_thu   = M_MRLFR.d((1:nzPth)    , ((nwPth+1):end));
D_yth   = M_MRLFR.d((nzPth+1:end), (1:nwPth)      );
D_yu    = M_MRLFR.d((nzPth+1:end), ((nwPth+1):end));
   
% 2 Block design with inputs w, p=[r,d_in]^T, u
% outputs [q(S/KS),e] where e=[r,e]^T
nzPp   = ne + nu;
nwPp   = ne + nu;

%       |     x |   w   |   p   |  u
%----------------------------------
% xdot  | A     | Bth   | Bp    | Bu
% z     | Cth   | Dthth |  0    | Dthu
% q     | Cp    | 0     | Dpp   | Dthu
% e     | Ce    | Deth  | Dep   | 0
%----------------------------------

B_p   = [ O(nxP, nwPp-nu), B_u ];
C_p   = [           -C_y ;...
              O(nu, nxP) ];
C_e   = [O(ne, nxP) ;...
         C_y       ];
D_thp = O(nzPth, nwPp  );
D_pth = O(nzPp , nwPth );
D_pp  = [ I(nzPp , nwPp-nu), O(nzPp , nu) ];
D_pu  = [ O(nzPp-nu, nu );...
          I(nu)         ];
D_eth = [O(ne, nwPth) ;...
         D_yth        ];
D_ep  = [ I(2*ne, nwPp-nu), O(2*ne, nu) ];
D_eu  = [ O(2*ne, nu) ];
      
nu = nu;
ne = 2*ne; %ne is now twice the size since 2 block design e=[r,e]

%% Assemble the matrices to form nominal ss model
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
% add back in the uncertainty to create uss
PLFR         = lft(Delta_MRLFR, PLFR_temp.ss);

%%
GLFR_temp = [];
% GLFR_temp.A = A;
% GLFR_temp.B = [B_th, B_p, B_u];
% GLFR_temp.C = [C_th;...
%                C_p ;...
%                C_e];
% GLFR_temp.D = [D_thth, D_thp, D_thu;...
%                D_pth , D_pp , D_pu ;...
%                D_eth , D_ep , D_eu ];
%              
% GLFR_temp.ss = ss(PLFR_temp.A, PLFR_temp.B, PLFR_temp.C, PLFR_temp.D);
% GLFR         = lft(Delta_MRLFR, PLFR_temp.ss);
GLFR = [];
%% Filter Design

% create filter to formulate restrictions on the frequencies of the
% reference input r (also called Vr)
Mr1 = 20; wr1 = 20;
Mr2 = 20; wr2 = 20;
Mr3 = 20; wr3 = 20;
Wr1 = Mr1/(s+wr1);
Wr2 = Mr2/(s+wr2);
Wr3 = Mr3/(s+wr3);
Wr  = mdiag(Wr1, Wr2, Wr3);

% create lowpass filter Wu for input u
Wb=tf(1,[0.01, 1]);
Wu=ss(Wb)*I(nu);

% create filter Wd for input disturbance input d (part of p)
Wid1= tf(0.1,[0.5, 1]);
Wid = ss(Wid1)*I(nu);

% create sensitivity filter
ws1 = 9e-2; Ms1 = 1e-4;
ws2 = 9e-2; Ms2 = 1e-4;
ws3 = 1e-1; Ms3 = 1e-4;
Ws1 = tf([ws1/Ms1],[1 ws1]);
Ws2 = tf([ws2/Ms2],[1 ws2]);
Ws3 = tf([ws3/Ms3],[1 ws3]);
Ws  = mdiag(Ws1, Ws2, Ws3);

% create control sensitivity filter
wk1 = 1e2; Mk1 = 1e3;c1 = 1e3; 
wk2 = 1e2; Mk2 = 1e3;c2 = 5e2; 
wk3 = 1e2; Mk3 = 1e3;c3 = 5e2; 
Wk1  = c1/Mk1*tf([1 wk1],[1 c1*wk1]);
Wk2  = c2/Mk2*tf([1 wk2],[1 c2*wk2]);
Wk3  = c3/Mk3*tf([1 wk3],[1 c3*wk3]);
Wk = mdiag(Wk1,Wk2,Wk3);


% show sigma plot of filters
dWs1 = c2d(Ws1, 0.001, 'tustin');
dWs2 = c2d(Ws2, 0.001, 'tustin');
dWs3 = c2d(Ws3, 0.001, 'tustin');
dWk1  = c2d(Wk1 , 0.001, 'tustin');
dWk2  = c2d(Wk1 , 0.001, 'tustin');
dWk3  = c2d(Wk1 , 0.001, 'tustin');

sigma(1/dWs1, 1/dWs2, 1/dWs3, 1/dWk1, 1/dWk2, 1/dWk3)

% create ss models
WS = ss(Ws);
WK = ss(Wk);
WR = ss(Wr);

%% JUST A TEST (DELETE LATER)
% Wid = ss(eye(3));
% Wu = ss(eye(3));
% % create output filter matrix Wo to attach to PLFR and dont alter the output e=[r,e]
% Wo = mdiag(WS, WK, I(ne)); 
% 
% % create input filter matrix Wi to filter input signal vector [r,d_in,u]^T
% Wi = mdiag(WR, Wid, Wu);
% 
% % Add filters to generalized plant
% PLFR = Wo*PLFR*Wi;
