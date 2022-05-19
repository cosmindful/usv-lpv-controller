function [dMdq, remainder, sparsity, Perms, PermsNumeric] = lpv_iterativeQuoRem(M, q, boolPerms)

if boolPerms
     PermsNumeric = perms(length(q):-1:1);
     Perms        = q(PermsNumeric);
    numPerms = length(Perms);
    for kk = 1:numPerms
        currq    = Perms(kk, :);
        [dMdq{kk}, remainder{kk}, sparsity{kk}] = iterativeQuoRem(M, currq);
        dMdq{kk} = dMdq{kk}(PermsNumeric(kk, :)); % Reorder as in q
    end
else
    Perms = [];
    [dMdq, remainder, sparsity] = iterativeQuoRem(M, q);
end



function [dMdq, remainder, sparsity] = iterativeQuoRem(M, q)

numVars = length(q);
iterativeQuoRem = M;
for ii = 1:numVars
    dMdqQuotient = quorem(iterativeQuoRem, q(ii), q(ii));
    dMdq(:, ii)  = dMdqQuotient;
    iterativeQuoRem = simple(iterativeQuoRem - dMdq(:, ii)*q(ii));
end
remainder = iterativeQuoRem;
sparsity  = ~(dMdq == 0);