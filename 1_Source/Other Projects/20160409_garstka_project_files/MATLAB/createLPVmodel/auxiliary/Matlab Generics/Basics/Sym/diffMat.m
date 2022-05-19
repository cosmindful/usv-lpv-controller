function [sdMatOfrho] = diffMat(sMatOfrho, rho, drho)

nrho          = numel(rho);
sdMatOfrho    = O(size(sMatOfrho));

for ii = 1:nrho
    sdMatOfrho = sdMatOfrho + diff(sMatOfrho, rho(ii))*drho(ii);
end