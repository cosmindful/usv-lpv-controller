function MLFR = augment_umat2struct_dummy(uMLFR, uTHETAP, uTHETAofDELTAP, dummyMask);

% dummyMask specifies, which parts of the LFT interconnection block are
% actually nonzero

    uMLFR = umat(uMLFR);


    if (nargin > 1)

        
% FORMULATE LMI PLANT MATRICES INTERFACE CHANGE!
        
    [  Matrices, ...
          Sizes, ...
     DeltaBlock      ] = formulateLMI_plantMatricesE(uMLFR);
                                       
    uTHETAP = umat(uTHETAP);
 
    [MTHETAP, DELTATHETAP, Blkstruct_THETAP, ~] = lftdata(umat(uTHETAP));
    
     DeltaBlock.THETAP  = uTHETAP;
 
     DeltaBlock.rtheta  = [Blkstruct_THETAP.Occurrences];
     DeltaBlock.ntheta  = length(DeltaBlock.rtheta);
     DeltaBlock.nTHETA  = sum(DeltaBlock.rtheta);

     
    if (nargin > 3)
        rowIndices = find(sum(dummyMask, 2) > 0);
        colIndices = find(sum(dummyMask, 1) > 0);

        Matrices.BP_th   = Matrices.BP_th(:, rowIndices);
        Matrices.CP_th   = Matrices.CP_th(colIndices, :);
%         Matrices.DP_pth  = Matrices.DP_pth(:, rowIndices);  
%         Matrices.DP_thp  = Matrices.DP_thp(colIndices, :);  
        Matrices.DP_thth = Matrices.DP_thth(colIndices, rowIndices);
%         Matrices.DP_thu  = Matrices.DP_thu(colIndices, :);
%         Matrices.DP_yth  = Matrices.DP_yth(:, rowIndices);
        
        Sizes.nzPth = numel(colIndices);
        Sizes.nwPth = numel(rowIndices);
    end
     
     MLFR.Matrices   = Matrices;
     MLFR.Sizes      = Sizes;
     MLFR.DeltaBlock = DeltaBlock;
%      MLFR.Signals    = Signals;
     
    end
    
    if (nargin > 2)
        
     uTHETAofDELTAP = umat(uTHETAofDELTAP);
    [MTHETAofDELTAP, DELTATHETAofDELTAP, Blkstruct_THETAofDELTAP, ~] = lftdata(umat(uTHETAofDELTAP));
    
     DeltaBlock.THETAofDELTAP  = uTHETAofDELTAP;
 
     DeltaBlock.rthetaofdelta  = [Blkstruct_THETAofDELTAP.Occurrences];
     DeltaBlock.nthetaofdelta  = length(DeltaBlock.rthetaofdelta);
     DeltaBlock.nTHETAofDELTA  = sum(DeltaBlock.rthetaofdelta);

     MLFR.DeltaBlock = DeltaBlock;
     
    end
    

