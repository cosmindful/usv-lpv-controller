%% Controller Synthesis for a Two-Degrees of Freedom Robotic Manipulator
% -------------------------------------------------------------------------
% script   : Robot_PolytopicSynthesis
% -------------------------------------------------------------------------
% Author   : Christian Hoffmann
% Version  : August, 2nd 2013
% Copyright: CH, 2013
% -------------------------------------------------------------------------
%
% 1. Synthesize polytopic LPV controller
%
% -------------------------------------------------------------------------

pdP = psys([PLFR_phi_vertices{:}]);
   r = [ny, nu];
gmin = 0;
 tol = 1e-2;

[gopt, pdK, R, S] = hinfgs(pdP, r, gmin, tol);

for ii = 1:nVerticesPhi
    KPolytopic_vertices{ii} = psinfo(pdK, 'sys', ii);
    [AK{ii}, BK{ii}, CK{ii}, DK{ii}, EK{ii}] = ltiss(KPolytopic_vertices{ii});
    KPolytopic_vertices{ii} = ss(AK{ii}, BK{ii}, CK{ii}, DK{ii});
end