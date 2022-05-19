function Q = model_lftmultiplication(M, N)
% -------------------------------------------------------------------------
% function : model_lftmultiplication
% -------------------------------------------------------------------------
% Author   : Christian Hoffmann
% Version  : March, 6th 2014
% Copyright: 2014
% -------------------------------------------------------------------------
% Syntax   : [Q] = model_lftmultiplication(M, N);
% 
% Takes constant parts of two upper LFTs and produces the constant part of
% the multiplication of the upper LFTs, s.t.
%
% ULFT(diag(DeltaM, DeltaN), Q)   = ULFT(DeltaM, M) * ULFT(DeltaN, N)
%
% Enter M, N as structures
% M.M11, M.M12, M.M21, M.M22
% N.M11, N.M12, N.M21, N.M22
% 
% Returns
% Q.M11, Q.M12, Q.M21, Q.M22
% -------------------------------------------------------------------------

M11 = M.M11;
M12 = M.M12;
M21 = M.M21;
M22 = M.M22;

N11 = N.M11;
N12 = N.M12;
N21 = N.M21;
N22 = N.M22;

    nM11  = size(M11, 2);
    nN11  = size(N11, 1);

    Q.M11 = [ M11             M12*N21 ;...
              O(nN11, nM11)   N11     ];
    Q.M12 = [ M12*N22                 ;...
              N12                     ];
    Q.M21 = [ M21             M22*N21 ];
    Q.M22 = [ M22*N22                 ];