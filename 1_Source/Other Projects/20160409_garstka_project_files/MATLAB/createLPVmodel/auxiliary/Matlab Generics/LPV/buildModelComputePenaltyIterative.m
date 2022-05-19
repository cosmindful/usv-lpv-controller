function [coeffPenalty, PenaltyMaskNew] = buildModelComputePenaltyIterative(sCoeffsMultivariate_qd_TREE, fieldIndex, coeffNum, PenaltyMask, rows)

numCoeffs = numel(sCoeffsMultivariate_qd_TREE);



    sCurrentCoeffs = sCoeffsMultivariate_qd_TREE{coeffNum};
    
    currentCoeffsFields        = fieldnames(sCurrentCoeffs);
    
    kk = fieldIndex;
        
        currentCoeffSparsity = ones(size(sCurrentCoeffs.(char(currentCoeffsFields(kk)))));
        currentCoeffSparsity(find(sCurrentCoeffs.(char(currentCoeffsFields(kk))) == 0)) = 0;
        
        currentCoeffPenaltyTemp = currentCoeffSparsity.*PenaltyMask;
        coeffPenalty            = sum(sum(currentCoeffPenaltyTemp));
        
        PenaltyMaskNew          = PenaltyMask + builtModelFactorizationPenaltyMask({currentCoeffSparsity}, rows);