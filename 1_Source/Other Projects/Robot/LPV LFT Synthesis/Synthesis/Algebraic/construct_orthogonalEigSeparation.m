function [V, N_, Np] = construct_orthogonalEigSeparation(PM)

    [V, N] = eig(PM);
%     [V, N] = jordan(PM);
    V = orth(V);
    n = diag(N);
    [dsorted, indices] = sort(n, 'ascend');
    
    V = V(:, indices);
    
    ii = 1;
    candidateN_ = N(1:ii,1:ii);
   
    while ( sum(eig(candidateN_) > 0) == 0 )
        ii = ii+1;
        candidateN_ = N(1:ii, 1:ii);
    end
    N_ = N(1:ii-1, 1:ii-1);
    
    Np = N(ii:end, ii:end);
    
    NN = mdiag(N_, Np);
    
    