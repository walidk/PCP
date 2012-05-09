clear
n = 10;
numberofround = 20;
sparsevaluetotalv2 = zeros(1,n);
rankvaluetotalv2 =zeros(1,n);
correcttotalv2 = zeros(1,n); 

sparsevaluetotal = zeros(1,n);
rankvaluetotal =zeros(1,n);
correcttotal = zeros(1,n); 

sparsemaxv2 = 10;

for testindex = 1: numberofround
u = normrnd(0,1,[n 1]);
v = normrnd(0,1,[n 1]);



%for i = 1:n

for i = 1:n

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
A= u*v' + S;
    
    
%cvx_begin
%    variables X(n,n)
%    minimize(norm_nuc(A-X)+lambda*sum(sum(abs(X))));
%cvx_end
[Xv2, L2v2] = robustpcarankonev2(n, A);
[X, L2] = robustpcarankone(n, A);

sparsevaluev2(i) = sum(sum(abs(Xv2)>1e-3));
rankvaluev2(i) = sum(svd(A-Xv2)>1e-3);

sparsevalue(i) = sum(sum(abs(X)>1e-3));
rankvalue(i) = sum(svd(A-X)>1e-3);

if (sum(sum(abs(A-Xv2 - u*v')))<1e-12)
    correctv2(i) = 1;
else
    correctv2(i) =0;
end

if (sum(sum(abs(A-X - u*v')))<1e-12)
    correct(i) = 1;
else
    correct(i) =0;
end




end

sparsevaluetotalv2 = sparsevaluetotalv2 + sparsevaluev2;
rankvaluetotalv2 = rankvaluetotalv2  + rankvaluev2;
correcttotalv2 = correctv2 + correcttotalv2; 




sparsevaluetotal = sparsevaluetotal + sparsevalue;
rankvaluetotal = rankvaluetotal  + rankvalue;
correcttotal = correct + correcttotal; 

end

sparsevalueaveragev2 = sparsevaluetotalv2/numberofround;
rankvalueaveragev2 = rankvaluetotalv2/numberofround;
correctaveragev2 = correcttotalv2/numberofround; 

sparsevalueaverage = sparsevaluetotal/numberofround;
rankvalueaverage = rankvaluetotal/numberofround;
correctaverage = correcttotal/numberofround; 

lambdarange= [5:5:5*n];
subplot(2,3,1);
plot(lambdarange, sparsevalueaveragev2);
xlabel('Number of sparse corrupted entry');
ylabel('Number of nonzero values of S');
title('RPCA with known rank');
subplot(2,3,2);
plot(lambdarange, rankvalueaveragev2);
xlabel('Number of sparse corrupted entry');
ylabel('Rank of M-S');
title('RPCA with known rank');
subplot(2,3,3);
plot(lambdarange, correctaveragev2);
xlabel('Number of sparse corrupted entry');
ylabel('Correctness (1 means correct)');
title('RPCA with known rank');

subplot(2,3,4);
plot(lambdarange, sparsevalueaverage);
xlabel('Number of sparse corrupted entry');
ylabel('Number of nonzero values of S');
title('L1 heristic with known rank');
subplot(2,3,5);
plot(lambdarange, rankvalueaverage);
xlabel('Number of sparse corrupted entry');
ylabel('Rank of M-S');
title('L1 heristic with known rank');
subplot(2,3,6);
plot(lambdarange, correctaverage);
xlabel('Number of sparse corrupted entry');
ylabel('Correctness (1 means correct)');
title('L1 heristic with known rank');
%savefig('compare',  'pdf');
%X
