function [V, N_, Np, Z, Y] = construct_orthogonalEigSeparationSIAM00(P, Pt)

    Z      = [I(size(P, 2)/2); O(size(P, 2)/2)];
    Y      = [O(size(P, 2)/2); I(size(P, 2)/2)];
    
    N      = (P - Pt^-1)^-1;
    
    NN1 = N - Z*(Z'*P*Z)^-1*Z';
    NN2 = N - Y*(Y'*P*Y)^-1*Y';

    [T1, eigNN1] = schur(NN1);
    [T2, eigNN2] = schur(NN2);
    
    % This is assuming that we have equally many positive and negative eigenvalues
    T1 = T1*Z;
    T2 = T2*Y;
    
    V = [T1, T2];
  
    N_ = Z'*eigNN1*Z;
    Np = Y'*eigNN2*Y;

    
    