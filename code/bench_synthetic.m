%BENCH_SYNTHETIC: Test different RPCA algrithms on synthetic data
%
%   Uses the code freely available from 
%   http://perception.csl.uiuc.edu/matrix-rank/sample_code.html

% Copyright:   227A project group
% Last edited:   Apr 09, 2012


%% Generate random data


% define parameters
m = 20;
n = 20;
rk = 2;
rho = 0.1; % support of error matrix S_0

% create a random matrix 
L = randn(m,rk)/sqrt(m) * randn(rk,n)/sqrt(n);
S = sign(sprandn(m,n,rho));
M = L + S;

%% compute coherence parameter mu of L
mu = coherence(L);


%% perform RPCA using different algorithms
lambda = 1/sqrt(m); % standard value
results = rpca_wrapper(L,S,lambda);


