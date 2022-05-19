function arithOps = countArithOps(symbolicExpression)


try
    csymbolicExpression         = char(vpa(horner(symbolicExpression),2));
    if strcmp(csymbolicExpression, 'FAIL')
        csymbolicExpression         = char(vpa(symbolicExpression,2));
    end
catch
    csymbolicExpression         = char(vpa(symbolicExpression,2));
end
% csymbolicExpression         = char(vpa(simple(symbolicExpression),2));

numExponentials = numel(regexp(csymbolicExpression, 'e-', 'match'));
numMinus        = numel(regexp(csymbolicExpression, '-',  'match'));
numPlus         = numel(regexp(csymbolicExpression, '+',  'match'));
numTimes        = numel(regexp(csymbolicExpression, '*',  'match'));
numDiv          = numel(regexp(csymbolicExpression, '/',  'match'));
numPot          = numel(regexp(csymbolicExpression, '\^', 'match'));

arithOps = numMinus + numPlus + numTimes + numDiv + numPot - numExponentials;