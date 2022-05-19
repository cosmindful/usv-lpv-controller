function der1=derv1(T,q);
n=length(q);
for i=2:n-1
    d(i)=(q(i+1)-q(i-1))/(2*T);
end
d(1)=d(2);
d(n)=d(n-1);
der1=d';

