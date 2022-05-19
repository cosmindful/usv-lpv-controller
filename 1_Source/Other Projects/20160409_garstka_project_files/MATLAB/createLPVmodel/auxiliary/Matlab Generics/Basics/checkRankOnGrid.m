function [param_grid, rank_grid, sparam] = checkRankOnGrid(sMatOfparam, sparam, param_bnd, param_ngrid, param_special, sparam1Ofparam2_sinc, param2_sincIndices)
%%
% param2_sincIndices: Of which rhos do there exist sinc functions
% corresponding in the order of sparam1Ofparam2_sinc

[C, ia, ib]       = intersect(symvar(sMatOfparam), sparam);
sparam           = sparam(ib);
 param_bnd       = param_bnd(ib, :);
 param_ngrid     = param_ngrid(ib, :);
 param_special   = param_special(ib, :);

nparams = size(param_bnd, 1);

for ii = 1:nparams
    gridvector{ii} = linspace(param_bnd(ii, 1), param_bnd(ii, 2), param_ngrid(ii));
    % Append special operating points for combinations if specified
    if nargin > 4
        gridvector{ii} = unique([gridvector{ii}, param_special(ii, :)]);
    end
end
param_grid = gridvector{1};

for ii = 1:nparams-1
    param_grid = combvec(param_grid, gridvector{ii+1});
end

% % Append special operating points if specified
% if nargin > 4
%     param2_grid = [param2_grid, param2_special];
% end

% Take care of sinc, etc...
if nargin > 5
    nparam2_sinc = length(sparam1Ofparam2_sinc);
    ssc = generateParameterVector('ssc', nparam2_sinc);
    sMatOfparam_sinc = subs(sMatOfparam, sparam1Ofparam2_sinc, ssc);
end

param1Ofparam2_grid = O(size(sMatOfparam, 1), size(param_grid, 2));
param1Ofparam2_bnd  = O(size(sMatOfparam, 1), 2)*nan;
for ii = 1:size(param_grid, 2)
    try
        param1Ofparam2_grid = double(subs(sMatOfparam, sparam, param_grid(:, ii)));
    catch
        param1Ofparam2_grid = subs(sMatOfparam_sinc, sparam, param_grid(:, ii));
        param1Ofparam2_grid = double(subs(param1Ofparam2_grid, ssc, sinc(param_grid(param2_sincIndices, ii)/pi)));
    end
    rank_grid(ii)  = rank(param1Ofparam2_grid);
end