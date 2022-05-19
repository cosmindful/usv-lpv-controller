function maxDegreeEach = checkPolynomialMaxDegreeForEachWithParams(sPolynomial, b, bval, sparams)

for ii = 1:numel(sparams)
    sparamsSubs = [sparams(1:(ii-1)); sparams((ii+1):end)];
    sPolynomialSubs = subs(sPolynomial, sparamsSubs, ones(size(sparamsSubs)));
    maxDegreeEach(ii, :) = checkPolynomialMaxDegreeWithParams(sPolynomialSubs, b, bval);
end