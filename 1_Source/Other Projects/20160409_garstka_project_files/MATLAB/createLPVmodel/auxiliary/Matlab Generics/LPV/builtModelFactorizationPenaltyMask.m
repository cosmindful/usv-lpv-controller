function PenaltyMask = builtModelFactorizationPenaltyMask(sCoeffs, rows)

% PenaltyMask = diag(ones(size(sCoeffs{1}, 2), 1));
PenaltyMask = O(size(sCoeffs{1}(rows, :)));
Pencil      = ones(size(sCoeffs{1}(rows, :)));

for ii = 1:numel(sCoeffs)
    PencilTemp = ones(size(sCoeffs{1}(rows, :)));
    PencilTemp(find(sCoeffs{ii}(rows, :) == 0)) = 0;
    PencilTemp = PencilTemp;
    PenaltyMask = PenaltyMask + Pencil.*PencilTemp;
end