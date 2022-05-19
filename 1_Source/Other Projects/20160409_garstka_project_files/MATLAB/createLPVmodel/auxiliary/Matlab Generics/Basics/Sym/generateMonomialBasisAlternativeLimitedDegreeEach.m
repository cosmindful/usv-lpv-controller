function [monomialBasis, univariateMonomialBasis] = generateMonomialBasisAlternativeLimitedDegreeEach(symVars, maxDegree, maxDegreeEach, maxDegreeExistUnique, maxDegreeExistUniqueInvolvedParams, mode);
% Like generateMonomialBasisAlternative but the highes occuring degree for
% each variable can be specified

numVars = numel(symVars);
symVars = reshape(symVars, numVars, 1);

basis = [1; symVars];
monomialBasis = basis;


exponents = O(1, numVars);
ii = 1;

while sum(mono_next_grlex(numVars, exponents(ii, :))) <= maxDegree
    exponents(ii+1, :) = mono_next_grlex(numVars, exponents(ii, :));
    ii = ii + 1;
end

% Erase all rows where the individual maxDegree is too large
maxDegreeDontExist = setdiff(1:maxDegree, maxDegreeExistUnique);
for ii = 1:numel(maxDegreeDontExist)
    keepRows = find(sum(exponents, 2) ~= maxDegreeDontExist(ii));
    exponents = exponents(keepRows, :);
end

for ii = 1:numVars
    keepRows = find(exponents(:, ii) <= maxDegreeEach(ii));
    exponents = exponents(keepRows, :);
end

% Erase all rows where the variables are not involved with respect to some
% maxDegree 
exponentsNew = exponents(1, :);
for ii = 1:numel(maxDegreeExistUnique)
    nonZeroCols = maxDegreeExistUniqueInvolvedParams{ii};
    whichRowsMaxDegree           = find(sum(exponents, 2) == maxDegreeExistUnique(ii));
    exponentsWhichRowsMaxDegree  = exponents(whichRowsMaxDegree, :);
    [keepWhichRowsForInvolvedParams, ~]   = find(exponentsWhichRowsMaxDegree(:, nonZeroCols) > 0);
    keepWhichRowsForInvolvedParams        = unique(sort(keepWhichRowsForInvolvedParams));
%     keepRows = intersect(whichRowsMaxDegree, keepWhichRowsForInvolvedParams);
    exponentsNew = [exponentsNew; exponentsWhichRowsMaxDegree(keepWhichRowsForInvolvedParams, :)];
end
exponents = exponentsNew;

if (nargin > 5 & strcmp(mode, 'polymonicsFirst'))
    % Isolate the basis terms that are univariate
    degrees = sum(exponents, 2);
    for ii = 1:maxDegree+1
        degreeInds{ii}      = find(degrees == ii-1);
        degreeExponents{ii} = exponents(degreeInds{ii}, :);
        
        [univariateRows   , ~] = find(degreeExponents{ii} == ii-1);
%         [nonunivariateRows, ~] = find(~(degreeExponents{ii} == ii-1));
        
        nonunivariateRows   = (1:size(degreeExponents{ii}, 1))';
        for kk = 1:numel(univariateRows)
            nonunivariateRows = nonunivariateRows(find(nonunivariateRows ~= univariateRows(kk)));
        end
        
        univariateRows      = unique(univariateRows);
        nonunivariateRows   = unique(nonunivariateRows);
        univariates{ii}     = degreeExponents{ii}(univariateRows(end:-1:1), :);
        nonunivariates{ii}  = degreeExponents{ii}(nonunivariateRows(end:-1:1), :);
    end
    
    exponents = [];
    univariateexponents = [];
    for ii = 1:numel(nonunivariates)
        exponents = [exponents; nonunivariates{ii}];
    end
    for ii = 1:numel(univariates)
        univariateexponents = [univariateexponents; univariates{ii}];
    end
    
    univariateMonomialBasis     = kron(reshape(symVars, 1, numVars), ones(size(univariateexponents, 1), 1));
    univariateMonomialBasis     = univariateMonomialBasis.^univariateexponents;
    univariateMonomialBasis     = prod(univariateMonomialBasis, 2);
    univariateMonomialBasis     = univariateMonomialBasis(2:end);
else
    % Make more meaningful reordering
    degrees = sum(exponents, 2);
    for ii = 1:maxDegree+1
        degreeInds{ii}      = find(degrees == ii-1);
        degreeExponents{ii} = exponents(degreeInds{ii}, :);

        rowOrdering = [];
        for jj = (ii-1):-1:1
            [row, ~] = find(degreeExponents{ii} == jj);
            row = unique(row);
            rowOrdering = unique([rowOrdering; row]);
        end
        degreeExponents{ii} = degreeExponents{ii}(rowOrdering(end:-1:1), :);
    end

    exponents = [];
    for ii = 1:numel(degreeExponents)
        exponents = [exponents; degreeExponents{ii}];
    end
end




monomialBasis = kron(reshape(symVars, 1, numVars), ones(size(exponents, 1), 1));
monomialBasis = monomialBasis.^exponents;
if ~isempty(monomialBasis)
    monomialBasis = prod(monomialBasis, 2);
else
    monomialBasis = [];
end

% for ii = 1:maxDegree-1
%     monomialBasis = unique(kron(basis(2:end), monomialBasis));
% end
% monomialBasis = monomialBasis(2:end);

% prod([qd1, qd2].^[1 2])


