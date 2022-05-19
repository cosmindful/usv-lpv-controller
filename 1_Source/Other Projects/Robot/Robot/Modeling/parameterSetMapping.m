function [NTHETAhat,PHI,PHI_bnd,Us,nrp,percerr,dSIG,Normlz] = parameterSetMapping(data, requiredAccuracy, nphi, map)
% This function applies parameter set mapping using principle component
% analysis to a given trajectory matrix 'data'.
% 
% 'requireqdAccuracy' denotes the desired percentage of fit
% 'map'               denotes the scaling type:    'pm1'   for scaling between [-1, 1] 
%                                               or '0mean' for scaling to zero mean
%                                               or '1std'  for scaling to a unity standard deviation

np = size(data, 1);
nd = size(data, 2);
if np >= nd,
    error('Data samples are not enough or transpose the data matrix');
end
THETA  = data;
[NTHETA, Normlz] = mapstd(THETA);
if strcmp(map, '0mean'),
    for k = 1:np,
        NTHETA(k, :) = THETA(k, :) - Normlz.xmean(k);
    end
    Normlz      = Normlz.xmean;
elseif strcmp(map, 'pm1'),
    [NTHETA, Normlz] = mapminmax(THETA);
end

[U, SIG, V]   = svd(NTHETA, 'econ');

if (nphi == 0)
    dSIG          = diag(SIG(:, 1:np));
    tsumsqr       = sumsqr(dSIG);
    for i = 1:np;
        percerr = sumsqr(dSIG(1:i))/tsumsqr*100;
        if percerr >= requiredAccuracy,
            break
        end
    end
    nrp = i;
else
    [U, SIG, V]  = svd(NTHETA, 'econ');   
        SIGtemp  = zeros(size(SIG));
    SIGtemp(1:nphi, 1:nphi) = SIG(1:nphi, 1:nphi);
             err = sumsqr(NTHETA - U*SIGtemp*V');
    [~, dSIG, ~] = svds(NTHETA, nphi);
     tsumsqr     = sumsqr(SIG);
     percerr     = sumsqr(dSIG(1:nphi))/tsumsqr*100;
     nrp         = nphi;
end

SIGs = SIG(1:nrp, 1:nrp);
Us   =   U(:    , 1:nrp);
VT   =   V';
VsT  =  VT(1:nrp, :    );

% Generate approximate data
NTHETAhat = Us *SIGs   *VsT;
PHI       = Us'*NTHETA     ;
PHI_bnd   = [ min( PHI, [], 2 ), max( PHI, [], 2 ) ];

% Erase small entries in the linear combination coefficients
Us(abs(Us) < 1e-2) = 0;

PCA_errGrid = rms(rms(abs(NTHETA - NTHETAhat), 2)) 