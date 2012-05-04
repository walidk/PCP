function [S2, L2] = robustpcarankonev4(m,n, A)
%n = 5;
%c = ones(1,n);
%d = zeros(1,n);
%wmh(n,c,d);
%n =5;

%u = normrnd(0,1,[n 1]);
%v = normrnd(0,1,[n 1]);
%A= u*v' ;
numberofrun = 10;

p = ones(1,m);
q = ones(1,n);

%for i = 1:n 
%    p(i) =i*33;
%    q(i) = n+1 -i;
%end

for i = 1: numberofrun
    %computing p
    for index = 1:m
        c = abs(q);
        d = ( A(index,:)./q );
        p(index) = wmh(n,c,d);
    end
    
    %p = p / max(p); 
    
    %computing q
    for index = 1:n 
        c = abs(p);
        d = ( A(:,index)./p' );
        q(index) = wmh(m,c,d);
    end
  
    
end
    
%lambda = 1/sqrt(n);
%cvx_begin
%    variables X(n,n)
%    minimize(norm_nuc(A-X)+lambda*sum(sum(abs(X))));
%cvx_end

%A-X
%u*v'
S2 = A - p'*q ; 
L2 = p'*q;