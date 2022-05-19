function out = nichols(varargin)
% NICHOLS   Pointwise Nichols frequency response for PFRD objects
%
% NICHOLS(SYS) draws Nichols plots of SYS at each point in the domain 
% of SYS.
%
% NICHOLS(SYS,{WMIN,WMAX}) draws the Nichols plot for frequencies 
% between WMIN and WMAX (in radians/second).
%
% NICHOLS(SYS,W) uses the user-supplied vector W of frequencies, in
% radians/second, at which the Nichols response is to be evaluated.  
%
% NICHOLS(SYS1,SYS2,...,W) graphs the Nichols response of several systems
% SYS1,SYS2,... on a single plot. 
%
% See also: nichols, bode, bodemag, nyquist, sigma, freqresp.

% TODO PJS 5/1/2011: Revisit the handling of the output arguments. 

nin = nargin;
nout = nargout;
if nout>0
   strerr = ' with a PSS or PFRD cannot be called with output arguments.';
   error([upper(mname) strerr])
end

incell = cell(1,nin);
for i=1:nin
   if isa(varargin{i},'pss')
      incell{i} = varargin{i}.DataPrivate;
   elseif isa(varargin{i},'pfrd')
      incell{i} = varargin{i}.DataPrivate;
   else
      incell{i} = varargin{i};
   end
end

nichols(incell{:});



