function uMclean = cleanUpLFR(uM, tol);
%%

    [M, uDelta, Blkstruct, Normunc] = lftdata(uM);

    M(abs(M) < tol) = 0;
    
    uMclean = lft(uDelta, M);
    uMclean = simplify(uMclean, 'full');