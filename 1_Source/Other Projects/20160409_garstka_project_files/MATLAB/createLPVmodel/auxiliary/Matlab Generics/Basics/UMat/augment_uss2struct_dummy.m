function PLFR = augment_uss2struct_dummy(uPLFR, argnu, argne, uTHETAP, uTHETAofDELTAP, dummyMask);

% dummyMask specifies, which parts of the LFT interconnection block are
% actually nonzero

    if (nargin > 3)

    [  Matrices, ...
          Sizes, ...
     DeltaBlock, ...
        Signals] = formulateLMI_plantMatrices(uPLFR      , ...
                                              argnu      , ...
                                              argne            );
                                       
    [MTHETAP, DELTATHETAP, Blkstruct_THETAP, ~] = lftdata(umat(uTHETAP));
    
     DeltaBlock.THETAP  = uTHETAP;
 
     DeltaBlock.rtheta  = [Blkstruct_THETAP.Occurrences];
     DeltaBlock.ntheta  = length(DeltaBlock.rtheta);
     DeltaBlock.nTHETA  = sum(DeltaBlock.rtheta);

     
    if (nargin > 5)
        rowIndices = find(sum(dummyMask, 2) > 0);
        colIndices = find(sum(dummyMask, 1) > 0);

        Matrices.BP_th   = Matrices.BP_th(:, rowIndices);
        Matrices.CP_th   = Matrices.CP_th(colIndices, :);
        Matrices.DP_pth  = Matrices.DP_pth(:, rowIndices);  
        Matrices.DP_thp  = Matrices.DP_thp(colIndices, :);  
        Matrices.DP_thth = Matrices.DP_thth(colIndices, rowIndices);
        Matrices.DP_thu  = Matrices.DP_thu(colIndices, :);
        Matrices.DP_yth  = Matrices.DP_yth(:, rowIndices);
        
        Sizes.nzPth = numel(colIndices);
        Sizes.nwPth = numel(rowIndices);
    end
     
     PLFR.Matrices   = Matrices;
     PLFR.Sizes      = Sizes;
     PLFR.DeltaBlock = DeltaBlock;
     PLFR.Signals    = Signals;
     
    end
    
    if (nargin > 4)
        
    [MTHETAofDELTAP, DELTATHETAofDELTAP, Blkstruct_THETAofDELTAP, ~] = lftdata(umat(uTHETAofDELTAP));
    
     DeltaBlock.THETAofDELTAP  = uTHETAofDELTAP;
 
     DeltaBlock.rthetaofdelta  = [Blkstruct_THETAofDELTAP.Occurrences];
     DeltaBlock.nthetaofdelta  = length(DeltaBlock.rthetaofdelta);
     DeltaBlock.nTHETAofDELTA  = sum(DeltaBlock.rthetaofdelta);

     PLFR.DeltaBlock = DeltaBlock;
     
    end
    

