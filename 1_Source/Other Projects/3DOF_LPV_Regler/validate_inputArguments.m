function [modelType] = validate_inputArguments(argPLFR)

% -------------------------------------------------------------------------
% function : validateInputArguments
% -------------------------------------------------------------------------
% Author   : Christian Hoffmann
% Version  : July, 16th 2013
% Copyright: 2013
% -------------------------------------------------------------------------
% Syntax   : [modelType] = validateInputArguments(argPLFR)
% 
% Check whether input argument is valid for LPV LFT synthesis.
% 
% -------------------------------------------------------------------------

modelType = class(argPLFR);

if     strcmp(modelType, 'uss')
elseif strcmp(modelType, 'struct')
    
else
    error(['Input variable PLFR must be of type USS or a structure with appropriate fields "Matrices", "Sizes", "DeltaBlock", ....']);
end