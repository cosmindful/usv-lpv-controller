function sMatrix = constructSymMatFromCoeffsAndMonomials(sCoeffs, sMonomialBasis, tol)

if ~isempty(sMonomialBasis)
    nm = length(sMonomialBasis);
    [n1, n2] = size(sCoeffs{1});
    sMatrix  = sym(O(n1, n2));
    for ii = 1:nm
         if nargin > 2
             if ~isempty(symvar(sym(sCoeffs{ii})))
                sCoeffs{ii} = cleanUpPolynomialSymMat(sCoeffs{ii}, tol);
             end
         end
         sMatrix     = sMatrix + sCoeffs{ii}*sMonomialBasis(ii);
    end
else
    sMatrix = [];
end