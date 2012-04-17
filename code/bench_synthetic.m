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
options.BLWSialm.tol = 1e-8; % default: 1e-7
options.BLWSialm.maxIter = 1000; % default: 1000



% %% get info for plotting
% names = fieldnames(results);
% runtimes = zeros(1,length(names));
% iterations = zeros(1,length(names));
% Lerrs = zeros(1,length(names));
% Serrs = zeros(1,length(names));
% for i=1:length(names)
%     algstruct = getfield(results,names{i});
%     runtimes(i) = algstruct.t_run;
%     iterations(i) = algstruct.numIter;
%     Lerrs(i) = algstruct.errL;
%     Serrs(i) = algstruct.errS;
% end

%% Compare ialm and BLWS ialm for random data of different size

nrun = 10;
dims = [100, 200, 350, 500];%, 750, 1000, 1500, 2000, 3000];
resultarray = cell(length(dims),1);

for k=1:length(dims)
     
    rk = 0.1*dims(k);
    rho = 0.1; % support of error matrix S_0
    maxErr = 500; % bound on abs. value of errors
    
    for j=1:nrun

        % create a random matrix 
        L = j*randn(dims(k),rk)/sqrt(dims(k)) * randn(rk,dims(k))/sqrt(dims(k));
        tmpS = sprand(dims(k),dims(k),rho);
        S = maxErr*2*(tmpS-0.5*sign(tmpS));
        M = L + S;    

        % compute RPCA
        lambda = 1/sqrt(dims(k)); % default value
        tmpresult = rpca_wrapper(L,S,lambda,options);
        
        if j==1
            resultarray{k}.ialm.trun_avg = tmpresult.ialm.t_run;
            resultarray{k}.ialm.numIter_avg = tmpresult.ialm.numIter;
            resultarray{k}.ialm.errL_avg = tmpresult.ialm.errL;
            resultarray{k}.ialm.errS_avg = tmpresult.ialm.errS;
            resultarray{k}.BLWSialm.trun_avg = tmpresult.BLWSialm.t_run;
            resultarray{k}.BLWSialm.numIter_avg = tmpresult.BLWSialm.numIter;
            resultarray{k}.BLWSialm.errL_avg = tmpresult.BLWSialm.errL;
            resultarray{k}.BLWSialm.errS_avg = tmpresult.BLWSialm.errS;
        else
            resultarray{k}.ialm.trun_avg = (resultarray{k}.ialm.trun_avg*(j-1)+tmpresult.ialm.t_run)/j;
            resultarray{k}.ialm.numIter_avg = (resultarray{k}.ialm.numIter_avg*(j-1)+tmpresult.ialm.numIter)/j;
            resultarray{k}.ialm.errL_avg = (resultarray{k}.ialm.errL_avg*(j-1)+tmpresult.ialm.errL)/j;
            resultarray{k}.ialm.errS_avg = (resultarray{k}.ialm.errS_avg*(j-1)+tmpresult.ialm.errS)/j;
            resultarray{k}.BLWSialm.trun_avg = (resultarray{k}.BLWSialm.trun_avg*(j-1)+tmpresult.BLWSialm.t_run)/j;
            resultarray{k}.BLWSialm.numIter_avg = (resultarray{k}.BLWSialm.numIter_avg*(j-1)+tmpresult.BLWSialm.numIter)/j;
            resultarray{k}.BLWSialm.errL_avg = (resultarray{k}.BLWSialm.errL_avg*(j-1)+tmpresult.BLWSialm.errL)/j;
            resultarray{k}.BLWSialm.errS_avg = (resultarray{k}.BLWSialm.errS_avg*(j-1)+tmpresult.BLWSialm.errS)/j;
        end
        
    end
end
    

%% get info for plotting
trun_avgs = zeros(2,length(dims));
numIter_avgs = zeros(2,length(dims));
errL_avgs = zeros(2,length(dims));
errS_avgs = zeros(2,length(dims));
for k=1:length(dims)
    trun_avgs(1,k) = resultarray{k}.ialm.trun_avg;
    numIter_avgs(1,k) = resultarray{k}.ialm.numIter_avg;
    errL_avgs(1,k) = resultarray{k}.ialm.errL_avg;
    errS_avgs(1,k) = resultarray{k}.ialm.errS_avg;
    trun_avgs(2,k) = resultarray{k}.BLWSialm.trun_avg;
    numIter_avgs(2,k) = resultarray{k}.BLWSialm.numIter_avg;
    errL_avgs(2,k) = resultarray{k}.BLWSialm.errL_avg;
    errS_avgs(2,k) = resultarray{k}.BLWSialm.errS_avg;    
end

%% plot
f = figure('Position',[100 900 800 600]);
subplot(2,2,1);
plot(dims,trun_avgs');
title('Average running time');
xlabel('Matrix dimension (square matrices)');
ylabel('average computation time [s]');
legend('standard iALM','warm-start BL iALM','Location','NorthWest');
subplot(2,2,2);
plot(dims,numIter_avgs');
title('Average number of iterations');
xlabel('Matrix dimension (square matrices)');
ylabel('average number of iterations');
legend('standard iALM','warm-start BL iALM','Location','NorthWest');
ylim([0.75*min(min(numIter_avgs)), 1.25*max(max(numIter_avgs))]);
subplot(2,2,3);
plot(dims,errL_avgs');
title('Average relative error in L');
xlabel('Matrix dimension (square matrices)');
ylabel('average relative error');
legend('standard iALM','warm-start BL iALM','Location','NorthWest');
subplot(2,2,4);
plot(dims,errS_avgs');
title('Average relative error in S');
xlabel('Matrix dimension (square matrices)');
ylabel('average relative error');
legend('standard iALM','warm-start BL iALM','Location','NorthWest');
