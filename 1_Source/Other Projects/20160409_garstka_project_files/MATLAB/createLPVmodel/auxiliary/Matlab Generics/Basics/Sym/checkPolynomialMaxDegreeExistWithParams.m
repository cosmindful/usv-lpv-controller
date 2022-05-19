function [maxDegreeExistUnique, maxDegreeExistUniqueInvolvedParams] = checkPolynomialMaxDegreeExistWithParams(sPolynomial, b, bval, sparams)

sPolynomialSubs = subs(sPolynomial, b, bval);

maxDegreeExist = [];
for ii = 1:size(sPolynomial, 1)
    for jj = 1:size(sPolynomial, 2)
        maxDegreeExist(ii, jj) = checkPolynomialMaxDegree(sPolynomialSubs(ii, jj));
    end
end

maxDegreeExistUnique = unique(maxDegreeExist);
maxDegreeExistUnique = maxDegreeExistUnique(maxDegreeExistUnique > 0);

for ii = 1:numel(maxDegreeExistUnique)
    indices   = find(maxDegreeExist == maxDegreeExistUnique(ii));
    occurringParamsWithDegree = symvar(sPolynomialSubs(indices));
    [paramsToOccurring, occurringToParams] = identifyBasisTerms(sparams, occurringParamsWithDegree);
    maxDegreeExistUniqueInvolvedParams{ii} = paramsToOccurring;
end
    

