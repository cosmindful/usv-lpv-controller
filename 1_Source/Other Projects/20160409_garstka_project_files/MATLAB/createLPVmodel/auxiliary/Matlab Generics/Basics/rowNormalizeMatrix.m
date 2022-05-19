function rowNormMat = rowNormalizeMatrix(Mat)

rowSum = Mat*ones(size(Mat, 2), 1);
rowSum(rowSum == 0) = 1;
rowSum = diag(rowSum);

rowNormMat = rowSum\Mat;