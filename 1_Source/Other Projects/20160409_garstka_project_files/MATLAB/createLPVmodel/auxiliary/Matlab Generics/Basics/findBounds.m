function [param1Ofparam2_bnd, param1Ofparam2_grid, param2_grid] = findBounds(sparam1Ofparam2, sparam2, param2_bnd, param2_ngrid, param2_special, sparam1Ofparam2_sinc, param2_sincIndices)
%%
% param2_sincIndices: Of which rhos do there exist sinc functions
% corresponding in the order of sparam1Ofparam2_sinc

[C, ia, ib]       = intersect(symvar(sparam1Ofparam2), sparam2);
sparam2           = sparam2(ib);
 param2_bnd       = param2_bnd(ib, :);
 param2_ngrid     = param2_ngrid(ib, :);
 param2_special   = param2_special(ib, :);

nparams = size(param2_bnd, 1);

gridvector = {O(0,0)};
for ii = 1:nparams
    gridvector{ii} = linspace(param2_bnd(ii, 1), param2_bnd(ii, 2), param2_ngrid(ii));
    % Append special operating points for combinations if specified
    if nargin > 4
        gridvector{ii} = unique([gridvector{ii}, param2_special(ii, :)]);
    end
end
param2_grid = gridvector{1};

for ii = 1:nparams-1
    param2_grid = combvec(param2_grid, gridvector{ii+1});
end
ngrid = size(param2_grid, 2);
fprintf('Checking %d gridpoints.\n', ngrid);

% % Append special operating points if specified
% if nargin > 4
%     param2_grid = [param2_grid, param2_special];
% end

% Take care of sinc, etc...
if nargin > 5
    nparam2_sinc = length(sparam1Ofparam2_sinc);
    ssc = generateParameterVector('ssc', nparam2_sinc);
    sparam1Ofparam2_sinc = subs(sparam1Ofparam2, sparam1Ofparam2_sinc, ssc);
end

param1Ofparam2_grid = O(size(sparam1Ofparam2, 1), size(param2_grid, 2));
param1Ofparam2_bnd  = O(size(sparam1Ofparam2, 1), 2)*nan;
kk = 0;
for ii = 1:ngrid
    if (kk < floor(ii/100))
        kk = kk + 1;
        fprintf('.');
    end
    try
        param1Ofparam2_grid(:, ii) = double(subs(sparam1Ofparam2, sparam2, param2_grid(:, ii)));
    catch
        param1Ofparam2_gridtemp = subs(sparam1Ofparam2_sinc, sparam2, param2_grid(:, ii));
        param1Ofparam2_grid(:, ii) = double(subs(param1Ofparam2_gridtemp, ssc, sinc(param2_grid(param2_sincIndices, ii)/pi)));
    end
    param1Ofparam2_bnd  = [min(param1Ofparam2_grid(:, ii), param1Ofparam2_bnd(:, 1)), max(param1Ofparam2_grid(:, ii), param1Ofparam2_bnd(:, 2))];
end
fprintf('\n');