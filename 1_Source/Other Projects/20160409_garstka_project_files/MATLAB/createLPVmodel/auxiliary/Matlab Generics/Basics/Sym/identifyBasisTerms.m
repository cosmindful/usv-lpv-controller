function [groupedToOrderedIndices, orderedToGroupedIndices] = identifyBasisTerms(sGroupedBasis, sOrderedBasis)

nTerms = numel(sOrderedBasis);

if ~isempty(sGroupedBasis) && ~isempty(sOrderedBasis)
    for ii = 1:nTerms
        ind = find(sGroupedBasis == sOrderedBasis(ii));
        if isempty(ind)
            ind = nan;
        end
        groupedToOrderedIndices(ii) = ind;
    end

    groupedToOrderedIndices = groupedToOrderedIndices(~isnan(groupedToOrderedIndices));

    nTerms = numel(sGroupedBasis);

    for ii = 1:nTerms
        ind = find(sOrderedBasis == sGroupedBasis(ii));
        if isempty(ind)
            ind = nan;
        end
        orderedToGroupedIndices(ii) = ind;
    end

    orderedToGroupedIndices = orderedToGroupedIndices(~isnan(orderedToGroupedIndices));
else
    orderedToGroupedIndices = [];
    groupedToOrderedIndices = [];
end