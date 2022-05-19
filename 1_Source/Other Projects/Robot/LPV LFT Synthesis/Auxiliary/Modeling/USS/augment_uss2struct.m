function PLFR = augment_uss2struct(uPLFR, argnu, argne, uTHETAP);

    [  Matrices, ...
          Sizes, ...
     DeltaBlock] = formulateLMI_plantMatrices(uPLFR      , ...
                                              argnu      , ...
                                              argne            );
                                       
    [MTHETAP, DELTATHETAP, Blkstruct_THETAP, ~] = lftdata(uTHETAP);
    
     DeltaBlock.THETAP  = uTHETAP;
 
     DeltaBlock.rtheta  = [Blkstruct_THETAP.Occurrences];
     DeltaBlock.ntheta  = length(DeltaBlock.rtheta);
     DeltaBlock.nTHETA  = sum(DeltaBlock.rtheta);

     PLFR.Matrices   = Matrices;
     PLFR.Sizes      = Sizes;
     PLFR.DeltaBlock = DeltaBlock;