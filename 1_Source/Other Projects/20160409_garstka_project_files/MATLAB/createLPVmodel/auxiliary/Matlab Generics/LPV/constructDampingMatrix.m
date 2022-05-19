function [sDrho_multivariate_qd_min, sDrho_multivariate_qd_max, sDrho_univariate_qd, minPenalty, minPenaltyFieldIndices, penalties, fieldIndices, sDrhoCoeffs_multivariate_qd_TREE] = constructDampingMatrix(skrho, sqd, maxDegree, PenaltyMask);

% [sMonomialBasis_qd] = generateMonomialBasisAlternative(sqd, maxDegree);
sMonomialBasis_qd = generateMonomialBasisByOccurance(skrho, sqd);

% Decompose into monomial basis decomposition
[skrhoCoeffs_qd   , ...
 ~                       ] = collectCoefficients(skrho, ...
                                                 sMonomialBasis_qd);
                                             
% Divide monomial basis into univariate and multivariate monomials
[sMultivariateMonomialBasis_qd, sUnivariateMonomialBasis_qd] = generateMonomialBasisByOccurance(skrho, sqd, 'polymonicsFirst');

sGroupedBasis_qd = [sMultivariateMonomialBasis_qd; sUnivariateMonomialBasis_qd];
                                             
% Reorder coefficient cell array and monomials into multi- and univariate
[groupedToOrderedIndices, orderedToGroupedIndices] = identifyBasisTerms(sGroupedBasis_qd, sMonomialBasis_qd);
sGroupedMonomialBasis_qd = sMonomialBasis_qd(orderedToGroupedIndices);
skrhoCoeffsGrouped_qd = skrhoCoeffs_qd(orderedToGroupedIndices);

% Identify univariate terms and multivariate terms
[groupedToUnivariateIndices  , ~] = identifyBasisTerms(sGroupedMonomialBasis_qd, sUnivariateMonomialBasis_qd);
sUnivariateMonomialBasis_qd   = sGroupedMonomialBasis_qd(groupedToUnivariateIndices);
[groupedToMultivariateIndices, ~] = identifyBasisTerms(sGroupedMonomialBasis_qd, sMultivariateMonomialBasis_qd);
sMultivariateMonomialBasis_qd = sGroupedMonomialBasis_qd(groupedToMultivariateIndices);

% Handle univariate terms by pulling in a parameter to the power of one!
skrhoCoeffsUnivariate_qd = skrhoCoeffsGrouped_qd(groupedToUnivariateIndices);
[skrho_univariate_qd] = constructSymMatFromCoeffsAndMonomials(skrhoCoeffsUnivariate_qd, sUnivariateMonomialBasis_qd);

maxDegree = checkPolynomialMaxDegree(sUnivariateMonomialBasis_qd);

[sDrhoCoeffs_univariate_qd, ...
 ~                               ] = collectUnivariateCoeffs(skrho_univariate_qd, ...
                                                             sqd                , ...
                                                             maxDegree);
    
sDrho_univariate_qd = constructSymMatFromCoeffsAndMonomials(sDrhoCoeffs_univariate_qd, ones(numel(sDrhoCoeffs_univariate_qd), 1));
                                                         
% Handle multivariate terms by ...
skrhoCoeffs_multivariate_qd = skrhoCoeffsGrouped_qd(groupedToMultivariateIndices);
[skrho_multivariate_qd] = constructSymMatFromCoeffsAndMonomials(skrhoCoeffs_multivariate_qd, sMultivariateMonomialBasis_qd);

sDrho_multivariate_qd_min = sym(O(size(sDrho_univariate_qd)));
sDrho_multivariate_qd_max = sym(O(size(sDrho_univariate_qd)));
minPenalty             = {};
minPenaltyFieldIndices = {};
penalties              = {}; 
fieldIndices           = {};
sDrhoCoeffs_multivariate_qd_TREE = {};
if ~isempty(skrhoCoeffs_multivariate_qd)
    for kk = 1:size(skrhoCoeffs_multivariate_qd{1}, 1)
        rows = kk;
        sDrhoCoeffs_multivariate_qd_TREE{kk} = builtModelFactorizationTree(skrhoCoeffs_multivariate_qd, sMultivariateMonomialBasis_qd, sqd, rows);
    %      DPenaltyMask0 = diag(ones(size(sDrhoCoeffs_univariate_qd{1}, 2), 1));
         if nargin > 3
            DPenaltyMask0                   = PenaltyMask(rows, :);
         else
            DPenaltyMask0                   = O(size(sDrhoCoeffs_univariate_qd{1}(rows, :)));
         end
         DPenaltyMask0                   = DPenaltyMask0 + builtModelFactorizationPenaltyMask(sDrhoCoeffs_univariate_qd, rows);

        [minPenalty{kk}, minPenaltyFieldIndices{kk}, maxPenalty{kk}, maxPenaltyFieldIndices{kk}, penalties{kk}, fieldIndices{kk}] = buildModelPenalizedTree(sDrhoCoeffs_multivariate_qd_TREE{kk}, DPenaltyMask0, 1);
        [sDrho_multivariate_qd_min_rows{kk}] = buildModelFromFieldIndices(sDrhoCoeffs_multivariate_qd_TREE{kk}, minPenaltyFieldIndices{kk});
        [sDrho_multivariate_qd_max_rows{kk}] = buildModelFromFieldIndices(sDrhoCoeffs_multivariate_qd_TREE{kk}, maxPenaltyFieldIndices{kk});
    end
    for kk = 1:size(skrhoCoeffs_multivariate_qd{1}, 1)
        sDrho_multivariate_qd_min(kk, :) = sDrho_multivariate_qd_min_rows{kk};
        sDrho_multivariate_qd_max(kk, :) = sDrho_multivariate_qd_max_rows{kk};
    end
end