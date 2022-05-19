function [sdpvarMask_LMILAB] = generateLMILABsdpvarMask(Lambda)

Lambda_LMILAB = sdpvar2str(Lambda);
Lambda_LMILAB = regexprep(Lambda_LMILAB, '(', '');
Lambda_LMILAB = regexprep(Lambda_LMILAB, ')', '');
Lambda_LMILAB = regexprep(Lambda_LMILAB, 'x', '');

ni = size(Lambda_LMILAB, 1);
nj = size(Lambda_LMILAB, 2);
sdpvarMask_LMILAB = O(ni,nj);
for ii = 1:ni
    for jj = 1:nj
        sdpvarMask_LMILAB(ii, jj) = str2num(Lambda_LMILAB{ii,jj});
    end
end