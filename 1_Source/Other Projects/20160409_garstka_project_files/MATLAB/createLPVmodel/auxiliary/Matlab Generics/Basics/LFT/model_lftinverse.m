function Q = model_lftinverse(M)
% -------------------------------------------------------------------------
% function : model_lftinverse
% -------------------------------------------------------------------------
% Author   : Christian Hoffmann
% Version  : October, 15th 2014
% Copyright: 2014
% -------------------------------------------------------------------------
% Syntax   : [Q] = model_lftinverse(M);
% 
% Returns inverse of an LFT
%
% ULFT(diag(DeltaM), Q)   = (ULFT(DeltaM, M))^-1
%
% Enter M as structure
% M.M11, M.M12, M.M21, M.M22
% 
% Returns
% Q.M11, Q.M12, Q.M21, Q.M22
% -------------------------------------------------------------------------

M11 = M.M11;
M12 = M.M12;
M21 = M.M21;
M22 = M.M22;

    Q.M11 = [  M11-M12*M22^-1*M21 ];
    Q.M12 = [     -M12*M22^-1     ];
    Q.M21 = [          M22^-1*M21 ];
    Q.M22 = [          M22^-1     ];