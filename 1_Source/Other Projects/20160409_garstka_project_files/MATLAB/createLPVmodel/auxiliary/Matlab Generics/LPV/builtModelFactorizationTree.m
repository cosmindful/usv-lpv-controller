function sCoeffsMultivariate_TREE = builtModelFactorizationTree(sCoeffsMultivariate, sMultivariateMonomialBasis, sqd, rows)


numCoeffs = size(sCoeffsMultivariate, 2);

for ii = 1:numCoeffs
    treeUsedSymVars{ii} = symvar(sMultivariateMonomialBasis(ii));
    
    [~, sqdIndices{ii}] = identifyBasisTerms(treeUsedSymVars{ii}, sqd);
    
    treeHorzDepth(ii)   = numel(sqdIndices{ii});
    for kk = 1:treeHorzDepth(ii)
        
        sCoeffMatTemp = sym(O(size(sCoeffsMultivariate{1}(rows, :), 1), numel(sqd)));
        
        sCoeffMatTemp(:, sqdIndices{ii}(kk)) = ...
        sCoeffsMultivariate{ii}(rows, :)*simple(sMultivariateMonomialBasis(ii)/treeUsedSymVars{ii}(kk));
        
        sCoeffsMultivariate_TREE{ii}.(['qd', num2str(sqdIndices{ii}(kk))]) = ...
            sCoeffMatTemp;
    end
        
end


