function [Matrices, Sizes, DeltaBlock] = formulateLMI_plantMatrices(argPLFR, argnu, argne)

    %% Obtain Structure from Uncertain State-Space Model
    PLFR = model_uss2struct(argPLFR, argnu, argne);
    
    [PLFRmat, uTHETAP, Blkstruct_THETAP, ~] = lftdata(argPLFR);
    DeltaBlock.THETAP  = uTHETAP;

    DeltaBlock.rtheta  = PLFR.rtheta;
    DeltaBlock.ntheta  = PLFR.ntheta;
    DeltaBlock.nTHETA  = sum(DeltaBlock.rtheta);

    %% Extract Individual Model Matrices
    Matrices.AP      = PLFR.A;
    Matrices.BP_p    = PLFR.B_p;
    Matrices.BP_th   = PLFR.B_th;
    Matrices.BP_u    = PLFR.B_u;
    Matrices.CP_p    = PLFR.C_p;
    Matrices.CP_th   = PLFR.C_th;
    Matrices.CP_y    = PLFR.C_y;
    Matrices.DP_pp   = PLFR.D_pp;  
    Matrices.DP_pth  = PLFR.D_pth;  
    Matrices.DP_pu   = PLFR.D_pu;  
    Matrices.DP_thp  = PLFR.D_thp;  
    Matrices.DP_thth = PLFR.D_thth;
    Matrices.DP_thu  = PLFR.D_thu;
    Matrices.DP_yp   = PLFR.D_yp;
    Matrices.DP_yth  = PLFR.D_yth;
    Matrices.DP_yu   = PLFR.D_yu;

    %% Extract Problem Sizes
    Sizes.ne      = size(Matrices.DP_yu, 1);
    Sizes.nu      = size(Matrices.DP_yu, 2);
    if (Matrices.DP_yu ~= zeros(size(Matrices.DP_yu)))
        error('DP_eu needs to be zero!');
    end

    Sizes.nzPp   = size(Matrices.DP_pp, 1);
    Sizes.nwPp   = size(Matrices.DP_pp, 2);

    Sizes.nxP   = size(Matrices.AP, 1);

    Sizes.nzPth   = size(Matrices.DP_thth, 1);
    Sizes.nwPth   = size(Matrices.DP_thth, 2);