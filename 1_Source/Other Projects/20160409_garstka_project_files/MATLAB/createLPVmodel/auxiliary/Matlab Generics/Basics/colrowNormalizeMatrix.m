function colrowNormMat = colrowNormalizeMatrix(Mat)

rowSum = Mat*ones(size(Mat, 2), 1);
rowSum(rowSum == 0) = 1;
rowSum = diag(rowSum);

colSum = ones(1, size(Mat, 1))*Mat;
colSum(colSum == 0) = 1;
colSum = diag(colSum);


colrowNormMat = rowSum\Mat/colSum;