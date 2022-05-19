%% Permutation Matrix for Kronecker Products
% mdiag for k = 1 ... H : kronecker( P (n1 x n1) , I (n2 x n2) )
% 
%     = Psi' * kronecker( P (n1 x n1) , I (H*n2 x H*n2) ) * Psi

function [Psi] = kroneckerPermutation(n1, n2, H);



In2 = eye(n2);
On2 = zeros(n2, n2);

IStamp = In2;
OStamp = On2;
for i = 1:(n1-1)
    IStamp = [IStamp; On2];
end

  IStamp = [];
for i = 1:H
    OStamp = [OStamp, On2];
    IStamp = [IStamp; On2];
end
  IStamp(1:n2, 1:n2) = In2;

PsiStamp = [];
  OStamp = [];
for i = 1:n1
    OStamp = [OStamp, On2];
    PsiStamp = mdiag(PsiStamp, IStamp);
end


Psi     = PsiStamp;
IStampH = PsiStamp;
for i = 1:H-1
    IStampH = [OStamp; IStampH(1:(end-n2), :)];
    Psi = [Psi, IStampH];
end
    
