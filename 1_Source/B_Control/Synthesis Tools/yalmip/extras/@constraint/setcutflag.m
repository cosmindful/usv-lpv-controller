function X = setcutflag(X,flag)
%setcutlag Internal : defines a SET object as a CUT
%
% Author Johan L?fberg
if nargin == 1
    flag = 1;
end
for i = 1:length(X.clauses)
    X.clauses{i}.cut = flag;
end