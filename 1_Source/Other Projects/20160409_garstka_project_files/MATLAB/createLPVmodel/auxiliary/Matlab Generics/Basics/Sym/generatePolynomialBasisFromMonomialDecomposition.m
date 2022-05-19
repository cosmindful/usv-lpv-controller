function [sPolynomialCoeffs, ...
           PolynomialCoeffs, ...
          sPolynomialBasis , ...
           PolyNomialBasisCoeffs, ...
          sCoeffsOfNewParameters, ...
           CoeffsOfNewParameters, ...
          sNewParameter, ...
           errors      , ...
           sigma ] = generatePolynomialBasisFromMonomialDecomposition(sCoeffs, ...
                                                                      sMonomialBasis, ...
                                                                       newParNameStr, ...
                                                                       constants, ...
                                                                       constantsValues, ...
                                                                       tolZero, ...
                                                                       tolRel)

%% SVD Check

sCoeffsReordered     = sym([]);

% Rearrange to coefficient matrix, where only columns are multiplied with a
% different basis monomial
nm = length(sMonomialBasis);
for ii = 1:nm
   sCoeffsReordered(:, ii) =  sCoeffs{ii}(:);
end
   CoeffsReordered = sym(sCoeffsReordered);
   CoeffsReordered = subs(CoeffsReordered, constants, constantsValues);
   CoeffsReordered = double(CoeffsReordered);

   
[U, Sigma, V] = svd(CoeffsReordered); %NU*NS*NV'
V_Temp = V;
U_Temp = U;
V_Temp(abs(V_Temp) < tolZero) = 0;
U_Temp(abs(U_Temp) < tolZero) = 0;
V = V_Temp;
U = U_Temp;

errors{1} = max(max(abs(U_Temp*Sigma*V_Temp' - U*Sigma*V')));

sigma = diag(Sigma)/max(diag(Sigma));

nm_new_max = min(size(V', 1), numel(sigma));

for nm_new = 1:nm_new_max

V_Reduced = V';
V_Reduced = V_Reduced(1:nm_new, :);
V_Reduced(abs(V_Reduced) < tolZero) = 0;
U_Reduced = U;
U_Reduced = U_Reduced(:, 1:nm_new);
U_Reduced(abs(U_Reduced) < tolZero) = 0;
Sigma_Reduced = Sigma(1:nm_new, 1:nm_new);
sPolynomialBasis = vpa(V_Reduced*sMonomialBasis, 10);
PolyNomialBasisCoeffs = V_Reduced;

errors{2}(nm_new) = max(max(abs(U_Reduced*Sigma_Reduced*V_Reduced - U*Sigma*V')));
end

if ~isempty(sigma)
    nm_new = sum(sigma > sigma(1)*tolRel);
%     plot(sigma)
else
    nm_new = 0;
end

% Generate new parameter vector masking the polynomials in the original
% ones
[svec] = generateParameterVector(newParNameStr, nm_new);

V_Reduced = V';
V_Reduced = V_Reduced(1:nm_new, :);
V_Reduced(abs(V_Reduced) < tolZero) = 0;
U_Reduced = U;
U_Reduced = U_Reduced(:, 1:nm_new);
U_Reduced(abs(U_Reduced) < tolZero) = 0;
Sigma_Reduced = Sigma(1:nm_new, 1:nm_new);
sPolynomialBasis = vpa(V_Reduced*sMonomialBasis, 10);
PolyNomialBasisCoeffs = V_Reduced;

CoeffsReduced   = U_Reduced*Sigma_Reduced;
sCoeffsReduced  = U_Temp'*sCoeffsReordered*V_Temp;
sCoeffsReduced  = sCoeffsReduced(1:nm_new, 1:nm_new);

sCoeffsReduced  = U_Reduced*sCoeffsReduced;

%%
n1 = 0;
n2 = 0;
if ~isempty(sCoeffs)
    [n1, n2] = size(sCoeffs{1});
end


CoeffsOfThetaCoeffs   = {};
sCoeffsOfThetaCoeffs  = {};
CoeffsOfTheta  = O(n1, n2);
sCoeffsOfTheta = sym(O(n1, n2));
for ii = 1:nm_new
     sCoeffsOfThetaCoeffs{ii} =  reshape(sCoeffsReduced(:, ii), n1, []);
     sCoeffsOfThetaCoeffs{ii} = cleanUpPolynomialSymMat(sCoeffsOfThetaCoeffs{ii}, tolZero);
      CoeffsOfThetaCoeffs{ii} =  reshape( CoeffsReduced(:, ii), n1, []);
      CoeffsOfTheta           =  CoeffsOfTheta +  CoeffsOfThetaCoeffs{ii}*svec(ii);
     sCoeffsOfTheta           = sCoeffsOfTheta + sCoeffsOfThetaCoeffs{ii}*svec(ii);
end

sPolynomialCoeffs      = sCoeffsOfThetaCoeffs;
 PolynomialCoeffs      =  CoeffsOfThetaCoeffs;
sCoeffsOfNewParameters = sCoeffsOfTheta;
 CoeffsOfNewParameters =  CoeffsOfTheta;
sNewParameter          = svec;