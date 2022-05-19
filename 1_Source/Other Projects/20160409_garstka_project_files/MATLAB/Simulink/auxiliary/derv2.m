function der2=derv2(T,q);
n=length(q);
for i=2:n-1
    d(i)=(q(i+1)+q(i-1)-2*q(i))/(T^2);
end
d(1)=d(2);
d(n)=d(n-1);
der2=d';

