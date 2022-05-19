%% Collect Coefficient Matrices from a Specified Monomial Basis

%% TAKE CARE THAT THE MONOMIAL BASIS IS WRITTEN IN INCREASING DEGREES
%% AND LEXICOGRAPHIC ORDER!

function [Mcoeffs, M0] = collectUnivariateCoeffs(sM, sparams, maxDegree)

% M = collect(M, monomialBasis);
sM = expand(sM);

% Doesn't work if symbolic parameters are involved
% maxDegree = checkPolynomialMaxDegree(sM);

for ii = 1:maxDegree
    % Generate the respective bases with increasing exponents
    sparams_degrees{ii} = sparams.^ii;
end

Msubs   = sM;
Mcoeffs = {};
nparams = length(sparams);
M0 = subs(Msubs, sparams, O(nparams, 1));
Msubs   = Msubs - M0;
for ii = maxDegree:-1:1
    Mcoeffs{ii}     = Msubs;
    % Mask parameters, lest the jacobian is not partial to the bases with 
    % the correct exponent
    sparams_temp    = generateParameterVector('stemp', nparams);
    Mcoeffs{ii}     = subs(Mcoeffs{ii}, sparams_degrees{ii}, sparams_temp);
    Mcoeffs{ii}     = jacobian(Mcoeffs{ii}, sparams_temp);
    Msubs           = simple(Msubs - Mcoeffs{ii}*sparams_degrees{ii});
    if ii > 1
        Mcoeffs{ii}     = expand(Mcoeffs{ii}.*(ones(size(Mcoeffs{ii},1), 1)*sparams_degrees{ii-1}'));
    else
        Mcoeffs{ii}     = expand(Mcoeffs{ii});
    end
end

%% Check which monomials exist and reduce the basis to it
McoeffsReduced        = {};
sparams_reduced  = [];
% for ii = 1:nparams
%     if isequal(Mcoeffs{ii}, O(size(Mcoeffs{ii})))
%     else
%     McoeffsReduced{end+1} = Mcoeffs{ii};
%     sparams_reduced  = [sparams_reduced; sparams(ii)];
%     end
% end

% Mcoeffs = McoeffsReduced;