function exponents = checkMonomials(sMatEntry, sparams, coefftol)

nparams   = numel(sparams);

splitstring = strsplit(char(sMatEntry), {' - ',' + '}, 'CollapseDelimiters', true);
numSummands = numel(splitstring);

exponents = O(numSummands, nparams);
for kk = 1:numSummands
    curSummand = char(splitstring(kk));

    for ii = 1:nparams
        jj = 0;
        while ~(diff(curSummand, sparams(ii), jj+1) == 0)
           jj = jj + 1;
        end
        exponents(kk, ii) = jj;
    end
    if nargin > 2 & (double(abs(curSummand/prod(sparams.^exponents(kk, :)))) < coefftol)
        exponents(kk, :) = exponents(kk, :)*0;
    end
end


exponents = exponents(find(sum(exponents, 2) > 0), :);