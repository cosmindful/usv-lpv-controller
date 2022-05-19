function [BXaug, BX] = formulateLMI_outerFactorsClosedLoopMatrices(argMatrices, argSizes)

    %% Extract Individual Model Matrices
    AP      = argMatrices.AP;
    BP_p    = argMatrices.BP_p;
    BP_th   = argMatrices.BP_th;
    BP_u    = argMatrices.BP_u;
    CP_p    = argMatrices.CP_p;
    CP_th   = argMatrices.CP_th;
    CP_y    = argMatrices.CP_y;
    DP_pp   = argMatrices.DP_pp; 
    DP_pth  = argMatrices.DP_pth;
    DP_pu   = argMatrices.DP_pu;
    DP_thp  = argMatrices.DP_thp;
    DP_thth = argMatrices.DP_thth;
    DP_thu  = argMatrices.DP_thu;
    DP_yp   = argMatrices.DP_yp;
    DP_yth  = argMatrices.DP_yth;
    DP_yu   = argMatrices.DP_yu;

    AK      = argMatrices.AK;
    DK_thth = argMatrices.DK_thth;
    CK_th   = argMatrices.CK_th;
    DK_thy  = argMatrices.DK_thy;
    BK_th   = argMatrices.BK_th;
    DK_uth  = argMatrices.DK_uth;
    BK_y    = argMatrices.BK_y;
    DK_uy   = argMatrices.DK_uy;
    CK_u    = argMatrices.CK_u;

    %% Extract Problem Sizes
    ne      = size(DP_yu, 1);
    nu      = size(DP_yu, 2);
%     if (DP_yu ~= zeros(size(DP_yu)))
%         error('DP_eu needs to be zero!');
%     end

    nzPp   = size(DP_pp, 1);
    nwPp   = size(DP_pp, 2);

    nxP    = size(AP, 1);

    nzPth   = size(DP_thth, 1);
    nwPth   = size(DP_thth, 2);
    
    nwKth   = argSizes.nwKth;
    nzKth   = argSizes.nzKth;
    nxK     = argSizes.nxK;
    
    %% Construct Outer Factors with Closed Loop Matrices
    
    T11_0 = [ DP_thth          O(nzPth, nwKth) ;...
              O(nzKth, nwPth)  O(nzKth, nwKth) ];

    T12_0 = [ CP_th            O(nzPth, nxK)  DP_thp          ;...
              O(nzKth, nxP)    O(nzKth, nxK)  O(nzKth, nwPp) ];

    T21_0 = [ O(nxP , nwPth)    O(nxP , nwKth)   ;...
              O(nxK , nwPth)    O(nxK , nwKth)   ;...
              BP_th             O(nxP , nwKth)   ;...
              O(nxK , nwPth)    O(nxK , nwKth)   ;...
              O(nwPp, nwPth)    O(nwPp, nwKth)   ;...
              DP_pth            O(nzPp, nwKth)   ];

    T22_0 = [ I(nxP)             O(nxP, nxK)            O(nxP, nwPp) ;...
              O(nxK , nxP)       I(nxK)                 O(nxK, nwPp) ;...
              AP                 O(nxP, nxK)            BP_p         ;...
              O(nxK , nxP)       O(nxK)                 O(nxK, nwPp) ;...
              O(nwPp, nxP)       O(nwPp, nxK)           I(nwPp)      ;...
              CP_p               O(nzPp, nxK)           DP_pp        ];

    Q1    = [ O(nzPth, nzKth)    O(nzPth, nxK)          DP_thu       ;...
              I(nzKth)           O(nzKth, nxK)          O(nzKth, nu) ];

    Q2    = [ O(nxP  , nzKth)    O(nxP  , nxK)          O(nxP  , nu) ;...
              O(nxK  , nzKth)    O(nxK  , nxK)          O(nxK  , nu) ;...
              O(nxP  , nzKth)    O(nxP  , nxK)          BP_u         ;...
              O(nxK  , nzKth)    I(nxK)                 O(nxK  , nu) ;...
              O(nwPp , nzKth)    O(nwPp , nxK)          O(nwPp , nu) ;...
              O(nzPp , nzKth)    O(nzPp , nxK)          DP_pu        ];

    V1    = [ O(nwKth, nwPth)    I(nwKth)      ;...
              O(nxK  , nwPth)    O(nxK, nwKth) ;...
              DP_yth             O(ne , nwKth) ];

    V2    = [ O(nwKth, nxP)      O(nwKth, nxK)     O(nwKth, nwPp) ;...
              O(nxK  , nxP)      I(nxK)            O(nxK  , nwPp) ;...
              CP_y               O(ne   , nxK)     DP_yp          ];
      
    K11   =  DK_thth;

    K12   = [ CK_th  DK_thy ];

    K21   = [ BK_th  ;...
              DK_uth ];

    K22   = [ AK     BK_y   ;...
              CK_u   DK_uy  ];

    K     = [ K11  K12 ;...
              K21  K22 ];
          
    H11   = T11_0 + Q1 * K * V1;
    H12   = T12_0 + Q1 * K * V2;
    H21   = T21_0 + Q2 * K * V1;
    H22   = T22_0 + Q2 * K * V2;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
BX.M11 = [ H11 ];
BX.M12 = [ H12 ];
BX.M21 = [ H21 ];
BX.M22 = [ H22 ];

nwBX1   = size(BX.M11, 2);
nzBX1   = size(BX.M11, 1);
nwBX2   = size(BX.M22, 2);
nzBX2   = size(BX.M22, 1);

BXaug.M   = [ BX.M11      BX.M12               ;...
              I(nwBX1)    O(nwBX1, nwBX2)      ;...
              BX.M21      BX.M22               ];

BXaug.MPiR  = BXaug.M(                        (1):(nzPth+nzKth            ), :);
BXaug.MPiQ  = BXaug.M((nzPth+nzKth            +1):(nzPth+nzKth+nwPth+nwKth), :);
BXaug.MXX   = BXaug.M((nzPth+nzKth+nwPth+nwKth+1):(end-nzPp-nwPp          ), :);
BXaug.MQp   = BXaug.M((end-nzPp-nwPp          +1):(end-nzPp               ), :);
BXaug.MRp   = BXaug.M((end-nzPp               +1):(end                    ), :);
    