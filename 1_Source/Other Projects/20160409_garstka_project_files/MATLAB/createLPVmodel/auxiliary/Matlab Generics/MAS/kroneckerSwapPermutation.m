function [Pm, Pn] = kroneckerSwapPermutation(m1, m2, n1, n2);
% Computes the perfect shuffle permutations, Pm, Pn, such that for
%
%   A in R(m1 x n1), B in R(m2 x n2)
%
% Pm*kron(A, B)*Pn' = kron(B, A)
%

Pm = perfectshuffle(m1, m2);
Pn = perfectshuffle(n1, n2);
