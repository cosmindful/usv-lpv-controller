function [sCoeffCell, sCoeffs, CoeffVals] = findNewSymbolicCoefficients(CoeffCell, coeffNames, tol)

CoeffMat = [];

nCells = numel(CoeffCell);
for ii = 1:nCells
   CoeffMat =  [CoeffMat, CoeffCell{ii}];
end

CoeffMat = round(CoeffMat*tol^-1)*tol;

% Find uniques
[CoeffVals] = unique(abs(CoeffMat));
CoeffVals = CoeffVals(CoeffVals ~= 0);

ncoeffNames = numel(CoeffVals);
sCoeffs     = sym([]);
    for ii = 1:ncoeffNames
        eval(['syms ', coeffNames, num2strChars(ii, 2), ' real']);
        eval(['sCoeffs(', num2str(ii), ', 1) = ', coeffNames, num2strChars(ii, 2), ';']);
    end

% Substitute for symbolic variables
sCoeffMat = sym(O(size(CoeffMat)));
for ii = 1:ncoeffNames
    sCoeffMat(find(CoeffMat ==  CoeffVals(ii))) =  sCoeffs(ii);
    sCoeffMat(find(CoeffMat == -CoeffVals(ii))) = -sCoeffs(ii);
end
    
% Reassemble into coefficient cell
sCoeffCell = {};
if ~isempty(CoeffCell)
    [n1, n2] = size(CoeffCell{1});
    for ii = 1:nCells
         sCoeffCell{ii} =  sCoeffMat(:, (1:n2)+n2*(ii-1));
    end
end
    