function [MLFR11_Upsilon, MLFR12_Upsilon, MLFR21_Upsilon, MLFR22_Upsilon, uUpsilon_StructureBlock] = ...
    buildModel_MLFR_Upsilon(nJblock, nKblock, nDblock, nTblock, nqdblock, nq, nqd, nxG, ny, nu, sJ0inv, sK0, sD0, sT0, sCy, bjnu, bjnuval, uUpsilon)

nJ     = numel(nJblock);
nK     = numel(nKblock);
nD     = numel(nDblock);
nT     = numel(nTblock);
nQ     = numel(nqdblock);

Iq     = I(nq);
IJ     = I(nq);
IK     = I(nq);
ID     = I(nq);
IT     = I(nq);

sVJ     = O(nq, nQ ); sVJ(nqdblock, :) = I(nQ);
sVK     = O(nq, nK ); sVK(nKblock, :) = I(nK);
sVD     = O(nq, nD ); sVD(nDblock, :) = I(nD);
sVT     = O(nq, nT ); sVT(nTblock, :) = I(nT);
sWJ     = O(nJ, nqd); sWJ(:, nJblock) = I(nJ);
sWK     = O(nK, nq ); sWK(:, nKblock) = I(nK);
sWD     = O(nD, nqd); sWD(:, nDblock) = I(nD);
sWT     = O(nT, nq ); sWT(:, nTblock) = I(nT);

J0inv = double(subs(sJ0inv, bjnu, bjnuval));

nz_Upsilon = size(uUpsilon, 2);
nw_Upsilon = size(uUpsilon, 1);

sVJKDT = [sVJ];
sWKD   = [mdiag(sWK, sWD); O(nT, nxG)];
sW     = mdiag(sWJ, sWK, sWD, sWT);

DIRTY_FIX = O(nq, nqd);
if nq < nqd
    DIRTY_FIX(1:nq, end-nq+1:end) = I(nq);
else
    DIRTY_FIX = I(nq, nqd);
end

 sW_ABCD_Upsilon = mdiag(I(nq), sJ0inv, sW*mdiag(-sJ0inv, I(nq+nqd+nu)), I(ny));
     sAG_Upsilon = [  O(nq, nq)  ,  DIRTY_FIX ;...
                      sK0        ,  sD0        ];
  sBG_th_Upsilon = [  O(nq       , nw_Upsilon) ;...
                      sVJKDT                   ];
   sBG_u_Upsilon = [  O(nq, nu)                ;...
                      sT0                      ];
  sCG_th_Upsilon = [  sK0        ,  sD0        ;...
                      I(nq+nqd+nu,  nq+nqd)    ];
sDG_thth_Upsilon = [  sVJKDT                   ;...
                      O(nq+nqd+nu, nw_Upsilon) ];
 sDG_thu_Upsilon = [  sT0                      ;...
                      O(nq+nqd   , nu)         ;...
                      I(nu)                    ];
   sCG_y_Upsilon = sCy;%[  I(ny       ,  nxG)        ];
 sDG_yth_Upsilon = [  O(ny       ,  nw_Upsilon)];
  sDG_yu_Upsilon = [  O(ny       ,  nu)        ];

   sABCD_Upsilon = [    sAG_Upsilon,   sBG_th_Upsilon,   sBG_u_Upsilon ;...
                     sCG_th_Upsilon, sDG_thth_Upsilon, sDG_thu_Upsilon ;...
                      sCG_y_Upsilon,  sDG_yth_Upsilon,  sDG_yu_Upsilon ];

sPlant_Upsilon   = sW_ABCD_Upsilon*sABCD_Upsilon;
 Plant_Upsilon   = double(subs(sPlant_Upsilon, bjnu, bjnuval));
 
sW_MLFR_Upsilon  = mdiag(sW*mdiag(-sJ0inv, I(nq+nqd+nu)), I(nq), sJ0inv, I(ny));
  sMLFR_Upsilon  = [ sDG_thth_Upsilon,  sCG_th_Upsilon,  sDG_thu_Upsilon ;...
                       sBG_th_Upsilon,     sAG_Upsilon,    sBG_u_Upsilon ;...
                      sDG_yth_Upsilon,   sCG_y_Upsilon,   sDG_yu_Upsilon ];
                 
  sMLFR_Upsilon  = sW_MLFR_Upsilon*sMLFR_Upsilon;
   MLFR_Upsilon  = double(subs(sMLFR_Upsilon, bjnu, bjnuval));
[MLFR11_Upsilon, MLFR12_Upsilon, MLFR21_Upsilon, MLFR22_Upsilon] = mat2x2(MLFR_Upsilon, nz_Upsilon, nw_Upsilon);

supsilon = generateParameterVector('supsilon', nz_Upsilon);
    nominalParamBounds  = kron([-1, 1], ones(nz_Upsilon, 1));
           ParamNominal = O(nz_Upsilon, 1);
uupsilon = generateuParamsFromsParams(supsilon, nominalParamBounds, ParamNominal, 1);

uUpsilon_StructureBlock = diag(uupsilon);