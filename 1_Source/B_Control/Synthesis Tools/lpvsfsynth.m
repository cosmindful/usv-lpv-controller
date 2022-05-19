% -------------------------------------------------------------------------
% Syntax   : [F, gam, info] = lpvsfsynth(P, ncont, Rb, opts)
%
%            P : collection of parameter-dependent state-space models
%         ncont: number of control inputs
%            Rb: basis object
%          opts: options structure created with synthopts
% -------------------------------------------------------------------------
% Computes a parameter-varying state feedback gain F such that
% A+B_2*F is parameter dependent stable and the induced L2-norm 
% from d->e is minimized
%
% Uses parameter-dependent Lyapunov matrices of the type sum(g_i(p)*R_i)
% Uses suboptimal synthesis (indirect conditioning)
%
%      P:
%                    (nx)   |  (nd)    (ncont)
%                     x     |   d       u
%
%     (nx) dx    [    A     |   B_1     B_2    ]
%    ---------   [----------+----------------- ]
%    (ne1) e1    [   C_11   |   D_111x  D_121  ]
%    (ne2) e2    [   C_12   |   D_112x  D_122  ]
%
% -------------------------------------------------------------------------
% options are set using synthopts and include
% -     a balancing state transformation (default on)
% -     suboptimal synthesis (default subfactor = 1.1)
% -     relative performance index (default off)
% -------------------------------------------------------------------------
% If you run into numerical issues you may try the modified parser
% -------------------------------------------------------------------------
% uses Robust Control Toolbox and LPVTools (legacy support w/o LPVTools)

% -------------------------------------------------------------------------
% Author   : Julian Theis
% Version  : 2014-03-19
% Credit   : Wu95, Saupe13, Pfifer13, Knoblach13
% -------------------------------------------------------------------------
% latest update: changed to make use of pss objects, added legacy support
