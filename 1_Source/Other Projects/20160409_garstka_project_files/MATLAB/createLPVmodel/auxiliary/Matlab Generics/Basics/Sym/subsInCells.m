function CoeffCells = subsInCells(sCoeffCells, sparam, paramval)

CoeffCells = cellfun(@(M) subs(M, sparam, paramval), sCoeffCells, 'UniformOutput', false);