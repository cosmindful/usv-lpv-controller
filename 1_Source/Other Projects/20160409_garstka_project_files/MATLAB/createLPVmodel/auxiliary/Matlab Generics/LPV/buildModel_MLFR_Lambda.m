function [MLFR11_Lambda, MLFR12_Lambda, MLFR21_Lambda, MLFR22_Lambda, uLambda_StructureBlock] = ...
    buildModel_MLFR_Lambda(nJblock, nKblock, nDblock, nTblock, nq, nqd, nxG, ny, nu, sJ0inv, sK0, sD0, sT0, bjnu, bjnuval, uLambda)

nJ     = numel(nJblock);
nK     = numel(nKblock);
nD     = numel(nDblock);
nT     = numel(nTblock);

Iq     = I(nq);
IJ     = I(nqd);
IK     = I(nq);
ID     = I(nq);
IT     = I(nq);
% 
% sVJ     = O(nq, nJ); sVJ(nJblock, :) = I(nJ);
% sVK     = O(nq, nK); sVK(nKblock, :) = I(nK);
% sVD     = O(nq, nD); sVD(nDblock, :) = I(nD);
% sVT     = O(nq, nT); sVT(nTblock, :) = I(nT);
% sWJ     = O(nJ, nq); sWJ(:, nJblock) = I(nJ);
% sWK     = O(nK, nq); sWK(:, nKblock) = I(nK);
% sWD     = O(nD, nq); sWD(:, nDblock) = I(nD);
% sWT     = O(nT, nq); sWT(:, nTblock) = I(nT);

sVJ     = O(nqd, nJ); sVJ(nJblock, :) = I(nJ);
sVq     = I(nqd);
sVK     = O(nqd, nK); sVK(nKblock, :) = I(nK);
sVD     = O(nqd, nD); sVD(nDblock, :) = I(nD);
sVT     = O(nqd, nT); sVT(nTblock, :) = I(nT);
sWJ     = O(nJ, nqd); sWJ(:, nJblock) = I(nJ);
sWK     = O(nK, nq);  sWK(:, nKblock) = I(nK);
sWD     = O(nD, nqd); sWD(:, nDblock) = I(nD);
sWT     = O(nT, nu);  sWT(:, nTblock) = I(nT);

J0inv = double(subs(sJ0inv, bjnu, bjnuval));

nz_Lambda = size(uLambda, 2);
nw_Lambda = size(uLambda, 1);

%  sW_ABCD_Lambda = mdiag(I(nq), sJ0inv, I(nz_Lambda), I(ny));
%      sAG_Lambda = [  O(nq, nq)  ,  I(nq, nqd) ;...
%                      sK0        ,  sD0        ];
%   sBG_th_Lambda = [  O(nq       , nw_Lambda)  ;...
%                      I(nq       , nw_Lambda)  ];
%    sBG_u_Lambda = [  O(nq, nu)                ;...
%                      sT0                      ];
%   sCG_th_Lambda = [  I(nz_Lambda,  nxG)       ];
% sDG_thth_Lambda = [  O(nz_Lambda,  nw_Lambda) ];
%  sDG_thu_Lambda = [  O(nz_Lambda-nu, nu)      ;...
%                      I(nu)                    ];
%    sCG_y_Lambda = [  I(ny       ,  nxG)       ];
%  sDG_yth_Lambda = [  O(ny       ,  nw_Lambda) ];
%   sDG_yu_Lambda = [  O(ny       ,  nu)        ];

sVJKDT = [sVJ];
sWKD   = [mdiag(sWK, sWD); O(nT, nxG)];
sW     = mdiag(sWJ, sWK, sWD, sWT);

 sW_ABCD_Lambda = mdiag(I(nq), sJ0inv, W_LambdaExtra*sW*mdiag(-sJ0inv, I(3*nq)), I(ny));
     sAG_Lambda = [  O(nq, nq)  ,  I(nq, nqd) ;...
                      sK0        ,  sD0        ];
  sBG_th_Lambda = [  O(nq       , nw_Lambda) ;...
                      sVJKDT                   ];
   sBG_u_Lambda = [  O(nq, nu)                ;...
                      sT0                      ];
  sCG_th_Lambda = [  sK0        ,  sD0        ;...
                      I(3*nq     ,  2*nq)      ];
sDG_thth_Lambda = [  sVJKDT*0                 ;...
                      O(3*nq, nw_Lambda) ];
 sDG_thu_Lambda = [  sT0                      ;...
                      O(2*nq     , nu)         ;...
                      I(nu)                    ];
   sCG_y_Lambda = [  I(ny       ,  nxG)        ];
 sDG_yth_Lambda = [  O(ny       ,  nw_Lambda)];
  sDG_yu_Lambda = [  O(ny       ,  nu)        ];

   sABCD_Lambda = [    sAG_Lambda,   sBG_th_Lambda,   sBG_u_Lambda ;...
                    sCG_th_Lambda, sDG_thth_Lambda, sDG_thu_Lambda ;...
                     sCG_y_Lambda,  sDG_yth_Lambda,  sDG_yu_Lambda ];

sPlant_Lambda   = sW_ABCD_Lambda*sABCD_Lambda;
 Plant_Lambda   = double(subs(sPlant_Lambda, bjnu, bjnuval));
 
% sW_MLFR_Lambda  = mdiag(I(nz_Lambda), I(nq), sJ0inv, I(ny));
sW_MLFR_Lambda  = mdiag(sW*mdiag(-sJ0inv, I(3*nq)), I(nq), sJ0inv, I(ny));
  sMLFR_Lambda  = [ sDG_thth_Lambda,  sCG_th_Lambda,  sDG_thu_Lambda ;...
                      sBG_th_Lambda,     sAG_Lambda,    sBG_u_Lambda ;...
                     sDG_yth_Lambda,   sCG_y_Lambda,   sDG_yu_Lambda ];
                 
  sMLFR_Lambda  = sW_MLFR_Lambda*sMLFR_Lambda;
   MLFR_Lambda  = double(subs(sMLFR_Lambda, bjnu, bjnuval));
[MLFR11_Lambda, MLFR12_Lambda, MLFR21_Lambda, MLFR22_Lambda] = mat2x2(MLFR_Lambda, nz_Lambda, nw_Lambda);

slambda = generateParameterVector('slambda', nz_Lambda);
    nominalParamBounds  = kron([-1, 1], ones(nz_Lambda, 1));
           ParamNominal = O(nz_Lambda, 1);
ulambda = generateuParamsFromsParams(slambda, nominalParamBounds, ParamNominal, 1);

% Doesn't work
% uLambda_StructureBlock = [diag(ulambda(1:3)), diag(ulambda(4:6)), diag(ulambda(7:9))];
uLambda_StructureBlock = diag(ulambda);