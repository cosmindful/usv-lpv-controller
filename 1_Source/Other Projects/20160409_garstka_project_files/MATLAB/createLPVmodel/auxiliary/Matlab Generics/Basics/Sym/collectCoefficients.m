%% Collect Coefficient Matrices from a Specified Monomial Basis

%% TAKE CARE THAT THE MONOMIAL BASIS IS WRITTEN IN INCREASING DEGREES
%% AND LEXICOGRAPHIC ORDER!

function [Mcoeffs, M0] = collectCoefficients(M, monomialBasis)

% M = collect(M, monomialBasis);
M = expand(M);

Msubs   = M;
Mcoeffs = {};
ntheta  = length(monomialBasis);
M0 = subs(Msubs, monomialBasis, O(ntheta, 1));
Msubs   = Msubs - M0;

MonomialsEnum = generateParameterVector('m', ntheta);
MsubsEnum     = subs(Msubs, monomialBasis(end:-1:1), MonomialsEnum(end:-1:1));

for ii = 1:ntheta
    curInd              = ntheta+1-ii;
    selector            = O(ntheta, 1);
    selector(curInd)    = 1;
    Mcoeffs{curInd}     = MsubsEnum;
    for kk = ntheta:-1:1
        Mcoeffs{curInd} = subs(Mcoeffs{curInd}, MonomialsEnum(kk), selector(kk));
    end
%     MsubsEnum           = expand(simple(MsubsEnum - Mcoeffs{ntheta+1-ii}*MonomialsEnum(end+1-ii)));
    MsubsEnum           = expand(MsubsEnum - Mcoeffs{ntheta+1-ii}*MonomialsEnum(end+1-ii));
    fprintf(['Monomial: ', num2strChars(curInd, 3), '. ', num2strChars(numel(intersect(symvar(MsubsEnum), MonomialsEnum)), 3), ' left.\n']);
end

%% Check which monomials exist and reduce the basis to it
% McoeffsReduced        = {};
% reducedMonomialBasis  = [];
% for ii = 1:ntheta
%     if isequal(Mcoeffs{ii}, O(size(Mcoeffs{ii})))
%     else
%     McoeffsReduced{end+1} = Mcoeffs{ii};
%     reducedMonomialBasis  = [reducedMonomialBasis; monomialBasis(ii)];
%     end
% end

% Mcoeffs = McoeffsReduced;