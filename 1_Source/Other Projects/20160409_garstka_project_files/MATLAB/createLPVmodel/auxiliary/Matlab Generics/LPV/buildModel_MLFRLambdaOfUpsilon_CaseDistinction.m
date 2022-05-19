function [MLFR_LambdaOfUpsilon, WLambdaExtra] = buildModel_MLFRLambdaOfUpsilon_CaseDistinction(nJblock, nKblock, nDblock, nTblock, nqdblock, nq, nqd, sJ0inv, sK0, sD0, sT0, bjnu, bjnuval)

nJ     = numel(nJblock);
nK     = numel(nKblock);
nD     = numel(nDblock);
nT     = numel(nTblock);
nQ     = numel(nqdblock);

nqd    = size(sD0, 2);
nq     = size(sK0, 2);
nu     = size(sT0, 2);

sVJ     = O(nqd, nJ); sVJ(nJblock, :) = I(nJ);
sVQ     = O(nqd, nQ); sVQ(nqdblock,:) = I(nQ); 
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

% sVQ = mdiag(sVK, sVD, sVT); sVQ = I(3*nq);
% nVq = size(sVQ, 2);

sWJKD      = mdiag(sWJ, sWK, sWD, sWT);
IWJKD      = I(size(sWJKD, 1));
 WJKD      = double(subs(sWJKD, bjnu, bjnuval));
 
sVJKD      = sVQ;
IVJKD      = I(size(sVJKD, 2));
 VJKD      = double(subs(sVJKD, bjnu, bjnuval));
 
sWLambda11 = [ sWJKD*[-sJ0inv; O(nq+nqd+nu, nqd)]*sVJKD ];
 WLambda11 = double(subs(sWLambda11, bjnu, bjnuval));  
% sWLambda12 =   sWJKD*[-sJ0inv*sQ0*sVQ; sVQ];

nzUpsilon = size(WLambda11, 1);

% Means Lambda can be smaller than Upsilon, thus MLFR12_LambdaOfUpsilon
% is not identity
sWLambda12 = sWJKD*[-sJ0inv*[sK0, sD0, sT0]; I(nq+nqd+nu)];
 WLambda12 = double(subs(sWLambda12, bjnu, bjnuval));    
% sWLambda21 =   sVJKD;
sWLambda21 = I(nQ);VJKD;
 WLambda21 = double(subs(sWLambda21, bjnu, bjnuval));          
% sWLambda22 = [ O(nq, 3*nq)*sVQ ];
sWLambda22 = O(nQ, size(WLambda12, 2));O(size(VJKD, 1), size(WLambda12, 2));
 WLambda22 = double(subs(sWLambda22, bjnu, bjnuval));
% In the case that some column of K or D is completely zero
% That is: the parameter-dependent part of the affine model will be
% smaller!
    WLambdaExtra = I(size(WLambda12, 2));

    N = null([WLambda12; WLambda22]);
    N(abs(N) < 1e-12) = 0;
    
    Nmask = sum(abs(N), 2);
    Nmask = Nmask > 0;
    blksize = sum(Nmask == 0);

if (blksize > nzUpsilon)
% Means choosing identitiy for MLFR12_LambdaOfUpsilon will result in
% smaller block
sWLambda12 = IWJKD;
 WLambda12 = double(subs(sWLambda12, bjnu, bjnuval));
end


nzLambda = size(WLambda12, 2);
 

   
    if ~isempty(N)    
        proj         = (I(size(N, 1)) - N*N');
        WLambdaExtra = proj(not(logical(Nmask)), :);
    end
    
    WLambda22 = WLambda22*WLambdaExtra';
    WLambda12 = WLambda12*WLambdaExtra';


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