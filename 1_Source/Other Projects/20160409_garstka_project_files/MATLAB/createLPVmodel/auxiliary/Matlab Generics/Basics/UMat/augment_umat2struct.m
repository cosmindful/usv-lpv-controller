function Mat = augment_umat2struct(uMat, uTHETAP, uTHETAofDELTAP);

    % Cast to umat to prevent errors
    uMat           = umat(uMat);
    uTHETAP        = umat(uTHETAP);
    uTHETAofDELTAP = umat(uTHETAofDELTAP);

    if (nargin > 1)

    [M, ~, ~, ~] = lftdata(uMat);
    
    n11 = size(uTHETAP, 1);
    m11 = size(uTHETAP, 2);
    
    [M11, M12, M21, M22] = mat2x2(M, n11, m11);
                                          
     Matrices.M11 = M11;
     Matrices.M12 = M12;
     Matrices.M21 = M21;
     Matrices.M22 = M22;
     
     Sizes.nM11   = size(M11, 1);
     Sizes.nM12   = size(M12, 2);
     Sizes.nM21   = size(M21, 1);
     Sizes.nM22   = size(M22, 2);
                                       
    [MTHETAP, DELTATHETAP, Blkstruct_THETAP, ~] = lftdata(uTHETAP);
    
     DeltaBlock.THETAP  = uTHETAP;
 
     DeltaBlock.rtheta  = [Blkstruct_THETAP.Occurrences];
     DeltaBlock.ntheta  = length(DeltaBlock.rtheta);
     DeltaBlock.nTHETA  = sum(DeltaBlock.rtheta);

     Mat.Matrices   = Matrices;
     Mat.Sizes      = Sizes;
     Mat.DeltaBlock = DeltaBlock;
     
    end
    
    if (nargin > 2)
        
    [MTHETAofDELTAP, DELTATHETAofDELTAP, Blkstruct_THETAofDELTAP, ~] = lftdata(uTHETAofDELTAP);
    
     DeltaBlock.THETAofDELTAP  = uTHETAofDELTAP;
 
     DeltaBlock.rthetaofdelta  = [Blkstruct_THETAofDELTAP.Occurrences];
     DeltaBlock.nthetaofdelta  = length(DeltaBlock.rthetaofdelta);
     DeltaBlock.nTHETAofDELTA  = sum(DeltaBlock.rthetaofdelta);

     Mat.DeltaBlock = DeltaBlock;
     
    end