function [indexMat] = indexMat(n, m)
%%
indexVec = 1:n*m;

indexMat = reshape(indexVec, m, n)';