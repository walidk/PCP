clear
n = 10;
numberofround = 10;
sparsevaluetotal = zeros(1,n);
rankvaluetotal =zeros(1,n);
correcttotal = zeros(1,n); 
sparsemax = 10;

for testindex = 1: numberofround
u1 = normrnd(0,1,[n 1]);
v1 = normrnd(0,1,[n 1]);

u2 = normrnd(0,1,[n 1]);
v2 = normrnd(0,1,[n 1]);


for i = 1:10
S = zeros(n,n);

for sparseindex = 1:i*5
    randx = ceil(rand*10); 
    randy = ceil(rand*10);     
    
    while    ( S(randx,randy) ~= 0)
    
    randx = ceil(rand*10); 
    randy = ceil(rand*10);   

    end
    
    S(randx,randy) = normrnd(0,1);
    
    
end
A= u1*v1' + u2*v2' + S;
    
    
%cvx_begin
%    variables X(n,n)
%    minimize(norm_nuc(A-X)+lambda*sum(sum(abs(X))));
%cvx_end
[X, L2] = robustpcarankonev3(n, A, 2);

sparsevalue(i) = sum(sum(abs(X)>1e-3));
rankvalue(i) = sum(svd(A-X)>1e-3);

if (sum(sum(abs(A-X -(u1*v1' + u2*v2'))))<1e-3)
    correct(i) = 1;
else
    correct(i) =0;
end

end

sparsevaluetotal = sparsevaluetotal + sparsevalue;
rankvaluetotal = rankvaluetotal  + rankvalue;
correcttotal = correct + correcttotal; 
end

sparsevalueaverage = sparsevaluetotal/numberofround;
rankvalueaverage = rankvaluetotal/numberofround;
correctaverage = correcttotal/numberofround; 

lambdarange= [5:5:5*n];
subplot(2,2,1);
plot(lambdarange, sparsevalueaverage);
xlabel('Number of sparse corrupted entry');
ylabel('Number of nonzero values of S');
subplot(2,2,2);
plot(lambdarange, rankvalueaverage);
xlabel('Number of sparse corrupted entry');
ylabel('Rank of M-S');
subplot(2,2,3);
plot(lambdarange, correctaverage);
xlabel('Number of sparse corrupted entry');
ylabel('Correctness (1 means correct)');
sum(sum(abs(S)))

%savefig('rank2case',  'pdf');
%u1
%v1 
%u2
%v2 
%X
