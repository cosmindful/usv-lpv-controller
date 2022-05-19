function cleanMat = cleanUpMat(mat, tol)

mat = double(mat);
mat(abs(mat)  < tol) = 0;
cleanMat = mat;