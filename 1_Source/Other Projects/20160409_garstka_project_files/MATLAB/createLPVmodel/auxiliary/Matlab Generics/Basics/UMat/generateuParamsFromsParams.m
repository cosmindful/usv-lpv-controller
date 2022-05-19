function [uParams, sParamNames, uParamNames] = generateuParamsFromsParams(sParams, sParamBounds, sParamNominal, bool_dontAutoSimplify)
uParams     = umat([]);
sParamNames = [];
uParamNames = [];

if size(sParams, 2) ~= numel(sParams)
    if size(sParams, 1) ~= numel(sParams)
        error('Function is supposed to work with vectors, not matrices.');
    end
end

     params = symvar(sParams);
    nparams = length(params);
    
if nargin < 2
    sParamBounds  = kron([-1, 1], ones(nparams, 1));
    sParamNominal = O(nparams, 1);
end
    
    counter = 0;
    for ii = 1:nparams
        sParamNames{ii} = char(params(ii));
        if sParamNames{ii}(1) == 's';
            % Purpose: check if all params begin with an 's'
            counter = counter + 1;
        end
    end
    subsStringOffset = 0;
    if counter == nparams
        subsStringOffset = 1;
    end
    for ii = 1:nparams
        uParamNames{ii} = ['u', sParamNames{ii}((1+subsStringOffset):(end))];
    end
    
    for ii = 1:nparams
        if nargin > 3 & bool_dontAutoSimplify
            appendStr = [',', char(39), 'AutoSimplify', char(39), ',', char(39), 'off', char(39)];
        else
            appendStr = [''];
        end
        eval([uParamNames{ii}, ' = ureal(', char(39), uParamNames{ii}, char(39), ',', num2str(sParamNominal(ii)), ',', char(39), 'Range', char(39), ',', mat2str(sParamBounds(ii, :)), appendStr, ');']);
        eval(['uParams(', num2str(ii), ') = ', uParamNames{ii}, ';']);
    end
        