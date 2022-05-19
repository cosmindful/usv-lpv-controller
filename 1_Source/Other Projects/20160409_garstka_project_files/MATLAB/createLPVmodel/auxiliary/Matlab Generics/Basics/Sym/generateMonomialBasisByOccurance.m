function [monomialBasis, univariateMonomialBasis, exponents] = generateMonomialBasisByOccurance(sMat, sparams, mode, coefftol);
% Like generateMonomialBasisAlternative but the highest occuring degree for
% each variable can be specified
sMat = expand(sMat);

univariateMonomialBasis = [];

nparams   = numel(sparams);
exponents = O(0, nparams);
for ii = 1:size(sMat, 1)
    for jj = 1:size(sMat, 2)
        if sMat(ii, jj) ~= 0
            if nargin > 3
                exponentsNew = checkMonomials(sMat(ii, jj), sparams, coefftol);
            else
                exponentsNew = checkMonomials(sMat(ii, jj), sparams);
            end
            exponents = [exponents; exponentsNew];
        end
    end
end

sortrows(exponents, 1:nparams);
exponents = unique(exponents, 'rows');

maxDegree = max(sum(exponents, 2));

sparams = reshape(sparams, nparams, 1);

basis = [1; sparams];
monomialBasis = basis;



if (nargin > 2 & strcmp(mode, 'polymonicsFirst'))
    % Isolate the basis terms that are univariate
    degrees = sum(exponents, 2);
    for ii = 1:maxDegree+1
        degreeInds{ii}      = find(degrees == ii-1);
        degreeExponents{ii} = exponents(degreeInds{ii}, :);
        
        % Checking degree ii-1 -> find rows that contain that number
        % must be univariate
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
    
    univariateMonomialBasis     = kron(reshape(sparams, 1, nparams), ones(size(univariateexponents, 1), 1));
    univariateMonomialBasis     = univariateMonomialBasis.^univariateexponents;
    univariateMonomialBasis     = prod(univariateMonomialBasis, 2);
    univariateMonomialBasis     = univariateMonomialBasis(1:end);
else
    % Make more meaningful reordering
    degrees = sum(exponents, 2);
    degreeExponents = {};
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




monomialBasis = kron(reshape(sparams, 1, nparams), ones(size(exponents, 1), 1));
if ~isempty(monomialBasis)
    monomialBasis = monomialBasis.^exponents;
    monomialBasis = prod(monomialBasis, 2);
else
    monomialBasis = [];
end

fprintf(['Found ', num2strChars(numel(monomialBasis), 3), ' monomials.\n']);

% for ii = 1:maxDegree-1
%     monomialBasis = unique(kron(basis(2:end), monomialBasis));
% end
% monomialBasis = monomialBasis(2:end);

% prod([qd1, qd2].^[1 2])


