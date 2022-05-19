function M_evalgrid = lftOnGrid(Delta_grid, MLFR)

ngrid = numel(Delta_grid);
fprintf('Evaluating %d gridpoints.\n', ngrid);

kk = 0;
for ii = 1:ngrid
    if (kk < floor(ii/100))
        kk = kk + 1;
        fprintf('.');
    end
    M_evalgrid{ii} = lft(Delta_grid{ii}, MLFR);
end