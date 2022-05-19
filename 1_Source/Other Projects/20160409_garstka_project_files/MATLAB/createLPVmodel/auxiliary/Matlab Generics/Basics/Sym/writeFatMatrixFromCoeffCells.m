function CoeffMat = writeFatMatrixFromCoeffCells(CoeffCell)

% Generate the fat coefficient matrix mapping the some monomial basis
CoeffMat = [];
for ii = 1:size(CoeffCell, 2)
    CoeffMat = [CoeffMat, CoeffCell{ii}];
end
try
    CoeffMat = double(CoeffMat);
catch
end