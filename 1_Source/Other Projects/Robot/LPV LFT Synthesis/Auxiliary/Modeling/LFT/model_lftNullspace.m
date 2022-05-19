function [N11,N12,N21,N22] = model_lftNullspace(M11,M12,M21,M22)

[U,S0,V] = svd(M22);
[m,~]    = size(M22);

S  = S0(:,1:m);
V1 = V(:,1:m); 
V2 = V(:,m+1:end);

N11 = M11 - M12*(V1/S)*U'*M21;
N12 = M12*V2;
N21 = (V1/S)*U'*M21;
N22 = V2;