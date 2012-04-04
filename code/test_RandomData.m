%TEST_RANDOMDATA: Test different RPCA algrithms on random data
%
%   Requires the code freely available from 
%   http://perception.csl.uiuc.edu/matrix-rank/sample_code.html

% Copyright:   227A project group
% Last edited:   Apr 03, 2012


%% Generate random data

% define parameters
m = 20;
n = 20;
r = 0.05*n;
rho = 0.1; % support of error matrix S_0

% create a random matrix 
L = randn(m,r)/sqrt(m) * randn(r,n)/sqrt(n);
S = sign(sprandn(m,n,rho));
M = L + S;


%% perform RPCA using different algorithms

%% interior point (using cvx)
cvx_begin
    variable Y(m,n);
    maximize(trace(Y'*M));
    subject to
        norm(Y,2) <= 1;
        norm(Y(:),Inf) <= 1;
cvx_end
% recover primal solution (TO DO!)


%% iterative thresholding
lambda = m^(-1/2); % from paper
tau = 1e4; % default in sample code
delta = 0.9; % default in sample code
tic;
[L_it S_it] = singular_value_rpca(M,lambda);
T_it = toc;
% compute relative errors
Lerr_it = norm(L-L_it,'fro')/norm(L,'fro');
Serr_it = norm(S-S_it,'fro')/norm(S,'fro');


%% APG method (full SVD)
lambda = m^(-1/2); % from paper
tic;
[L_APG,S_APG,iter_APG] = proximal_gradient_rpca(M, lambda);
T_APG = toc;
Lerr_APG = norm(L-L_APG,'fro')/norm(L,'fro');
Serr_APG = norm(S-S_APG,'fro')/norm(S,'fro');


%% APG method (partial SVD)
lambda = m^(-1/2); % from paper
tic;
[L_APGpSVD,S_APGpSVD,iter_APGpSVD] = partial_proximal_gradient_rpca(M, lambda);
T_APGpSVD = toc;
Lerr_APGpSVD = norm(L-L_APGpSVD,'fro')/norm(L,'fro');
Serr_APGpSVD = norm(S-S_APGpSVD,'fro')/norm(S,'fro');


%% dual projected gradient ascent method
tic;
[L_dual S_dual iter_dual] = dual_rpca(M);
T_dual = toc;
% compute relative errors
Lerr_dual = norm(L-L_dual,'fro')/norm(L,'fro');
Serr_dual= norm(S-S_dual,'fro')/norm(S,'fro');


%% exact ALM method
tic;
[L_alm S_alm iter_alm] = exact_alm_rpca(M);
T_alm = toc;
% compute relative errors
Lerr_alm = norm(L-L_alm,'fro')/norm(L,'fro');
Serr_alm = norm(S-S_alm,'fro')/norm(S,'fro');


%% inexact ALM method
tic;
[L_inxalm S_inxalm iter_inxalm] = inexact_alm_rpca(M);
T_inxalm = toc;
Lerr_inxalm = norm(L-L_inxalm,'fro')/norm(L,'fro');
Serr_inxalm = norm(S-S_inxalm,'fro')/norm(S,'fro');



