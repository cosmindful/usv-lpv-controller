function CoeffCell = writeFatMatrixFromCoeffCells(CoeffMat, sMonomialBasis, n2)

% Generate cell array of coefficient matrices from fat matrix
CoeffCell = {};
for ii = 1:size(sMonomialBasis, 1)
    CoeffCell{ii} = CoeffMat(:, (1:n2)+n2*(ii-1));
end