function [sCoeffsMultivariate_qd] = buildModelFromFieldIndices(sCoeffsMultivariate_qd_TREE, fieldIndex)

fieldname = fieldnames(sCoeffsMultivariate_qd_TREE{1});
[n1, n2] = size(sCoeffsMultivariate_qd_TREE{1}.(char(fieldname(1))));

sCoeffsMultivariate_qd             = sym(O(n1, n2));

numCoeffs = numel(sCoeffsMultivariate_qd_TREE);

for ii = 1:numCoeffs
    sCurrentCoeffs = sCoeffsMultivariate_qd_TREE{ii};
    
    currentCoeffsFields    = fieldnames(sCurrentCoeffs);
    
    sCoeffsMultivariate_qd = sCoeffsMultivariate_qd + sCurrentCoeffs.(char(currentCoeffsFields(fieldIndex(ii))));
    
end