function LapMat = generate_randomRowNormalizedDirectedLaplacianMatrix(nH, threshold, demandConnectivity)
% Generates a random non-symmetric normalized (row) Laplacian matrix

AdjMat = generate_randomRowNormalizedDirectedAdjacencyMatrix(nH, threshold, demandConnectivity);

rowSum = AdjMat*ones(nH, 1);
rowSum(rowSum == 0) = 0; %use pinv!
rowSum = diag(rowSum);

LapMat = rowSum - AdjMat;