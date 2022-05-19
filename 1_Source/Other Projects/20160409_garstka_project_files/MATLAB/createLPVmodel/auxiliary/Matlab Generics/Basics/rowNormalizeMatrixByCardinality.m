function rowNormMat = rowNormalizeMatrixByCardinality(Mat)

rowSum = diag(Mat);
rowSum(rowSum == 0) = 1;
rowSum = diag(rowSum);

rowNormMat = rowSum\Mat;