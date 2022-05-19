function [param1Ofparam2_grid, param2_grid] = generateGridByPriorGrid(sparam1Ofparam2, sparam2, param2_grid, sparam1Ofparam2_sinc, param2_sincIndices)
%%
ngrid = size(param2_grid, 2);
fprintf('Checking %d gridpoints.\n', ngrid);

% Take care of sinc, etc...
if nargin > 3
    nparam2_sinc = length(sparam1Ofparam2_sinc);
    ssc = generateParameterVector('ssc', nparam2_sinc);
    sparam1Ofparam2_sinc = subs(sparam1Ofparam2, sparam1Ofparam2_sinc, ssc);
end

param1Ofparam2_grid = {};
kk = 0;
for ii = 1:ngrid
    if (kk < floor(ii/100))
        kk = kk + 1;
        fprintf('.');
    end
    try
        param1Ofparam2_grid{ii} = double(subs(sparam1Ofparam2, sparam2, param2_grid(:, ii)));
    catch
        param1Ofparam2_gridtemp = subs(sparam1Ofparam2_sinc, sparam2, param2_grid(:, ii));
        param1Ofparam2_grid{ii} = double(subs(param1Ofparam2_gridtemp, ssc, sinc(param2_grid(param2_sincIndices, ii)/pi)));
    end
end
fprintf('\n');