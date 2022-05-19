function memoryReq = countMemoryReq(symbolicExpression)

symvars = symvar(symbolicExpression);
numsymvars = numel(symvars);

try
    csymbolicExpression         = char(vpa(horner(symbolicExpression),2));
    if strcmp(csymbolicExpression, 'FAIL')
        csymbolicExpression         = char(vpa(symbolicExpression,2));
    end
catch
    csymbolicExpression         = char(vpa(symbolicExpression,2));
end

countsymvars = [];
for ii = 1:numsymvars
    countsymvars(ii) = numel(regexp(csymbolicExpression, char(symvars(ii)), 'match'));
end

numcountsymvars = sum(countsymvars);

numExponentials = numel(regexp(csymbolicExpression, 'e-', 'match'));
numMinus        = numel(regexp(csymbolicExpression, '-',  'match'));
numPlus         = numel(regexp(csymbolicExpression, '+',  'match'));
numTimes        = numel(regexp(csymbolicExpression, '*',  'match'));
numDiv          = numel(regexp(csymbolicExpression, '/',  'match'));
numPot          = numel(regexp(csymbolicExpression, '\^', 'match'));

try
    nonZeroEntries = numel(find(symbolicExpression));
catch 
    nonZeroEntries = 0;
end
    
    
memoryReq = numMinus + numPlus - numExponentials + nonZeroEntries;