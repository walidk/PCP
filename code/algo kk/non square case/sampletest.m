%%% tesing
clear

m = 5;
n =10; 
%u = normrnd(0,1,[n 1]);
%v = normrnd(0,1,[n 1]);
%u = ones(m,1);
%v = ones(n,1);
u = normrnd(0,1,[m 1]);
v = normrnd(0,1,[n 1]);



S = zeros(m,n);

S(2,5) = 10;
%S(2,2) = S(1,1);

A= u*v'+S ;
[S2, L2] = robustpcarankonev4(m,n, A);

L2
u*v'