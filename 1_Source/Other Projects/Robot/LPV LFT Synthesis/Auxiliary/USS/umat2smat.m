function sM = umat2smat(uM);
%%

if strcmp(class(uM), 'umat')
    
    [M, uDelta, Blkstruct, Normunc] = lftdata(uM);

    sDelta = umatDelta2smatDelta(uDelta);

    ParameterNames      = {Blkstruct.Name};
    ParameterBlockSizes = {Blkstruct.Occurrences};
    ParameterBlockSize  = sum(cell2mat(ParameterBlockSizes));
    ParameterCount      = size(ParameterNames, 2);

    M11 = M((                   1):(ParameterBlockSize), (                   1):(ParameterBlockSize));
    M12 = M((                   1):(ParameterBlockSize), (ParameterBlockSize+1):(end)               );
    M21 = M((ParameterBlockSize+1):(end)               , (                   1):(ParameterBlockSize));
    M22 = M((ParameterBlockSize+1):(end)               , (ParameterBlockSize+1):(end)               );

    if (M11 == O(size(M11)))
        sM  = M22 + M21 * sDelta * M12;
    else
        sM  = M22 + M21 * sDelta/( I(ParameterBlockSize) - sDelta*M11 ) * M12;
    end
    
else
    
    sM  = uM;
    
end