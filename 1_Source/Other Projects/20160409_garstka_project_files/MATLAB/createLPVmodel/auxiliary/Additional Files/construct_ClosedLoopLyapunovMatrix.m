function Xopt = construct_ClosedLoopLyapunovMatrix(Ropt, Sopt)

    RSinv          = Ropt - Sopt^-1;
    Z              = orth(RSinv);

    Xopt  = [ Ropt ,          Z        ;...
              Z'   , (Z'*(RSinv)*Z)^-1 ];
    disp(sprintf('Condition number of closed-loop Lyapunov matrix:  %9.4e', cond(Xopt)));