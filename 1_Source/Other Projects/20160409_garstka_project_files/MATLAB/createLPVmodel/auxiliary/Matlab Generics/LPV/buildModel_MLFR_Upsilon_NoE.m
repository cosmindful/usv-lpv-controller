function [MLFR_Upsilon, MLFR_E_Upsilon, MLFR_F_Upsilon, uUpsilon_StructureBlock, uDelta_E_StructureBlock, uDelta_F_StructureBlock] = ...
    buildModel_MLFR_Upsilon_NoE(nQFblock, nQEblock, nJblock, nKblock, nDblock, nTblock, nq, nqd, ny, nu, sJ0, sK0, sD0, sT0, bjnu, bjnuval, uDelta_E, uDelta_F)

nz_Delta_F = size(uDelta_F, 2);
nw_Delta_F = size(uDelta_F, 1);

nz_Delta_E = size(uDelta_E, 2);
nw_Delta_E = size(uDelta_E, 1);

nz_Upsilon = nz_Delta_E + nz_Delta_F;
nw_Upsilon = nw_Delta_E;

nJ     = numel(nJblock);
nK     = numel(nKblock);
nD     = numel(nDblock);
nT     = numel(nTblock);
nQF    = numel(nQFblock);
nQE    = numel(nQEblock);

VJF    = O(nqd, nw_Delta_F);
VJF(nQFblock, :) = I(nQF, nw_Delta_F);

VJE    = O(nqd, nw_Delta_E);
VJE(nQEblock, :) = I(nQE, nw_Delta_E);

sWJ     = O(nJ, nq); sWJ(:, nJblock) = I(nJ);
sWK     = O(nK, nq); sWK(:, nKblock) = I(nK);
sWD     = O(nD, nq); sWD(:, nDblock) = I(nD);
sWT     = O(nT, nq); sWT(:, nTblock) = I(nT);
sWY     = O(0, ny);
sWQ     = O(0, nq);



% G: [ Exx Exy ] [ dx ] = [ Fxx Fxu ] [ x ]
%    [ Eyx Eyy ] [  y ]   [ Fyx Fyu ] [ u ]

sVF   = [O(nq, nw_Delta_F); VJF; O(ny, nw_Delta_F)];
sVE   = [O(nq, nw_Delta_E); VJE; O(ny, nw_Delta_E)];
sWE  = mdiag(sWQ, sWJ, sWY);
sWF  = mdiag(sWK, sWD, sWT);
 V   = double(subs(sVF       , bjnu, bjnuval));
 WE  = double(subs(sWE      , bjnu, bjnuval));
 WF  = double(subs(sWF      , bjnu, bjnuval));

     sF0       = [  O(nq, nq)  ,  O(nq, nqd-nq), I(nq, nq)  ,  O(nq, nu)     ;...
                    sK0        ,  sD0                       ,  sT0           ;...
                    I(ny, ny+nu)                                            ];
 
%      sF0       = [  O(nq, nq)  ,  I(nq, nqd)  ,  O(nq, nu)     ;...
%                     sK0        ,  sD0         ,  sT0           ;...
%                     I(ny, ny+nu)                       ];
                   
     sFB_th    = [  sVF  ];
                     
     sFC_th    = [ sWF ];
     
     sFD_thth  = O(nz_Delta_F, nw_Delta_F);
     
     sE0       = mdiag(I(nq), sJ0, I(ny));
                   
     sEB_th    = [  sVE  ];
                     
     sEC_th    = [ sWE ];
     
     sED_thth  = O(nz_Delta_E, nw_Delta_E);
     
 F0       = double(subs(sF0      , bjnu, bjnuval));
 FB_th    = double(subs(sFB_th   , bjnu, bjnuval));
 FC_th    = double(subs(sFC_th   , bjnu, bjnuval));
 FD_thth  = double(subs(sFD_thth , bjnu, bjnuval));
 E0       = double(subs(sE0      , bjnu, bjnuval));
 EB_th    = double(subs(sEB_th   , bjnu, bjnuval));
 EC_th    = double(subs(sEC_th   , bjnu, bjnuval));
 ED_thth  = double(subs(sED_thth , bjnu, bjnuval));

 MLFR_Upsilon = [ -WE*E0^-1*V                  , -WE*E0^-1*F0 ;...
                   O(size(WF, 1), size(V, 2))  ,  WF          ;...
                      E0^-1*V                  ,     E0^-1*F0 ];
                  
 MLFR_F_Upsilon = [ FD_thth, FC_th  ;...
                    FB_th  , F0    ];
                
 MLFR_E_Upsilon = [ ED_thth, EC_th  ;...
                    EB_th  , E0    ];
                  
[MLFR11_Upsilon, MLFR12_Upsilon, MLFR21_Upsilon, MLFR22_Upsilon] = mat2x2(MLFR_Upsilon, nz_Upsilon, nw_Upsilon);

[MLFR_E_11_Upsilon, MLFR_E_12_Upsilon, MLFR_E_21_Upsilon, MLFR_E_22_Upsilon] = mat2x2(MLFR_E_Upsilon, nz_Delta_E, nw_Delta_E);
[MLFR_F_11_Upsilon, MLFR_F_12_Upsilon, MLFR_F_21_Upsilon, MLFR_F_22_Upsilon] = mat2x2(MLFR_F_Upsilon, nz_Delta_F, nw_Delta_F);

%   sMLFR_Upsilon  = [ sDG_thth_Upsilon,  sCG_th_Upsilon,  sDG_thu_Upsilon ;...
%                        sBG_th_Upsilon,     sAG_Upsilon,    sBG_u_Upsilon ;...
%                       sDG_yth_Upsilon,   sCG_y_Upsilon,   sDG_yu_Upsilon ];



% supsilon = generateParameterVector('supsilon', nz_Upsilon);
%     nominalParamBounds  = kron([-1, 1], ones(nz_Upsilon, 1));
%            ParamNominal = O(nz_Upsilon, 1);
% uupsilon = generateuParamsFromsParams(supsilon, nominalParamBounds, ParamNominal, 1);
% 
% uUpsilon_StructureBlock = diag(uupsilon);
% 
% uDelta_E_StructureBlock = uUpsilon_StructureBlock(1:nJ, 1:nJ);
% uDelta_F_StructureBlock = uUpsilon_StructureBlock(nJ+1:end, nJ+1:end);
supsilon = generateParameterVector('supsilon', nQE+nz_Delta_F);
    nominalParamBounds  = kron([-1, 1], ones(nQE+nz_Delta_F, 1));
           ParamNominal = O(nQE+nz_Delta_F, 1);
uupsilon = generateuParamsFromsParams(supsilon, nominalParamBounds, ParamNominal, 1);

uUpsilon_StructureBlock = diag(uupsilon);

uDelta_E_StructureBlock = uUpsilon_StructureBlock(1:nQE, 1:nQE);
uDelta_F_StructureBlock = uUpsilon_StructureBlock(nQE+1:end, nQE+1:end);