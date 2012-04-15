%BENCH_SYNTHETIC: Test different RPCA algrithms on synthetic data
%
%   Uses the code freely available from 
%   http://perception.csl.uiuc.edu/matrix-rank/sample_code.html

% Copyright:   227A project group
% Last edited:   Apr 14, 2012


%% Generate random data

% define parameters
m = 100;
n = 100;
rk = 12;
rho = 0.1; % support of error matrix S_0
maxErr = 500; % bound on abs. value of errors

% create a random matrix 
L = randn(m,rk)/sqrt(m) * randn(rk,n)/sqrt(n);
tmpS = sprand(m,n,rho);
S = maxErr*2*(tmpS-0.5*sign(tmpS));
M = L + S;

% compute coherence parameter mu of L
mu = coherence(L);

%% select which algorithms to run, set other options

% set to zero if algorithm should not be used 
options.intpt.active = 0;
options.itth.active = 0;
options.apg.active = 0;
options.papg.active = 0;
options.dpga.active = 0;
options.ealm.active = 1;
options.ialm.active = 1;

% specify settings of the different algorithms
options.intpt.tol = 'low'; % default: 'standard'
options.itth.tol = 1e-4; % default: 5e-4 
options.apg.tol = 1e-6; % default: 1e-6 
options.papg.tol = 1e-6; % default: 1e-7 
options.dpga.tol = 5e-6*norm(M,'fro'); % default: 2e-5*norm(M,'fro')
options.dpga.maxIter = 2000; % default: 1000 
options.ealm.tol = 1e-7; % default: 1e-7
options.ialm.tol = 1e-7; % default: 1e-7



%% perform RPCA
lambda = 1/sqrt(m); % standard value
results = rpca_wrapper(L,S,lambda,options);


%% get info for plotting
names = fieldnames(results);
runtimes = zeros(1,length(names));
iterations = zeros(1,length(names));
Lerrs = zeros(1,length(names));
Serrs = zeros(1,length(names));
for i=1:length(names)
    algstruct = getfield(results,names{i});
    runtimes(i) = algstruct.t_run;
    iterations(i) = algstruct.numIter;
    Lerrs(i) = algstruct.errL;
    Serrs(i) = algstruct.errS;
end

%% tes BLWS implementation


tic;
[results.ialm.Lhat, results.ialm.Shat, results.ialm.numIter] = ...
    inexact_alm_rpca(M,lambda);
% compute relative errors
results.ialm.errL = norm(L-results.ialm.Lhat,'fro')/norm(L,'fro');
results.ialm.errS = norm(S-results.ialm.Shat,'fro')/norm(S,'fro');
results.ialm.t_run = toc;


tic;
[results.ialm2.Lhat, results.ialm2.Shat, results.ialm2.numIter] = ...
    BLWS_ialm_rpca(M,lambda);
% compute relative errors
results.ialm2.errL2 = norm(L-results.ialm2.Lhat,'fro')/norm(L,'fro');
results.ialm2.errS2 = norm(S-results.ialm2.Shat,'fro')/norm(S,'fro');
results.ialm2.t_run = toc;





