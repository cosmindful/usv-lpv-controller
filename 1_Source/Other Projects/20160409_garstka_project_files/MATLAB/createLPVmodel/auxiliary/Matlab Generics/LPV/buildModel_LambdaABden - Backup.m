function [sLambda_num, sLambda_den, Lambda_num, Lambda_den] = buildModel_LambdaABden(nJblock, nKblock, nDblock, nTblock, nq, sJ0inv, sK0, sD0, sT0, bjnu, bjnuval, sDeltaJ, sDeltaK, sDeltaD)

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
sVq     = I(nq);
sVK     = O(nq, nK); sVK(nKblock, :) = I(nK);
sVD     = O(nq, nD); sVD(nDblock, :) = I(nD);
sVT     = O(nq, nT); sVT(nTblock, :) = I(nT);
sWJ     = O(nJ, nq); sWJ(:, nJblock) = I(nJ);
sWK     = O(nK, nq); sWK(:, nKblock) = I(nK);
sWD     = O(nD, nq); sWD(:, nDblock) = I(nD);
sWT     = O(nT, nq); sWT(:, nTblock) = I(nT);

J0inv = double(subs(sJ0inv, bjnu, bjnuval));

sVJKD      = mdiag(sVJ, sVK, sVD, sVT, I(3*nq));
 VJKD      = double(subs(sVJKD, bjnu, bjnuval));

sLambdaA        = IJ + sVJ*sDeltaJ*sWJ*sJ0inv;
sLambda_den     = expand(det(sLambdaA));
 Lambda_den     = subs(sLambda_den, bjnu, bjnuval);
% sd          = vpa(det(sLambda_den), 4);
% sadj        = adjoint(sLambda_den);
% 
% sLambdaK = sVK*sDeltaK_nuN*sWK - sVJ*sDeltaJ_nuN*sWJ*sJnuN0inv*sKnuN0;
% sLambdaD = sVD*sDeltaD_nuN*sWD - sVJ*sDeltaJ_nuN*sWJ*sJnuN0inv*sDnuN0;
% sLambdaT =                     - sVJ*sDeltaJ_nuN*sWJ*sJnuN0inv;
% 
sLambdaA = expand(adjoint(sLambdaA));
sLambdaB = [ sVq*sDeltaK*sWK, sVq*sDeltaD*sWD, O(nq, nq) ] - ...
             sVJ*sDeltaJ*sWJ*sJ0inv*[ sK0, sD0, sT0 ];
sLambdaB = expand(sLambdaB);
 LambdaA = subs(sLambdaA, bjnu, bjnuval);
 LambdaB = subs(sLambdaB, bjnu, bjnuval);
 LambdaA = cleanUpPolynomialSymMat(LambdaA, 1e-6);
 LambdaB = cleanUpPolynomialSymMat(LambdaB, 1e-6);
 
sLambda_num  = sLambdaA*sLambdaB;
 Lambda_num  =  LambdaA* LambdaB;
 Lambda_num  = expand(vpa(Lambda_num, 5));