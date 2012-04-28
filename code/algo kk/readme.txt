Input:
A: Observed matrix:
n : dimension of the matrix

Output:
X : Sparse component
L2: Low rank component

Two different implementation: 
%%% This one is for bounded noise
[X, L2] = robustpcarankone(n, A);

%%% This one is for unbounded noise
[X, L2] = robustpcarankonev2(n, A);