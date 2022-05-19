function MLFR_LambdaOfUpsilon = model_MLFRLambdaOfUpsilon(nJblock, nKblock, nDblock, nTblock, nq, sJ0inv, sK0, sD0, sT0, bjnu, bjnuval)

nJ     = numel(nJblock);
nK     = numel(nKblock);
nD     = numel(nDblock);
nT     = numel(nTblock);

Iq     = I(nq);
IJ     = I(nq);
IK     = I(nq);
ID     = I(nq);
IT     = I(nq);

sVJ     = O(nq, nJ); sVJ(nJblock, :) = I(nJ);
sVK     = O(nq, nK); sVK(nKblock, :) = I(nK);
sVD     = O(nq, nD); sVD(nDblock, :) = I(nD);
sVT     = O(nq, nT); sVT(nTblock, :) = I(nT);
sWJ     = O(nJ, nq); sWJ(:, nJblock) = I(nJ);
sWK     = O(nK, nq); sWK(:, nKblock) = I(nK);
sWD     = O(nD, nq); sWD(:, nDblock) = I(nD);
sWT     = O(nT, nq); sWT(:, nTblock) = I(nT);

J0inv = double(subs(sJ0inv, bjnu, bjnuval));

sWJKD      = mdiag(sWJ*J0inv, sWK, sWD, sWT, I(nq));
 WJKD      = double(subs(sWJKD, bjnu, bjnuval));
sWLambda11 = [ -Iq,     Iq,     Iq,    Iq ;...
                O(3*nq, 4*nq)             ];
 WLambda11 = double(subs(sWLambda11, bjnu, bjnuval));  
sWLambda12 = [ sK0,   sD0,   sT0;...
               I(3*nq, 3*nq)    ];
 WLambda12 = double(subs(sWLambda12, bjnu, bjnuval));                  
sWLambda21 = [ -Iq Iq Iq Iq ];
 WLambda21 = double(subs(sWLambda21, bjnu, bjnuval));          
sWLambda22 = [ O(nq, 3*nq) ];
 WLambda22 = double(subs(sWLambda22, bjnu, bjnuval));

sVJKD      = mdiag(sVJ, sVK, sVD, sVT, I(3*nq));
 VJKD      = double(subs(sVJKD, bjnu, bjnuval));
 
 MLFR_LambdaOfUpsilon = WJKD*[ WLambda11,  WLambda12;  WLambda21,  WLambda22]* VJKD;