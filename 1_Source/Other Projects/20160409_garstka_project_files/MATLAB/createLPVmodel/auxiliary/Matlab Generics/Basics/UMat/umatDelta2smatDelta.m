function sDelta = umatDelta2smatDelta(uDelta);
%%

if strcmp(class(uDelta), 'umat')

    [M, Delta, Blkstruct, Normunc] = lftdata(uDelta);

    ParameterNames      = {Blkstruct.Name};
    ParameterBlockSizes = {Blkstruct.Occurrences};
    ParameterBlockSize  = sum(cell2mat(ParameterBlockSizes));
    ParameterCount      = size(ParameterNames, 2);

    sDelta = [];
    for ii = 1:ParameterCount
        s{ii}     = sym(ParameterNames{ii} ,'real');
        sDelta    = mdiag(sDelta, I(ParameterBlockSizes{ii})*s{ii});
    end

else
    
    sDelta = uDelta;
    
end