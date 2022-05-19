function [PolynomialBasisCoeffsN, sMonomialBasisN, monomialBasis0, ParamsN_bnd, sParamsN, sParamsNOfParams, sParamsOfParamsN] = normalizeMonomialBasis(sMonomialBasis, sParams, params_bnd, params_Offset, params_Amplitude, paramsName)
% 
% Mcoeffs*monomialBasis(params) = McoeffsN*monomialBasis(paramsN) + M0

sMonomialBasis = expand(sMonomialBasis);

nparams = length(sParams);
%  paramsName = char(sParams(1));
%  paramsName = paramsName(1:end-2); % Eliminate last two digits
 
sParamsN        = generateParameterVector(paramsName, nparams);

% maxDegreeN      = checkPolynomialMaxDegree(sMonomialBasis);
% sMonomialBasisN = generateMonomialBasisAlternative(sParamsN, maxDegreeN);

sParamsOfParamsN = vpa(sParamsN.*params_Amplitude + params_Offset, 5);
sParamsNOfParams = vpa((sParams-params_Offset)./params_Amplitude , 5);

ParamsN_min = double(subs(sParamsNOfParams, sParams, params_bnd(:, 1)));
ParamsN_max = double(subs(sParamsNOfParams, sParams, params_bnd(:, 2)));


monomialBasis0             = vpa(subs(sMonomialBasis, sParams, params_Offset), 5);
sPolynomialBasisN          = vpa(subs(sMonomialBasis, sParams, sParamsOfParamsN   ) - monomialBasis0, 5);

% Find out which monomials are occurring
% Upsilon_deltatilde  = subs(sUpsilon_deltatilde, b, bval);

sMonomialBasisN = generateMonomialBasisByOccurance(sPolynomialBasisN, sParamsN);

% sMonomialBasisN = identifyOccurringMonomials(sMonomialBasisN, sPolynomialBasisN);

[PolynomialBasisCoeffsN] = collectCoefficients(sPolynomialBasisN, sMonomialBasisN);

ParamsN_bnd = [ParamsN_min, ParamsN_max];%ones(nparams, 1)*[-1 1];



