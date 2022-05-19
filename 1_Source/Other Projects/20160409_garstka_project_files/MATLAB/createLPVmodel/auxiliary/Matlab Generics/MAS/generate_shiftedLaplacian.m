function [ModLapMat] = generate_shiftedLaplacian(nF)
AdjMat = generate_randomAdjacencyMatrix(nF, 0.3, 1);

ModLapMat = -diag(AdjMat*ones(nF, 1)) + AdjMat + I(nF);