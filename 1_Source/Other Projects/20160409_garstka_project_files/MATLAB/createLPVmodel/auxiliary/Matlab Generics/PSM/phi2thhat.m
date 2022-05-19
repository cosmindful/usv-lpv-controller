function Ntheta_hat = phi2thhat(Us,phi,Normlz,map)
% This function to row-wise rescale any phi at any instance given Us tha
% normalization method and Us
%
% 14.12.08


Usphi = Us*phi;

if strcmp(map,'0mean'),
    
    meanData = diag(Normlz) * ones(size(Normlz, 1), size(Usphi, 2));
    Ntheta_hat = Usphi + meanData;

elseif strcmp(map,'pm1'),
    Ntheta_hat = mapminmax('reverse',Usphi,Normlz);
else
    Ntheta_hat = mapstd('reverse',Usphi,Normlz);
end
