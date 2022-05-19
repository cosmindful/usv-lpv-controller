function KLFR = construct_ControllerClosedFormSolution(PLFR, uR, uS, gopt, nu, ne)

ucalA    = PLFR.A;
ucalB_p  = PLFR.B(          :        ,       (1):(end-nu));
ucalB_u  = PLFR.B(          :        ,(end-nu+1):(end)   );
ucalC_p  = PLFR.C(       (1):(end-ne),          :        );
ucalD_pp = PLFR.D(       (1):(end-ne),       (1):(end-nu));
ucalD_pu = PLFR.D(       (1):(end-ne),(end-nu+1):(end)   );
ucalC_y  = PLFR.C((end-ne+1):(end)   ,          :        );
ucalD_yp = PLFR.D((end-ne+1):(end)   ,       (1):(end-nu));
ucalD_yu = PLFR.D((end-ne+1):(end)   ,(end-nu+1):(end)   );

nxP      = size(PLFR.A, 1);

%% Controller Formulae
uM = I(nxP) - uR*uS;
uN = I(nxP);

% Sigma = I(nx) - uR*uS;
% [USigma, SSigma, VSigma] = svd(Sigma);

% Sigma_ = USigma*SSigma*VSigma';

% uM = USigma*SSigma;
% uN = VSigma';
% uN = uN';

uF  = -( ucalD_pu' * ucalD_pu ) \ ( gopt * (ucalB_u')/uR + ucalD_pu' * ucalC_p );
uL  = -( gopt * uS^-1 * ucalC_y' + ucalB_p * ucalD_yp' ) / ( ucalD_yp * ucalD_yp' );
        
uAK = - uN \ ( ucalA' + uS * ( ucalA + ucalB_u * uF + uL * ucalC_y ) * uR ...
               + gopt^-1 * uS * ( ucalB_p + uL * ucalD_yp ) * ucalB_p' ...
               + gopt^-1 * ucalC_p' * ( ucalC_p + ucalD_pu * uF ) * uR ) / (uM');
           
uBK  = (uN\uS)*uL;
% uBK_ = (uN^-1 * uS)*uL;

uCK = uF * (uR/(uM'));

uDK = O(ne, nu);

uK   = [ uAK, uBK ;
         uCK, uDK ];
     
uK   = simplify(uK, 'full');

     
% uK   = usubs(uK, 'unc', 0);     
     
[MK, THETA_K, Blkstruct_K, Normunc_K] = lftdata(uK);

nxK   = size(uAK, 1);
nwKth = size(THETA_K, 2);
nzKth = size(THETA_K, 1);

MK11    = MK(       (1):       (nzKth),        (1):(nwKth)         );
MK12    = MK(       (1):       (nzKth),  (nwKth+1):(end)           );
MK21    = MK( (nzKth+1):         (end),        (1):(nwKth)         );
MK22    = MK( (nzKth+1):         (end),  (nwKth+1):(end)           );

DK_thth = MK11;
CK_th   = MK12(:,       (1):(nxK)   );
DK_thy  = MK12(:,   (nxK+1):(end)   );
BK_th   = MK21(         (1):(nxK), :);
DK_uth  = MK21(     (nxK+1):(end), :);
AK_0    = MK22(         (1):(nxK),     (1):(nxK));
BK_y    = MK22(         (1):(nxK), (nxK+1):(end));
CK_u    = MK22(     (nxK+1):(end),     (1):(nxK));
DK_uy   = MK22(     (nxK+1):(end), (nxK+1):(end));

MK11  = DK_thth;

MK12  = [ CK_th DK_thy ];

MK21  = [ BK_th  ;
          DK_uth ];
      
MK22  = [ AK_0  BK_y  ;   
          CK_u  DK_uy ];
      
KLFR.A      = AK_0;
KLFR.B_u    = BK_y;
KLFR.C_y    = CK_u;
KLFR.D_yu   = DK_uy;
KLFR.B_th   = BK_th;
KLFR.D_thth = DK_thth;
KLFR.D_yth  = DK_uth;
KLFR.D_thu  = DK_thy;
KLFR.C_th   = CK_th;
KLFR.THETA  = THETA_K;