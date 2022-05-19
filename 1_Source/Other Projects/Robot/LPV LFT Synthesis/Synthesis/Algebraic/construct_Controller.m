function [K] = construct_Controller(gamProj, PiR, PiS, Ropt, Sopt, PLFR)
    
    cPiR         = cond(PiR);
    cPiS         = cond(PiS);
      
    % Perturb Pit if required, to render it non-singular
        [UPiS, SPiS, VPiS] = svd(PiS);
        SPiSPerturbation   = zeros(size(diag(PiS)));
        SPiSPerturbation(diag(SPiS) < 1e-8) = 1e-8;
        SPiS = SPiS + diag(SPiSPerturbation);
    
        PiS = UPiS*SPiS*VPiS';
    
    % Construct Lyapunov matrix
    RSinv          = Ropt - Sopt^-1;
    cRSinv         = cond(RSinv);
    
    Z = orth(RSinv);
    
    XX  = [ Ropt ,          Z        ;...
            Z'   , (Z'*(RSinv)*Z)^-1 ];
        
    cXX = cond(XX);

    PM          = PiR - PiS^-1;
    cPM         = cond(PM);

    [Pi, U, T, N_, Np] = construct_ExtendedMultiplier(PiR, PiS);    
    cPi                = cond(Pi);
       
    % Determine dimensions
    nzKth = rank(Np); % k_c
    nwKth = rank(N_); % m_c
    
    S1DeltaP   = PLFR.S1Delta;
    S2DeltaP   = PLFR.S2Delta;
    
    schedParams = symvar(S1DeltaP);
    
    SDeltaP    = [S1DeltaP; S2DeltaP];
    V_VpDeltaP = SDeltaP'*U;
    V_DeltaP   = V_VpDeltaP(:, 1:nwKth    );
    VpDeltaP   = V_VpDeltaP(:, nwKth+1:end);
    
    S1DeltaK     = N_*V_DeltaP' * (SDeltaP' * PiR * SDeltaP - V_DeltaP*N_*V_DeltaP')^-1 * VpDeltaP;
    S2DeltaK     = eye(size(S1DeltaK));
    SDeltaK      = [S1DeltaK; S2DeltaK];
    
    % Size of the controller's scheduling function
    nwKth = numel(find(eig(PM) < 0));
    nzKth = numel(find(eig(PM) > 0));
     
%     end
    
    [gopt, KLFR] = min_gamma_over_K(PLFR, XX, Pi, gamProj, S1DeltaK, S2DeltaK);

    K         = KLFR;
    K.S1Delta = S1DeltaK;
    K.S2Delta = S2DeltaK;
    K.x0      = zeros(size(K.A, 2), 1);
    
    
% Nonexplicit controller construction    
%     MDeltaP = (U'*PM*U)^-1 - U'*SDeltaP* (SDeltaP'*Pi*SDeltaP)^-1 *SDeltaP'*U;
%     MDeltaP0 = subs(MDeltaP, );
%     MMDeltaP = T'*MDeltaP*T;
