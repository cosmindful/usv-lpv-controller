function eyeMat = I(n1, n2)

if nargin == 1
    eyeMat = eye(n1);
else
    eyeMat = eye(n1, n2);
end