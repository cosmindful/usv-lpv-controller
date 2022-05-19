function [minPenalty, minPenaltyFieldIndices, maxPenalty, maxPenaltyFieldIndices, penalties, fieldIndices, coeffOrder] = buildModelPenalizedTree(sCoeffsMultivariate_qd_TREE, PenaltyMask0, rows)

numCoeffs = numel(sCoeffsMultivariate_qd_TREE);

   coeffOrder  = []; %perms(1:numCoeffs);
% numCoeffOrders = size(coeffOrder, 1);

for ii = 1:numCoeffs
    sCurrentCoeffs = sCoeffsMultivariate_qd_TREE{ii};
    
    currentCoeffsFields        = fieldnames(sCurrentCoeffs);
    numCurrentCoeffsFields(ii) = numel(currentCoeffsFields);
end


fieldIndices = 1:numCurrentCoeffsFields(1);
if numCoeffs > 1
    for ii = 2:numCoeffs
        fieldIndices = combvec(fieldIndices, 1:numCurrentCoeffsFields(ii));
    end
end

numCombinations = size(fieldIndices, 2);

% for ii = 1:numCombinations
%     penalties(ii) = buildModelComputePenalty(sCoeffsMultivariate_qd_TREE, fieldIndices(:,ii), PenaltyMask);
% end


% Run through all combinations
for jj = 1:numCombinations
    PenaltyMaskNew = PenaltyMask0;
        % Run through all coefficients
        for kk = 1:numCoeffs
            coeffNum   = kk; %coeffOrder(ii, kk);
            fieldIndex = fieldIndices(coeffNum, jj);
            % Calculate the updated penalty mask after choosing a
            % particular fieldIndex for a coefficient
            [coeffPenalty(kk), PenaltyMaskNew] = buildModelComputePenaltyIterative(sCoeffsMultivariate_qd_TREE, fieldIndex, coeffNum, PenaltyMaskNew, rows);
        end
        
        penalties(jj) = sum(coeffPenalty);
end


    
[minPenalty, minPenaltyIndex] = min(penalties);
minPenaltyFieldIndices  = fieldIndices(:, minPenaltyIndex);

[maxPenalty, maxPenaltyIndex] = max(penalties);
maxPenaltyFieldIndices  = fieldIndices(:, maxPenaltyIndex);

        