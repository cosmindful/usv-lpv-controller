function LapMat = generate_randomNormalizedDirectedLaplacianMatrix(nH, threshold, demandConnectivity)
% Generates a random symmetric normalized (row and col) Laplacian matrix

AdjMat = generate_randomNormalizedDirectedAdjacencyMatrix(nH, threshold, demandConnectivity);

rowSum = AdjMat*ones(nH, 1);
rowSum(rowSum == 0) = 0; %use pinv!
rowSum = diag(rowSum);

LapMat = rowSum - AdjMat;