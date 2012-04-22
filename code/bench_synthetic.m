%BENCH_SYNTHETIC: Test different RPCA algrithms on synthetic data
%
%   Uses the code freely available from 
%   http://perception.csl.uiuc.edu/matrix-rank/sample_code.html

% Copyright:   227A project group
% Last edited:   Apr 20, 2012


%% select which algorithms to run, set other options

% set to one if algorithm should be used (default is 0)
options.intpt.active = 0;
options.itth.active = 0;
options.dpga.active = 0;
options.apg.active = 0;
options.papg.active = 0;
options.ealm.active = 1;
options.ialm.active = 1;
options.BLWSialm.active = 1;

% specify settings of the different algorithms
options.intpt.tol = 'low'; % default: 'standard'
options.intpt.solver = 'sedumi'; % default: 'sedumi'
options.itth.tol = 5e-4; % default: 5e-4 
options.apg.tol = 1e-6; % default: 1e-6 
options.papg.tol = 1e-6; % default: 1e-7 
options.dpga.tol = 1e-4; % default: 2e-5*norm(M,'fro')...
options.dpga.maxIter = 2000; % default: 1000 
options.ealm.tol = 1e-7; % default: 1e-7
options.ialm.tol = 1e-7; % default: 1e-7
options.BLWSialm.tol = 1e-7; % default: 1e-7
options.BLWSialm.maxIter = 1000; % default: 1000

% get the solvers as strings...
solvers = get_solvers(options);



%% Compare ialm and BLWS ialm for random data of different size

nrun = 10;
dims = [50, 100, 200, 500, 750, 1000, 1500, 2000, 2500, 3000];%, 200, 350, 500];%, 1000, 1500];%, 2000, 3000];
resultarray = cell(length(dims),1);

for k=1:length(dims)
     
    rk = ceil(0.1*dims(k));
    rho = 0.1; % support of error matrix S_0
    maxErr = 500; % bound on abs. value of errors
    
    for j=1:nrun

        % create a random matrix 
        L = j*randn(dims(k),rk)/sqrt(dims(k)) * randn(rk,dims(k))/sqrt(dims(k));
        tmpS = sprand(dims(k),dims(k),rho);
        S = maxErr*2*(tmpS-0.5*sign(tmpS));
        %M = L + S;    

        % compute RPCA
        lambda = 1/sqrt(dims(k)); % default value
        tmpresult = rpca_wrapper(L,S,lambda,options);
        
        % keep track of statistics
        resultarray{k} = keep_statistics(resultarray{k},tmpresult,j,options);

    end
end
    

%% get info for plotting
trun_avgs = zeros(length(solvers),length(dims));
numIter_avgs = zeros(length(solvers),length(dims));
errL_avgs = zeros(length(solvers),length(dims));
errS_avgs = zeros(length(solvers),length(dims));

for k=1:length(dims)
    for j=1:length(solvers)
        stats = getfield(resultarray{k},solvers{j});
        trun_avgs(j,k) = stats.trun_avg;
        numIter_avgs(j,k) = stats.numIter_avg;
        errL_avgs(j,k) = stats.errL_avg;
        errS_avgs(j,k) = stats.errS_avg;
    end  
end

%% plot
f = figure('Position',[100 900 800 600]);
subplot(2,2,1);
plot(dims,trun_avgs');
title('Average running time');
xlabel('Matrix dimension (square matrices)');
ylabel('average computation time [s]');
legend(solvers,'Location','NorthWest');
subplot(2,2,2);
plot(dims,numIter_avgs');
title('Average number of iterations');
xlabel('Matrix dimension (square matrices)');
ylabel('average number of iterations');
legend(solvers,'Location','NorthWest');
ylim([0.75*min(min(numIter_avgs)), 1.25*max(max(numIter_avgs))]);
subplot(2,2,3);
plot(dims,errL_avgs');
title('Average relative error in L');
xlabel('Matrix dimension (square matrices)');
ylabel('average relative error');
legend(solvers,'Location','NorthWest');
subplot(2,2,4);
plot(dims,errS_avgs');
title('Average relative error in S');
xlabel('Matrix dimension (square matrices)');
ylabel('average relative error');
legend(solvers,'Location','NorthWest');
