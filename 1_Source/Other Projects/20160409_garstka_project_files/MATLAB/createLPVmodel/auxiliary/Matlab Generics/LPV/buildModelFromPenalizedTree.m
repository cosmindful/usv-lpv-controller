function [sCoeffsMultivariate_qd, minPenalty, fieldIndices, sCoeffsMultivariate_qd_TREE_Penalties] = buildModelFromPenalizedTree(sCoeffsMultivariate_qd_TREE, PenaltyMask)

numCoeffs = numel(sCoeffsMultivariate_qd_TREE);

sCoeffsMultivariate_qd_TREE_Penalties = {};
sCoeffsMultivariate_qd             = sym(O(size(PenaltyMask)));

for ii = 1:numCoeffs
    sCurrentCoeffs = sCoeffsMultivariate_qd_TREE{ii};
    
    currentCoeffsFields    = fieldnames(sCurrentCoeffs);
    numCurrentCoeffsFields = numel(currentCoeffsFields);
    
    currentCoeffPenalty = [];
    
    for kk = 1:numCurrentCoeffsFields
        
        currentCoeffSparsity = ones(size(sCurrentCoeffs.(char(currentCoeffsFields(kk)))));
        currentCoeffSparsity(find(sCurrentCoeffs.(char(currentCoeffsFields(kk))) == 0)) = 0;
        
        currentCoeffPenaltyTemp = currentCoeffSparsity.*PenaltyMask;
        currentCoeffPenalty(kk) = sum(sum(currentCoeffPenaltyTemp));
        
        sCoeffsMultivariate_qd_TREE_Penalties{ii}.(char(currentCoeffsFields(kk))) = currentCoeffPenalty(kk);
    end
    
    [currentCoeffMinPenalty(ii), currentCoeffFieldIndex(ii)] = min(currentCoeffPenalty);
    
    sCoeffsMultivariate_qd = sCoeffsMultivariate_qd + sCurrentCoeffs.(char(currentCoeffsFields(currentCoeffFieldIndex(ii))));
    
end

minPenalty    = sum(currentCoeffMinPenalty);
fieldIndices  = currentCoeffFieldIndex;