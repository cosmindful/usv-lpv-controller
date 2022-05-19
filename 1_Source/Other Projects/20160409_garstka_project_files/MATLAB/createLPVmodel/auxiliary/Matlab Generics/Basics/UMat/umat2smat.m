function sM = umat2smat(uM, tol);
%%

if strcmp(class(uM), 'umat')

    uMclean = cleanUpLFR(uM, tol);
    
    [M, uDelta, Blkstruct, Normunc] = lftdata(uMclean);

    sDelta = umatDelta2smatDelta(uDelta);

    ParameterNames      = {Blkstruct.Name};
    ParameterBlockSizes = {Blkstruct.Occurrences};
    ParameterBlockSize  = sum(cell2mat(ParameterBlockSizes));
    ParameterCount      = size(ParameterNames, 2);

    M11 = M((                   1):(ParameterBlockSize), (                   1):(ParameterBlockSize));
    M12 = M((                   1):(ParameterBlockSize), (ParameterBlockSize+1):(end)               );
    M21 = M((ParameterBlockSize+1):(end)               , (                   1):(ParameterBlockSize));
    M22 = M((ParameterBlockSize+1):(end)               , (ParameterBlockSize+1):(end)               );
    
%     M11(abs(M11) < tol) = 0;
%     M12(abs(M12) < tol) = 0;
%     M21(abs(M21) < tol) = 0;
%     M22(abs(M22) < tol) = 0;

    if (M11 == O(size(M11)))
        sM  = M22 + M21 * sDelta * M12;
    else
        sM  = M22 + M21 * sDelta/( I(ParameterBlockSize) - M11*sDelta) * M12;
    end
    
else
    
    sM  = uM;
    
end