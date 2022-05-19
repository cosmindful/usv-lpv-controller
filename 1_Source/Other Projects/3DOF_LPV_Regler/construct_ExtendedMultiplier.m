function [Pi, U, T, N_, Np] = construct_ExtendedMultiplier(P, P_tilde)

    PM          = P - P_tilde^-1;
    cPM         = cond(PM);

    % Determine U, N-, Np, s.t. U'*PM*U = mdiag(N_, Np)
%     [U, N_, Np] = construct_orthogonalEigSeparationSchur(PM);

    [U, N_, Np, Z, Y] = construct_orthogonalEigSeparationSIAM00(P, P_tilde);
    Pi = [  P    ,    U        ;...
            U'   , U'*PM^-1*U ];
        
	eig(mdiag(Z,Z)'*Pi*mdiag(Z,Z)) < 0;
    eig(mdiag(Y,Y)'*Pi*mdiag(Y,Y)) > 0;

%     [U, N_, Np] = construct_orthogonalEigSeparationSchur(PM);
% 
    T  = eye(size(U));
%     Pi = [  P       ,         U*T        ;...
%            (U*T)'   , T'*(U'*PM*U)^-1*T ];
       
     