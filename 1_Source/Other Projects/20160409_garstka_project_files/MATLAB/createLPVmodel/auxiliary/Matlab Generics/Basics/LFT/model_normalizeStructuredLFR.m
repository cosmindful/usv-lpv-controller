function [uNTHETAP, MNLFR, THETAScaling] = model_normalizeStructuredLFR(uTHETAP, MLFR)

[uTHETAP_bnd, uTHETAP_nom] = umat_getBounds(uTHETAP);
THETAScaling = ((uTHETAP_bnd{2} - uTHETAP_bnd{1})/2); %abs?

rowSum = THETAScaling*ones(size(THETAScaling, 2), 1);
rowSumONES = rowSum;
rowSumONES(rowSum == 0) = 1;
rowSumONES = rowSumONES - rowSum;
rowSumONES = diag(rowSumONES);
THETAScaling = THETAScaling + rowSumONES;

uNTHETAP = THETAScaling\uTHETAP; % A\B = x, A*x = B, x = A^-1 B

[MLFR11, MLFR12, MLFR21, MLFR22] = mat2x2(MLFR, size(uTHETAP, 1), size(uTHETAP, 2));

MNLFR11 = MLFR11*THETAScaling;
MNLFR21 = MLFR21*THETAScaling;
MNLFR12 = MLFR12;
MNLFR22 = MLFR22;

MNLFR   = [ MNLFR11, MNLFR12;...
            MNLFR21, MNLFR22];