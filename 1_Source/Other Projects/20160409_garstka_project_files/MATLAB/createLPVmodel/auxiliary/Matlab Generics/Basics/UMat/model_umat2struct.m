function MLFR = model_umat2struct(argMLFR);

argMLFR = umat(argMLFR);

[M_MLFR  , Theta_MLFR  , Blkstruct_MLFR  , Normunc_MLFR] = lftdata(argMLFR);

nzMth = size(Theta_MLFR   , 2);
nwMth = size(Theta_MLFR   , 1);

[MLFR.D_thth, MLFR.C_th, MLFR.B_th, MLFR.A] = mat2x2(M_MLFR, nwMth, nzMth);

MLFR.rtheta = [Blkstruct_MLFR.Occurrences];
MLFR.ntheta = size(MLFR.rtheta, 2);

MLFR.THETA  = Theta_MLFR;

MLFR.Sizes.nzth = nzMth;
MLFR.Sizes.nwth = nwMth;