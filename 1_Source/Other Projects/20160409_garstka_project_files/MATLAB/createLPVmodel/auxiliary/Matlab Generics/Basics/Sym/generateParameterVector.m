function [svec] = generateParameterVector(namestr, npars)

svec = sym([]);
if npars < 100
    ndigits = 2;
elseif npars < 1000
    ndigits = 3;
else
    ndigits = 4;
end
    
svec = sym(O(npars, 1));
for ii = 1:npars
    eval(['syms ', namestr, num2strChars(ii, ndigits), ' real;']);
    eval(['svec(ii, 1) = ', namestr, num2strChars(ii, ndigits),';']);
end