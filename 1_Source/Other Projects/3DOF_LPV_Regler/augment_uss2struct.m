function PLFR = augment_uss2struct(uPLFR, argnu, argne, uTHETAP, uTHETAofDELTAP);

    if (nargin > 2) %changed by michael

    [  Matrices, ...
          Sizes, ...
     DeltaBlock, ...
        Signals] = formulateLMI_plantMatrices(uPLFR      , ...
                                              argnu      , ...
                                              argne            );
        % evtl ist es nicht i.O. das hier auszukommentieren (michael)                               
%     [MTHETAP, DELTATHETAP, Blkstruct_THETAP, ~] = lftdata(uTHETAP);
%     
%     DeltaBlock.THETAP  = uTHETAP;
%  
%      DeltaBlock.rtheta  = [Blkstruct_THETAP.Occurrences];
%      DeltaBlock.ntheta  = length(DeltaBlock.rtheta);
%      DeltaBlock.nTHETA  = sum(DeltaBlock.rtheta);
% 
        PLFR.Matrices   = Matrices;
       PLFR.Sizes      = Sizes;
       PLFR.DeltaBlock = DeltaBlock;
       PLFR.Signals    = Signals;
      
    end
    
    if (nargin > 4)
        
    [MTHETAofDELTAP, DELTATHETAofDELTAP, Blkstruct_THETAofDELTAP, ~] = lftdata(uTHETAofDELTAP);
    
     DeltaBlock.THETAofDELTAP  = uTHETAofDELTAP;
 
     DeltaBlock.rthetaofdelta  = [Blkstruct_THETAofDELTAP.Occurrences];
     DeltaBlock.nthetaofdelta  = length(DeltaBlock.rthetaofdelta);
     DeltaBlock.nTHETAofDELTA  = sum(DeltaBlock.rthetaofdelta);

     PLFR.DeltaBlock = DeltaBlock;
     
    end