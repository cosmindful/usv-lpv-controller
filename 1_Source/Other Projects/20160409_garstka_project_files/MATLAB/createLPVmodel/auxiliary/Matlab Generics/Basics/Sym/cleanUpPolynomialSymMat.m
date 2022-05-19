function [sMatrixClean, sMonomialParamBasis, sMatCoeffsReduced, M0] = cleanUpPolynomialSymMat(sMatrix, coeffstol)

  params = symvar(sMatrix);
n_params = length(params);

% maxDegree = checkPolynomialMaxDegree(sMatrix);

[sMonomialParamBasis, ~] = generateMonomialBasisByOccurance(sMatrix, params);
maxDegree = checkPolynomialMaxDegree(sMonomialParamBasis);

% checkPolynomialMaxDegree

if maxDegree == 0
    sMatrixClean = sMatrix;
    sMatrixClean(double(abs(sMatrixClean)) < coeffstol) = 0;    
    sMatCoeffsReduced = {};
    M0 = sMatrixClean;
else

%     [sMonomialParamBasis, ~] = generateMonomialBasisByOccurance(sMatrix, params, 'PolymonicsFirst', coeffstol);
    %% If the monomial basis is smaller, it is to be expected that some trash remains!
    [sMatCoeffsReduced, M0] = collectCoefficients(sMatrix, sMonomialParamBasis);

    M0(abs(double(M0)) < coeffstol) = 0;
    M0 = double(M0);

    n_monomials = length(sMonomialParamBasis);
    sMatrixClean = O(size(sMatrix));
    for ii = 1:n_monomials
        MatCoeffClean = double(sMatCoeffsReduced{ii});
        MatCoeffClean(abs(MatCoeffClean) < coeffstol) = 0;
        sMatCoeffsReduced{ii} = MatCoeffClean;
        sMatrixClean = sMatrixClean + MatCoeffClean*sMonomialParamBasis(ii);
    end

    sMatrixClean = sMatrixClean + M0;
end