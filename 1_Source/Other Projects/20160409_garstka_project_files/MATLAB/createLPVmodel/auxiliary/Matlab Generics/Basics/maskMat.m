function maskedMat = maskMat(mat, maskMat)

%% Normalize to indices from 1, ..., maxIndex
maskMatLin = maskMat(:);
maxIndex = max(maskMatLin);
minIndex = min(maskMatLin(maskMatLin >= 0));

maskMat(maskMat ~= 0) = maskMat(maskMat ~= 0) - (minIndex - 1)*ones(size(maskMat(maskMat ~= 0)));

maxIndex = maxIndex - (minIndex - 1);
minIndex = 1;

%%
maskedMat = mat;

boolMat = maskMat > 0;

maskedMat(boolMat == 0) = 0;

for ii = 1:maxIndex
    equalsIndex = find(maskMat == ii);
    if ~isempty(equalsIndex)
        maskedMat(equalsIndex) = maskedMat(equalsIndex(1));
    end
end


