function [Pmn] = perfectShuffle(m, n);
% Computes the perfect shuffle permutation Pmn
%
% Pmn = [ Imn( 1:n:mn, :) 
%         Imn( 2:n:mn, :)
%              :     
%         Imn( n:n:mn, :) ]
%
%
I = eye(m*n);

Pmn = [];
for i = 1:n
    Pmn = [Pmn; I(i:n:(m*n), :)];
end