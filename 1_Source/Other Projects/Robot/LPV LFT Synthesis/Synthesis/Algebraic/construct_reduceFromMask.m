function [KLFR, Sizes] = construct_reduceFromMask(KLFR, W, V);
        
        WW = ( W'*W )^-1 * W';
        VV =          V' * ( V*V' )^-1;

        KLFR.A       =    KLFR.A        ;
        KLFR.B_u     =    KLFR.B_u      ;
        KLFR.C_y     =    KLFR.C_y      ;
        KLFR.D_yu    =    KLFR.D_yu     ;
        KLFR.B_th    =    KLFR.B_th  *VV;
        KLFR.D_thth  = WW*KLFR.D_thth*VV;
        KLFR.D_yth   =    KLFR.D_yth *VV;
        KLFR.D_thu   = WW*KLFR.D_thu    ;
        KLFR.C_th    = WW*KLFR.C_th     ;
        KLFR.THETA   = WW*KLFR.THETA*VV ;
        
        KLFR.THETA   = simplify(KLFR.THETA, 'full')*(WW*VV)^-1;
        
        
        [MKDELTALFR, KDelta, KDeltaBlkStruct, ~] = lftdata(KLFR.THETA);
         KDeltaNames = {KDeltaBlkStruct.Name};
         KDeltaOccurences = {KDeltaBlkStruct.Occurrences};
         Sizes.nd = 0;
         Sizes.nv = 0;
         for kk = 1:length(KDeltaNames)
            if strncmp(KDeltaNames(kk), 'lambda', 6)
                kkDelta = kk;
                Sizes.nd = KDeltaOccurences{kk};
                Sizes.nv = Sizes.nd;
            else
                kkTheta = kk;
            end
         end
         
         Sizes.nx   = size(KLFR.A  , 1);
         Sizes.ny   = size(KLFR.C_y, 1);
         Sizes.nu   = size(KLFR.B_u, 2);
         Sizes.nzth = size(KLFR.D_thth, 1) - Sizes.nd;
         Sizes.nwth = size(KLFR.D_thth, 2) - Sizes.nv;
         