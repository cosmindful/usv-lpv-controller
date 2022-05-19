function C = normCrix(A)

[n, m] = size(A);

for ii = 1:n-1
    A(ii+1, :) = A(ii+1, :) +  A(ii, :);
end

B = sum(A, 1);

C = sum(B, 2);
