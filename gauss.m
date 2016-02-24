
function x=gauss(a,b)
[~,n]=size(a);
[a,b]=pivot(a,b,n);
[a,b]=eliminate(a,b,n);
x=substitute(a,b,n);
end

function [ahold,bhold]=pivot(a,b,n)
rw=(1:n)';
for k=1:n-1;
max=0;
i=0;
for j=k:n
if abs(a(rw(j),k))>max
max=abs(a(rw(j),k));
i=j;
end
end
if rw(k)~=rw(i)
phold=rw(k);
rw(k)=rw(i);
rw(i)=phold;
end
ahold=zeros(n);
bhold=(1:n)';
for p=1:n
ahold(p,:)=a(rw(p),:);
bhold(p,:)=b(rw(p),:);
end
end
end
function [a,b]=eliminate(a,b,n)
for k=1:n-1
for i=k+1:n
factor=a(i,k)/a(k,k);
for j=k:n
a(i,j)=a(i,j)-factor*a(k,j);
end
b(i,1)=b(i,1)-factor*b(k,1);
end
end
end
function x=substitute(a,b,n)
x=(1:n);
for l=n:-1:1
x(l)=b(l,1)/a(l,l);
for j=l:-1:1
b(j,1)=b(j,1)-x(l)*a(j,l);
a(j,l)=0;
end
end
end