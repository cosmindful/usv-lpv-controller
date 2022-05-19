function SS = ss_nameStates(argSS, argRange, argInputName)

SS     = argSS;
length = numel(argRange);
numStrLength = 2;
SS.StateName(argRange) = strcat( repmat({argInputName}, 1, length), cellfun(@(x) num2strChars(x, numStrLength), mat2cell(1:length, 1, ones(1, length)), 'UniformOutput', 0));