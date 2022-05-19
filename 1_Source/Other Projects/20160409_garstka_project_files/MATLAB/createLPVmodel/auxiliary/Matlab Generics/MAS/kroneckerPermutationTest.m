p1 = 2;
p2 = 4;
q1 = 2;
q2 = 3;

p = [ p1, p2 ];
q = [ q1, q2 ];

N  = 2;
IN = rand(N,N);

M11 = rand(p1,q1)
M12 = rand(p1,q2)
M21 = rand(p2,q1)
M22 = rand(p2,q2)

L11 = rand(q1,p1)
L12 = rand(q1,p2)
L21 = rand(q2,p1)
L22 = rand(q2,p2)


M   = [ M11, M12;
        M21, M22 ]
    
L   = [ L11, L12;
        L21, L22 ]
    
Md  = [ kron(IN, M11), kron(IN, M12);
        kron(IN, M21), kron(IN, M22) ]
    
Ld  = [ kron(IN, L11), kron(IN, L12);
        kron(IN, L21), kron(IN, L22) ]
    
[PsiMP, PsiMQ] = kroneckerPermutationBlock(p, q, N);
[PsiLQ, PsiLP] = kroneckerPermutationBlock(q, p, N);

PsiMP*Md*PsiMQ == kron(IN, M)

PsiLQ*Ld*PsiLP == kron(IN, L)

PsiMQ*PsiLQ

Md*Ld - PsiMP'*kron(IN, M)*PsiMQ' * PsiLQ'*kron(IN, L)*PsiLP'


%%
[PsiP, PsiQ] = kroneckerPermutationBlock([1 1 1], [1 1 1], 3);
