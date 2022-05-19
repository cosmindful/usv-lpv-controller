function monomialBasis = generateMonomialBasis(symVars, maxDegree);

symVars = reshape(symVars, numel(symVars), 1);

basis = [1; symVars];
monomialBasis = 1;

for ii = 1:maxDegree
    monomialBasis = unique(kron(monomialBasis, basis));
end
monomialBasis = monomialBasis(2:end);