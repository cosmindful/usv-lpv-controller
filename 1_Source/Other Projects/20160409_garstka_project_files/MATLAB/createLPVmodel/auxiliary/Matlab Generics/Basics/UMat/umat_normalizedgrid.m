function DELTAsubsGrid = umat_normalizedgrid(uDELTA, ngrid)
% -------------------------------------------------------------------------
% function : umat_normalizedgrid
% -------------------------------------------------------------------------
% Author   : Christian Hoffmann
% Version  : August, 5th 2013
% Copyright: 2013
% -------------------------------------------------------------------------
% Syntax   : DELTAsubs = umat_normalizedgrid(uDELTA, ngrid)
% -------------------------------------------------------------------------
% Function to substitute a vector of values for uncertain parameters.
% The vector entries have to correspond to the uncertain parameters in
% terms of the order.
% 
% The parameters are automatically scaled and only substitution vectors
% within [-1, 1] are accepted.
%

for ii = 1:numel(ngrid)
    usubsDeltaVals{ii} = linspace(-1, 1, ngrid(ii));
end

usubsDeltaVector = usubsDeltaVals{1};
for ii = 2:numel(ngrid)
    usubsDeltaVector = combvec(usubsDeltaVector, usubsDeltaVals{ii});
end

fprintf('Generating %d grid points for multiplier conditions with FBM.\n', size(usubsDeltaVector, 2));
    
mm = 0;
for ii = 1:size(usubsDeltaVector, 2)
    DELTAsubsGrid{ii} = umat_normalizedsubs(uDELTA, usubsDeltaVector(:, ii));
    
    mm = mm + 1;
    if mm > 100
        fprintf('.');
        mm = 0;
    end
end
fprintf('\n');
    