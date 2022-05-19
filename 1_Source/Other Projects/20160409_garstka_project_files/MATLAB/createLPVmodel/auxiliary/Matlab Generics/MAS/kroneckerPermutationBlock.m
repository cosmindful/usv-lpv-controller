%% Permutation Matrix for Kronecker Products
% For a matrix
%
%       Md = [ kron(IN, M11), ... , kron(IN, M1q) ]
%            [         :                    :     ]
%            [ kron(IN, Mp1), ... , kron(IN, Mpq) ]
%
% obtain a permutation, such that
% 
%       PsiP * Md * PsiQ = kron(IN, M)
% 
% where
% 
%        M = [ M11, ... , M1q ]
%            [   :          : ]
%            [ Mp1, ... , Mpq ]
% 
% 
% Syntax:
% [PsiP, PsiQ] = kroneckerPermutationBlock(p, q, N)
% 
% with
%   p = [ p1, p2, ..., pp ] is the vector of row    sizes for each Mij
%   q = [ q1, q2, ..., qq ] is the vector of column sizes for each Mij
%   N                       is the size of the arbitrary N x N matrix IN

function [PsiP, PsiQ] = kroneckerPermutationBlock(p, q, N);

nump = length(p);
numq = length(q);


Stamp_p = cell(nump, numq);
Stamp_q = cell(numq, nump);

for m = 1:nump
    for n = 1:nump
       Stamp_p{n, m} = (m == n)*eye(p(n), p(m));
    end
end

for m = 1:numq
    for n = 1:numq
       Stamp_q{n, m} = (m == n)*eye(q(n), q(m));
    end
end

Psi_p = cell(1, N);
Psi_q = cell(1, N);
% for m = 1:numq
%     Psi_p = mdiag(Psi_p, vertcat(Stamp_p{:, m}));
%     Psi_q = mdiag(Psi_q, vertcat(Stamp_q{:, m}));
% end
for m = 1:numq
    for k = 1:N
        Psi_p{m} = mdiag(Psi_p{m}, vertcat(Stamp_p{:, m}));
        Psi_q{m} = mdiag(Psi_q{m}, vertcat(Stamp_q{:, m}));
    end
end

PsiP = horzcat(Psi_p{:});
PsiQ = horzcat(Psi_q{:})';