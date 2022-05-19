A = rand(3,3);
B = rand(3,2);
C = rand(3,1);

N  = 2;
I  = eye(N);
IL = I;
IF = I;
IF(1:end/2, 1:end/2) = 0;
IL = I - IF;

     X = [A, B, C];
    NX = null(X);
   NX1 = NX(                      (1):(size(A, 2))                               , :);
   NX2 = NX((size(A, 2)           +1):(size(A, 2)+size(B, 2))                    , :);
   NX3 = NX((size(A, 2)+size(B, 2)+1):(size(A, 2)+size(B, 2)+size(C, 2))         , :);
 kronX = [kron(I, A), kron(I, B), kron(I, C)];
NkronX = null(kronX);
NkronX = [kron(I, NX1); kron(I, NX2); kron(I, NX3)];


 kronXd = [kron(I, A), kron(IF, B), kron(IL, B), kron(I, B), kron(I, C)];
NkronXd = null(kronXd);
        
         
null(NkronXd)

     Xt   = [A, 1*B, 1*B, C];
     NXt  = null(Xt);
    NX1t  = NXt(                                 (1):(size(A, 2))                                 , :);
    NX21t = NXt((size(A, 2)                      +1):(size(A, 2)+size(B, 2))                      , :);
    NX22t = NXt((size(A, 2)+size(B, 2)           +1):(size(A, 2)+size(B, 2)+size(B, 2))           , :);
    NX3t  = NXt((size(A, 2)+size(B, 2)+size(B, 2)+1):(size(A, 2)+size(B, 2)+size(B, 2)+size(C, 2)), :);
    
NkronXdt   = [  kron(I  , NX1t );
              1*kron(IF , NX21t);
              1*kron(IL , NX21t);
              1*kron(I  , NX22t);
                kron(I  , NX3t )];
 kronXd*NkronXdt
 
NkronXdi = [  0*kron(I , zeros(size(A, 2), size(B, 2)))  ;
              1*kron(IL, eye(size(B, 2)))                ;
              1*kron(IF, eye(size(B, 2)))                ;
              0*kron(I , zeros(size(B, 2), size(B, 2)))  ;
              0*kron(I , zeros(size(C, 2), size(B, 2)))];
 kronXd*NkronXdi
  
NkronXd = ([NkronXdt, NkronXdi]);
null(NkronXd)
 kronXd*NkronXd