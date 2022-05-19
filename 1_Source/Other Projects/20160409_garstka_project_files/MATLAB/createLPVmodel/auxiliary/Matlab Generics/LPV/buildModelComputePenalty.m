function [penalty] = buildModelComputePenalty(sCoeffsMultivariate_qd_TREE, fieldIndices, PenaltyMask)

numCoeffs = numel(sCoeffsMultivariate_qd_TREE);



for ii = 1:numCoeffs
    sCurrentCoeffs = sCoeffsMultivariate_qd_TREE{ii};
    
    currentCoeffsFields        = fieldnames(sCurrentCoeffs);
    numCurrentCoeffsFields(ii) = numel(currentCoeffsFields);
    
    kk = fieldIndices(ii);
        
        currentCoeffSparsity = ones(size(sCurrentCoeffs.(char(currentCoeffsFields(kk)))));
        currentCoeffSparsity(find(sCurrentCoeffs.(char(currentCoeffsFields(kk))) == 0)) = 0;
        
        currentCoeffPenaltyTemp = currentCoeffSparsity.*PenaltyMask;
        coeffPenalty(ii)        = sum(sum(currentCoeffPenaltyTemp));

end

    penalty = sum(coeffPenalty);