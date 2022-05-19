function indexMat = maskMatRenumberIndices(S0, S0Mask)

S0 = S0 - min(min(S0)) + 1;
S0(~S0Mask) = 0;
decVarIndices = unique(S0);
decVarIndices = decVarIndices(decVarIndices > 0);
for ii = 1:numel(decVarIndices)
    S0(S0 == decVarIndices(ii)) = ii;
end

indexMat = S0;