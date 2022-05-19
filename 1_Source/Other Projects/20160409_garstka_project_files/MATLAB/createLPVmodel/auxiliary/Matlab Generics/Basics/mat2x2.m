function [M11, M12, M21, M22] = mat2x2(M, varargin);
% -------------------------------------------------------------------------
% function : mat2x2
% -------------------------------------------------------------------------
% Author   : Christian Hoffmann
% Version  : July, 18th 2013
% Copyright: 2013
% -------------------------------------------------------------------------
% Syntax   : [M11, M12, M21, M22] = mat2x2(M, [n11], [m11]);
% 
% Splits the matrix M into
%     M = [ M11  M12 ]
%         [ M21  M22 ],   where M11 = R^(n11 x m11)
% and the sizes of the remaining matrices follow.
% The arguments n11, m11 are optional.
% -------------------------------------------------------------------------

if     (nargin > 2)
    n11 = varargin{1};
    m11 = varargin{2};
elseif (nargin > 1)
    n11 = varargin{1};
    m11 = size(M, 1)/2;
else
    n11 = size(M, 1)/2;
    m11 = size(M, 1)/2;
end


M11 = M(     1:n11   ,     1:m11   );
M12 = M(     1:n11   , m11+1:end   );
M22 = M( n11+1:end   , m11+1:end   );
M21 = M( n11+1:end   ,     1:m11   );