function MLFR_LambdaOfUpsilon = buildModel_MLFRLambdaOfUpsilon(nJblock, nKblock, nDblock, nTblock, nq, nqd, sJ0inv, sK0, sD0, sT0, bjnu, bjnuval)

nJ     = numel(nJblock);
nK     = numel(nKblock);
nD     = numel(nDblock);
nT     = numel(nTblock);

nqd    = size(sD0, 2);
nq     = size(sK0, 2);
nu     = size(sT0, 2);

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
% The minus is hardwired into the Upsilon block and sK0, sD0!
% sQ0   = [-sK0, -sD0, sT0 ];
sQ0   = [sK0, sD0, sT0 ];

sVQ = mdiag(sVK, sVD, sVT); sVQ = I(3*nq);
nVq = size(sVQ, 2);

sWJKD      = mdiag(sWJ, sWK, sWD, sWT);
IWJKD      = I(size(sWJKD, 1));
 WJKD      = double(subs(sWJKD, bjnu, bjnuval));
 
sVJKD      = sVq;
IVJKD      = I(size(sVJKD, 2));
 VJKD      = double(subs(sVJKD, bjnu, bjnuval));
 
sWLambda11 = [ sWJKD*[-sJ0inv; O(nq+nqd+nu, nqd)]*sVJKD ];
 WLambda11 = double(subs(sWLambda11, bjnu, bjnuval));  
% sWLambda12 =   sWJKD*[-sJ0inv*sQ0*sVQ; sVQ];
sWLambda12 = IWJKD;
 WLambda12 = double(subs(sWLambda12, bjnu, bjnuval));                  
% sWLambda21 =   sVJKD;
sWLambda21 = IVJKD;
 WLambda21 = double(subs(sWLambda21, bjnu, bjnuval));          
% sWLambda22 = [ O(nq, 3*nq)*sVQ ];
sWLambda22 = O(size(IVJKD, 1), size(IWJKD, 2));
 WLambda22 = double(subs(sWLambda22, bjnu, bjnuval));




% sWJKD      = mdiag(sWJ*J0inv, sWK, sWD, sWT, I(nq));
%  WJKD      = double(subs(sWJKD, bjnu, bjnuval));
% sWLambda11 = [ -Iq,     Iq,     Iq,    Iq ;...
%                 O(3*nq, 4*nq)             ];
%  WLambda11 = double(subs(sWLambda11, bjnu, bjnuval));  
% sWLambda12 = [ sK0,   sD0,   sT0;...
%                I(3*nq, 3*nq)    ];
%  WLambda12 = double(subs(sWLambda12, bjnu, bjnuval));                  
% sWLambda21 = [ -Iq Iq Iq Iq ];
%  WLambda21 = double(subs(sWLambda21, bjnu, bjnuval));          
% sWLambda22 = [ O(nq, 3*nq) ];
%  WLambda22 = double(subs(sWLambda22, bjnu, bjnuval));
% 
% sVJKD      = mdiag(sVJ, sVK, sVD, sVT, I(3*nq));
%  VJKD      = double(subs(sVJKD, bjnu, bjnuval));
 
%  MLFR_LambdaOfUpsilon = WJKD*[ WLambda11,  WLambda12;  WLambda21,  WLambda22]* VJKD;
 MLFR_LambdaOfUpsilon = [ WLambda11,  WLambda12;  WLambda21,  WLambda22];