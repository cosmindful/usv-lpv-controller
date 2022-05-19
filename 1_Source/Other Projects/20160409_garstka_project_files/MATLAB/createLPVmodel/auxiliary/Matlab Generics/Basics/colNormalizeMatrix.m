function colNormMat = colNormalizeMatrix(Mat)

colSum = ones(1, size(Mat, 1))*Mat;
colSum(colSum == 0) = 1;
colSum = diag(colSum);


colNormMat = Mat/colSum;