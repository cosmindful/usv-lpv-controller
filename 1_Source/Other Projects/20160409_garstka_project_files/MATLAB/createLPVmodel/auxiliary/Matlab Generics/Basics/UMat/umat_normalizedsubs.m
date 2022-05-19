function DELTAsubs = umat_normalizedsubs(uDELTA, usubsDeltaVector)
% -------------------------------------------------------------------------
% function : umat_normalizedsubs
% -------------------------------------------------------------------------
% Author   : Christian Hoffmann
% Version  : August, 5th 2013
% Copyright: 2013
% -------------------------------------------------------------------------
% Syntax   : DELTAsubs = umat_subs(uDELTA, usubsDeltaVector)
% -------------------------------------------------------------------------
% Function to substitute a vector of values for uncertain parameters.
% The vector entries have to correspond to the uncertain parameters in
% terms of the order.
% 
% The parameters are automatically scaled and only substitution vectors
% within [-1, 1] are accepted.
%

     if (abs(usubsDeltaVector) > 1)
         error('Only normalized substitution vectors are allowed!');
     end
     
     
     deltaNames = fieldnames(uDELTA.Uncertainty);
     numDeltas  = length(deltaNames);

     for ii = 1:numDeltas
            minmax = uDELTA.Uncertainty.(deltaNames{ii}).Range;
            min    = minmax(1);
               max = minmax(2);
             range = max - min;
               mid = (max + min)/2;
        subsStruct.(deltaNames{ii}) = usubsDeltaVector(ii)*range/2 + mid;
     end
     
     DELTAsubs = usubs(uDELTA, subsStruct);