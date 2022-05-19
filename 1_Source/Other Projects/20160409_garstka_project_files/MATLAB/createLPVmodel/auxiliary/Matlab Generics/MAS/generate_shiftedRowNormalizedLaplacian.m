function [ModLapMat] = generate_shiftedRowNormalizedLaplacian(nF)
AdjMat = generate_randomRowNormalizedAdjacencyMatrix(nF, 0.3, 1);

ModLapMat = -diag(AdjMat*ones(nF, 1)) + AdjMat + I(nF);