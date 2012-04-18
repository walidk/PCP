%BIG_DATA: Test RPCA for some big matrices
%
%   Uses the warm-start block Lanczos SVD method

% Copyright:   227A project group
% Last edited:   Apr 17, 2012


options.BLWSialm.active = 1;
options.BLWSialm.tol = 1e-7; % default: 1e-7
options.BLWSialm.maxIter = 1000; % default: 1000

m = 60000;
n = 1000;
r = 75;

L = 50*(0.5*ones(m,r)-rand(m,r)) * (0.5*ones(r,n)-rand(r,n));
tmpS = sprand(m,n,0.1);
S = 1000*2*(tmpS-0.5*sign(tmpS));
M = L + S; 

lambda= 1/sqrt(max(m,n));

result = rpca_wrapper(L,S,lambda,options);