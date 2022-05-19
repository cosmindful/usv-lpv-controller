function [sKrho_multivariate_q, sKrho_univariate_q] = constructStiffnessMatrix(skrho_q, sq, maxDegree);
% Take care that qd terms are already eliminated from construcion of the D
% matrix!


[sMonomialBasis_q] = generateMonomialBasisAlternative(sq, maxDegree);

% Decompose into monomial basis decomposition
[skrhoCoeffs_q          , ...
 skrhoCoeffsReduced_q   , ...
 sMonomialBasisReduced_q] = collectCoefficients(skrho_q, ...
                                                sMonomialBasis_q);
                                            
skrho_q = constructSymMatFromCoeffsAndMonomials(skrhoCoeffsReduced_q, sMonomialBasisReduced_q);
                                            
[sKrhoCoeffs_q, ~] = collectUnivariateCoeffs(skrho_q, ...
                                             sq     , ...
                                             1);
                                         
%% Final K Matrix!
sKrho_q = constructSymMatFromCoeffsAndMonomials(sKrhoCoeffs_q, ones(numel(sKrhoCoeffs_q), 1));

sKrho_univariate_q   = sKrho_q;
sKrho_multivariate_q = O(size(sKrho_univariate_q));