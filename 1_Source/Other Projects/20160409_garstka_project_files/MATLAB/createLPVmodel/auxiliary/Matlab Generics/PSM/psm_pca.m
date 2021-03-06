function [NTHETAhat,PHI,PHI_bnd,Us,nrp,percerr,dSIG,Normlz] = psm_pca(ptraj,reqacc,nphi,map)
% This function apply paramter set mapping using principle component
% analysis to a given trajectory matrix 'ptraj' 
% 'reqacc' required accuracy, 'map' scaling type pm1 or 0mean or 
%  0mean, 1std (defualt)
%
% ref.  A. Kwiatkowski PhD thesis 2007 TUHH
%
% HS: 14.12.08

np = size(ptraj,1);
nd = size(ptraj,2);
if np>=nd,
    error('data samples are not enough or transpose the trajectory matrix');
end
THETA  = ptraj;
[NTHETA,Normlz] = mapstd(THETA);        % 0mean 1std
if strcmp(map,'0mean'),
    for k=1:np,
        NTHETA(k,:) = THETA(k,:)-Normlz.xmean(k);%0mean
    end
    Normlz      = Normlz.xmean;
elseif strcmp(map,'pm1'),
    [NTHETA,Normlz] = mapminmax(THETA);     % +-1
elseif strcmp(map,'0mid'),
    [NTHETA,Normlz] = mapminmax(THETA); 
    Normlz.xmid = (Normlz.xmax + Normlz.xmin)/2;
    for k=1:np,
        NTHETA(k,:) = THETA(k,:)-Normlz.xmid(k);%0mid
    end
end
if (nphi == 0)
    [U,SIG,V]   = svd(NTHETA, 'econ');          % PCA
    dSIG        = diag(SIG(:,1:np));
    tsumsqr     = sumsqr(dSIG);
    for i=1:np;
        percerr = sumsqr(dSIG(1:i))/tsumsqr*100;
        if percerr >= reqacc,
            break
        end
    end
    nrp = i;
else
    [U,SIG ,V]  = svd(NTHETA, 'econ');   
    SIGtemp = zeros(size(SIG));
    SIGtemp(1:nphi, 1:nphi) = SIG(1:nphi, 1:nphi);
    err = sumsqr(NTHETA - U*SIGtemp*V');
    [~,dSIG,~]  = svds(NTHETA, nphi);          % PCA
    tsumsqr     = sumsqr(SIG);
    percerr     = sumsqr(dSIG(1:nphi))/tsumsqr*100;
    nrp         = nphi;
end

SIGs = SIG(1:nrp,1:nrp);
Us   = U(:,1:nrp);
VT   = V';
VsT  = VT(1:nrp,:);
NTHETAhat = Us*SIGs*VsT;
PHI  = Us'*NTHETA;
PHI_bnd = zeros(nrp,2);
for j=1:nrp,
    PHI_bnd(j,:) = [min(PHI(j,:)) max(PHI(j,:))];
end

% Us(abs(Us) < 1e-3) = 0;