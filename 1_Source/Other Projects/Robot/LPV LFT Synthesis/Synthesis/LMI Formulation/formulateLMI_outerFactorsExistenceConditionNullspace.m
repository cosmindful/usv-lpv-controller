function [BRaug, BSaug, BR, BS] = formulateLMI_outerFactorsExistenceCondition(argMatrices)

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

    %% Extract Problem Sizes
    ne      = size(DP_yu, 1);
    nu      = size(DP_yu, 2);
    if (DP_yu ~= zeros(size(DP_yu)))
        error('DP_eu needs to be zero!');
    end

    nzPp   = size(DP_pp, 1);
    nwPp   = size(DP_pp, 2);

    nxP    = size(AP, 1);

    nzPth   = size(DP_thth, 1);
    nwPth   = size(DP_thth, 2);
    
    %% Construct Outer LMI Factors

    GR.M11 = [ DP_thth ];

    GR.M12 = [ CP_th             DP_thp ];

    GR.M21 = [ O(nxP , nwPth)  ;...
               BP_th           ;...
               O(nwPp, nwPth)  ;...
               DP_pth          ];

    GR.M22 = [ I(nxP)         O(nxP, nwPp)   ;...
               AP             BP_p           ;...
               O(nwPp, nxP)   I(nwPp)        ;...
               CP_p           DP_pp          ];

    GS.M11 = [ DP_thth' ];

    GS.M12 = [ BP_th'            DP_pth' ];

    GS.M21 = [ O(nxP , nzPth)   ;...
               CP_th'           ;...
               O(nzPp, nzPth)   ;...
               DP_thp'          ];

    GS.M22 = [ I(nxP)         O(nxP, nzPp)    ;...
               AP'            CP_p'           ;...
               O(nzPp, nxP)   I(nzPp)         ;...
               BP_p'          DP_pp'          ];


    %% Construct outer nullspace factors
    NR   = null([DP_yth , CP_y , DP_yp ]);
    NS   = null([DP_thu', BP_u', DP_pu']);

    %% Build augmented matrices
    nGR11  = size(GR.M11, 2);

    BR.M11 = [ GR.M11 ];
    BR.M12 = [ GR.M12 ];
    BR.M21 = [ GR.M21 ];
    BR.M22 = [ GR.M22 ];

    nGS11  = size(GS.M11, 2);

    BS.M11 = [ GS.M11 ];
    BS.M12 = [ GS.M12 ];
    BS.M21 = [ GS.M21 ];
    BS.M22 = [ GS.M22 ];

    nwBR1   = size(BR.M11, 2);
    nzBR1   = size(BR.M11, 1);
    nwBR2   = size(BR.M22, 2);
    nzBR2   = size(BR.M22, 1);

    BRaug.M = [ BR.M11      BR.M12               ;...
                I(nwBR1)    O(nwBR1, nwBR2)      ;...
                BR.M21      BR.M22               ];
            
    BRaug.M = BRaug.M*NR;

    nwBS1   = size(BS.M11, 2);
    nzBS1   = size(BS.M11, 1);
    nwBS2   = size(BS.M22, 2);
    nzBS2   = size(BS.M22, 1);

    BSaug.M = [ BS.M11      BS.M12               ;...
                I(nwBS1)    O(nwBS1, nwBS2)      ;...
                BS.M21      BS.M22               ];
            
    BSaug.M = BSaug.M*NS;

    BRaug.MThXP  = BRaug.M((               1):(end-nzPp), :);
    BRaug.MP     = BRaug.M((end-nzPp+1):(end           ), :);

    BSaug.MThXP  = BSaug.M((               1):(end-nwPp), :);
    BSaug.MP     = BSaug.M((end-nwPp+1):(end           ), :);