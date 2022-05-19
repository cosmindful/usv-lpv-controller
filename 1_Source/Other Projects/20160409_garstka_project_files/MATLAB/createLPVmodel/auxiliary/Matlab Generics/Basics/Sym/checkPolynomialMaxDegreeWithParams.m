function maxDegree = checkPolynomialMaxDegreeWithParams(sPolynomial, b, bval)

sPolynomial = subs(sPolynomial, b, bval);

[sN, sD] = numden(vpa(sPolynomial,32));

try sD = double(sD);
    catch
        error('Not a polynomial, maybe rational!');
end

sN = sN./sD;
%  
% if abs(sum(sum(sD)) - numel(sD)) < 1e-18
% else
%     error('Denominator contains values... take care.');
% end

  params = symvar(sPolynomial);
n_params = length(params);

maxDegree = 1;

syms dummysym real
sPolynomialUnified = subs(sPolynomial, params, dummysym*ones(size(params)));
% for ii = 1:n_params
    jj = 1;
    while ~isequal(diff(sPolynomialUnified, dummysym, jj), O(size(sPolynomial)))
        if jj > maxDegree 
            maxDegree = jj;
        end
        jj = jj + 1;
    end
% end