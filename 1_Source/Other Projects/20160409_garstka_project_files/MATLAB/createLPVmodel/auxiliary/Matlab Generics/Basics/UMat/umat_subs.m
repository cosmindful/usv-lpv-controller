function DELTAsubs = umat_subs(uDELTA, usubsDeltaVector)
% -------------------------------------------------------------------------
% function : umat_subs
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
     
     deltaNames = fieldnames(uDELTA.Uncertainty);
     numDeltas  = length(deltaNames);

     for ii = 1:numDeltas
        subsStruct.(deltaNames{ii}) = usubsDeltaVector(ii);
     end
     
%      uDELTA  = cleanUpLFR(uDELTA, eps);
     DELTAsubs = usubs(uDELTA, subsStruct);
     