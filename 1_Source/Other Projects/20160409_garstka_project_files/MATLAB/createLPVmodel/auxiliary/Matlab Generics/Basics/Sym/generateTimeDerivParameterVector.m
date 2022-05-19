function [sdvec, sdvecOfrho] = generateTimeDerivParameterVector(namestr, svec, svecOfrho, rho, drho)

npars         = numel(svec);
nparsOfrho    = numel(svecOfrho);
sdvec         = generateParameterVector(namestr, npars);


sdvecOfrho = diffMat(svecOfrho, rho, drho);
