function [ModLapMat] = generate_shiftedNormalizedLaplacian(nF)
AdjMat = generate_randomNormalizedAdjacencyMatrix(nF, 0.3, 1);

ModLapMat = -diag(AdjMat*ones(nF, 1)) + AdjMat + I(nF);