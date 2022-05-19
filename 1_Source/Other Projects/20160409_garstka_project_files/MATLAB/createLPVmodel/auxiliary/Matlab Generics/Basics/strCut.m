function string = strCut(argString, argPreString, argPostString, argPreCatString, argPostCatString)

string     = argString( (length(argPreString)+1):(length(argString)-length(argPostString)) );

if nargin > 3
    string     = strcat(argPreCatString, string);
end

if nargin > 4
    string     = strcat(string, argPostCatString);
end