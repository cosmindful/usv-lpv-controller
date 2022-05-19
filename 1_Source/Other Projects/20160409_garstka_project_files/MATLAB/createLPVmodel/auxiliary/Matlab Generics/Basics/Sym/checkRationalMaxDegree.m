function [maxDegreeN, maxDegreeD] = checkRationalMaxDegree(sRational)

[sN, sD] = numden(sRational);

maxDegreeN = checkPolynomialMaxDegree(sN);
maxDegreeD = checkPolynomialMaxDegree(sD);