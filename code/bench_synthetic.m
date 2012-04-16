%BENCH_SYNTHETIC: Test different RPCA algrithms on synthetic data
%
%   Uses the code freely available from 
%   http://perception.csl.uiuc.edu/matrix-rank/sample_code.html

% Copyright:   227A project group
% Last edited:   Apr 14, 2012


%% select which algorithms to run, set other options

% set to one if algorithm should be used (default is 0)
options.intpt.active = 0;
options.itth.active = 0;
options.apg.active = 0;
options.papg.active = 0;
options.dpga.active = 0;
options.ealm.active = 0;
options.ialm.active = 1;
options.BLWSialm.active = 1;


% specify settings of the different algorithms
options.intpt.tol = 'low'; % default: 'standard'
options.itth.tol = 1e-4; % default: 5e-4 
options.apg.tol = 1e-6; % default: 1e-6 
options.papg.tol = 1e-6; % default: 1e-7 
options.dpga.tol = 5e-6*norm(M,'fro'); % default: 2e-5*norm(M,'fro')
options.dpga.maxIter = 2000; % default: 1000 
options.ealm.tol = 1e-7; % default: 1e-7
options.ialm.tol = 1e-7; % default: 1e-7
options.BLWSialm.tol = 1e-7; % default: 1e-7
options.BLWSialm.maxIter = 1000; % default: 1000


%% Run RPCA for random data of different size

dims = [100, 200, 500, 750, 1000];
resultarray = cell(length(dims),1);

for k=1:length(dims)
     
    rk = 0.1*dims(k);
    rho = 0.1; % support of error matrix S_0
    maxErr = 500; % bound on abs. value of errors

    % create a random matrix 
    L = randn(dims(k),rk)/sqrt(dims(k)) * randn(rk,dims(k))/sqrt(dims(k));
    tmpS = sprand(dims(k),dims(k),rho);
    S = maxErr*2*(tmpS-0.5*sign(tmpS));
    M = L + S;    
    
    % compute RPCA
    lambda = 1/sqrt(dims(k)); % default value
    resultarray{k} = rpca_wrapper(L,S,lambda,options);

end
    
    
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
