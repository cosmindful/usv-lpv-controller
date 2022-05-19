function cleanCell = cleanUpCell(cell, tol)

cleanCell = cellfun(@(M) double(M)         ,      cell, 'UniformOutput', false);
cleanCell = cellfun(@(M) cleanUpMat(M, tol), cleanCell, 'UniformOutput', false);