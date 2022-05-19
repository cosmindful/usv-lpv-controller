function [monomialBasis, univariateMonomialBasis] = generateMonomialBasisAlternative(symVars, maxDegree, mode);

symVars = reshape(symVars, numel(symVars), 1);

basis = [1; symVars];
monomialBasis = basis;


exponents = O(1, numel(symVars));
ii = 1;

while sum(mono_next_grlex(numel(symVars), exponents(ii, :))) <= maxDegree
    exponents(ii+1, :) = mono_next_grlex(numel(symVars), exponents(ii, :));
    ii = ii + 1;
end

if (nargin > 2 & strcmp(mode, 'polymonicsFirst'))
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
    
    univariateMonomialBasis     = kron(reshape(symVars, 1, numel(symVars)), ones(size(univariateexponents, 1), 1));
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




monomialBasis = kron(reshape(symVars, 1, numel(symVars)), ones(size(exponents, 1), 1));
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


