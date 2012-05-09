clear
n = 10;
lambda = 1/sqrt(n);
numberofround = 10;
sparsevaluetotal = zeros(1,n);
rankvaluetotal =zeros(1,n);
correcttotal = zeros(1,n);
sparsevaluetotalcvx = zeros(1,n);
rankvaluetotalcvx =zeros(1,n);
correcttotalcvx = zeros(1,n); 

sparsemax = 10;

for testindex = 1: numberofround
u1 = normrnd(0,1,[n 1]);
v1 = normrnd(0,1,[n 1]);

u2 = normrnd(0,1,[n 1]);
v2 = normrnd(0,1,[n 1]);


for i = 1:10
S = zeros(n,n);

for sparseindex = 1:i
    randx = ceil(rand*10); 
    randy = ceil(rand*10);     
    
    while    ( S(randx,randy) ~= 0)
    
    randx = ceil(rand*10); 
    randy = ceil(rand*10);   

    end
    
    S(randx,randy) = normrnd(0,1);
    
    
end
A= u1*v1' + u2*v2' + S;
    
    
cvx_begin
    variables Xcvx(n,n)
    minimize(norm_nuc(A-Xcvx)+lambda*sum(sum(abs(Xcvx))));
cvx_end
Lcvx = A-Xcvx;

[X, L2] = robustpcarankonev3(n, A, 2);


sparsevalue(i) = sum(sum(abs(X)>1e-3));
rankvalue(i) = sum(svd(A-X)>1e-3);

sparsevaluecvx(i) = sum(sum(abs(Xcvx)>1e-3));
rankvaluecvx(i) = sum(svd(A-Xcvx)>1e-3);


if (sum(sum(abs(A-X -(u1*v1' + u2*v2'))))<1e-2)
    correct(i) = 1;
else
    correct(i) =0;
end

if (sum(sum(abs(A-Xcvx -(u1*v1' + u2*v2'))))<1e-2)
    correctcvx(i) = 1;
else
    correctcvx(i) =0;
end


end

sparsevaluetotal = sparsevaluetotal + sparsevalue;
rankvaluetotal = rankvaluetotal  + rankvalue;
correcttotal = correct + correcttotal; 

sparsevaluetotalcvx = sparsevaluetotalcvx + sparsevaluecvx;
rankvaluetotalcvx = rankvaluetotalcvx  + rankvaluecvx;
correcttotalcvx = correctcvx + correcttotalcvx; 

end

sparsevalueaverage = sparsevaluetotal/numberofround;
rankvalueaverage = rankvaluetotal/numberofround;
correctaverage = correcttotal/numberofround; 

sparsevalueaveragecvx = sparsevaluetotalcvx/numberofround;
rankvalueaveragecvx = rankvaluetotalcvx/numberofround;
correctaveragecvx = correcttotalcvx/numberofround; 

lambdarange= [1:1:n];
subplot(2,3,1);
plot(lambdarange, sparsevalueaveragecvx);
xlabel('Number of sparse corrupted entry');
ylabel('Number of nonzero values of S');
title('RPCA ');
subplot(2,3,2);
plot(lambdarange, rankvalueaveragecvx);
xlabel('Number of sparse corrupted entry');
ylabel('Rank of M-S');
title('RPCA ');
subplot(2,3,3);
plot(lambdarange, correctaveragecvx);
xlabel('Number of sparse corrupted entry');
ylabel('Correctness (1 means correct)');
title('RPCA ');

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
savefig('comparisonwithrank2',  'pdf');
%u1
%v1 
%u2
%v2 
%X
