function PLFR = model_uss2struct(argPLFR, nu, ny);

if strcmp('uss', class(argPLFR))
    [M_PLFR  , Theta_PLFR  , Blkstruct_PLFR  , Normunc_PLFR  ] = lftdata(argPLFR);
elseif strcmp('ss', class(argPLFR))
    M_PLFR.a = argPLFR.a;
    M_PLFR.b = argPLFR.b;
    M_PLFR.c = argPLFR.c;
    M_PLFR.d = argPLFR.d;
    Theta_PLFR = [];
    Blkstruct_PLFR.Occurrences = [];
end

nxP   = size(argPLFR.a    , 1);
nzPth = size(Theta_PLFR   , 2);
nwPth = size(Theta_PLFR   , 1);
nwPp  = size(argPLFR.b    , 2) - nu;
nzPp  = size(argPLFR.c    , 1) - ny;

PLFR.A       = M_PLFR.a((           1):(nxP          ),(           1):(nxP          ));
PLFR.B_th    = M_PLFR.b((           1):(nxP          ),(           1):(nwPth        ));
PLFR.B_p     = M_PLFR.b((           1):(nxP          ),(nwPth     +1):(nwPth+nwPp   ));
PLFR.B_u     = M_PLFR.b((           1):(nxP          ),(nwPth+nwPp+1):(nwPth+nwPp+nu));
PLFR.D_thth  = M_PLFR.d((           1):(nzPth        ),(           1):(nwPth        ));
PLFR.D_thp   = M_PLFR.d((           1):(nzPth        ),(nwPth     +1):(nwPth+nwPp   ));
PLFR.D_thu   = M_PLFR.d((           1):(nzPth        ),(nwPth+nwPp+1):(nwPth+nwPp+nu));
PLFR.D_pth   = M_PLFR.d((nzPth     +1):(nzPth+nzPp   ),(           1):(nwPth        ));
PLFR.D_pp    = M_PLFR.d((nzPth     +1):(nzPth+nzPp   ),(nwPth     +1):(nwPth+nwPp   ));
PLFR.D_pu    = M_PLFR.d((nzPth     +1):(nzPth+nzPp   ),(nwPth+nwPp+1):(nwPth+nwPp+nu));
PLFR.D_yth   = M_PLFR.d((nzPth+nzPp+1):(nzPth+nzPp+ny),(           1):(nwPth        ));
PLFR.D_yp    = M_PLFR.d((nzPth+nzPp+1):(nzPth+nzPp+ny),(nwPth     +1):(nwPth+nwPp   ));
PLFR.D_yu    = M_PLFR.d((nzPth+nzPp+1):(nzPth+nzPp+ny),(nwPth+nwPp+1):(nwPth+nwPp+nu));
PLFR.C_th    = M_PLFR.c((           1):(nzPth        ),(           1):(nxP          ));
PLFR.C_p     = M_PLFR.c((nzPth     +1):(nzPth+nzPp   ),(           1):(nxP          ));
PLFR.C_y     = M_PLFR.c((nzPth+nzPp+1):(nzPth+nzPp+ny),(           1):(nxP          ));


PLFR.rtheta = [Blkstruct_PLFR.Occurrences];
PLFR.ntheta = size(PLFR.rtheta, 2);

PLFR.THETA  = Theta_PLFR;%umat2smat(Theta_PLFR);
PLFR.x0     = O(nxP, 1);

PLFR.Ts     = argPLFR.Ts;

PLFR.Sizes.nx   = nxP;
PLFR.Sizes.nzth = nzPth;
PLFR.Sizes.nwth = nwPth;
PLFR.Sizes.nzp  = nzPp;
PLFR.Sizes.nwp  = nwPp;
PLFR.Sizes.nu   = nu;
PLFR.Sizes.ny   = ny;
