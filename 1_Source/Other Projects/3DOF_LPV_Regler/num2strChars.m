function [NumString] = num2strChars(i, chars)

    if length(num2str(i)) > chars
       error('num2stringChars takes only numbers with less than "chars" characters!');
    end

    NumString = num2str(i);
   
    numChars  = chars - length(NumString);
    
    for curChar = 1:numChars
        NumString = ['0', NumString];
    end