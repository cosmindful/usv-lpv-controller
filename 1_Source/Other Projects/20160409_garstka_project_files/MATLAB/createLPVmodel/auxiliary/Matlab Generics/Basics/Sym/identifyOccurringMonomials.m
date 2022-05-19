function sReducedMonomialBasis = identifyOccurringMonomials(sFullMonomialBasis, Upsilon);

sMonomialsEnum = generateParameterVector('m', numel(sFullMonomialBasis));

sMonomialsOccurring = symvar(subs(expand(Upsilon), sFullMonomialBasis(end:-1:1), sMonomialsEnum(end:-1:1)));

[~, enumToOccurringIndices] = identifyBasisTerms(sMonomialsOccurring, sMonomialsEnum);

sReducedMonomialBasis = sFullMonomialBasis(enumToOccurringIndices);