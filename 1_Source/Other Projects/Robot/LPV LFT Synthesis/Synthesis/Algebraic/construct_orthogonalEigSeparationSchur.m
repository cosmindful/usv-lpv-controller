function [V, N_, Np] = construct_orthogonalEigSeparationSchur(PM)

    [V, N] = schur(PM);
    [V, N] = ordschur(V, N, 'lhp');

    n  = diag(N);
    n_ = length(find(n < 0));

    N_ = N(1:n_, 1:n_);
    
    Np = N(n_+1:end, n_+1:end);
    
    NN = mdiag(N_, Np);
    
    