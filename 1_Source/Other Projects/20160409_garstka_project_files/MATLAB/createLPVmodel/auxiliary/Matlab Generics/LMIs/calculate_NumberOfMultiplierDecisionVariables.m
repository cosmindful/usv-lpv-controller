function numDecVars = calculate_NumberOfMultiplierDecisionVariables(umat, type)

[M, Delta, Blkstruct, Normunc] = lftdata(umat);
     r = [Blkstruct.Occurrences];
ndelta = length(r);
nDELTA = sum(r);



switch type
    case 'DG'
        nDecVarsR = O(1, ndelta);
        nDecVarsS = O(1, ndelta);
        nDecVarsQ = O(1, ndelta);
        for ii = 1:ndelta
            nDecVarsR(ii) = r(ii)*(r(ii) + 1)/2;
            SkewDecs      = cumsum(1:r(ii));
            nDecVarsS(ii) = SkewDecs(end);
        end
    case 'FBSP'
        nDecVarsR = 0;
        nDecVarsS = 0;
        nDecVarsQ = 0;

            nDecVarsR = nDELTA*(nDELTA + 1)/2;
            nDecVarsS = nDELTA*nDELTA;
            nDecVarsQ = nDecVarsR;
end

numDecVars = sum(nDecVarsR) + sum(nDecVarsS) + sum(nDecVarsQ);