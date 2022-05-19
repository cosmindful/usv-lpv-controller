function [ParameterListWODuplicates] = removeDuplicateSymVars(ParameterList)

    ParameterListWODuplicates = sort(ParameterList);
    ii = 1;
    while ii < length(ParameterListWODuplicates)
        if ParameterListWODuplicates(ii) == ParameterListWODuplicates(ii+1)
            ParameterListWODuplicates(ii+1) = [];
        else
        ii = ii + 1;
        end
    end