%BENCH_INTPT: Benchmark interior point algorithms
%
%   Uses both sedumi and sdpt3 in cvx, size is very limited ...
%   Mainly to show that intpt methods are useless for Robust PCA
%
%   Note tha coding the primal problem in cvx yields a significant speedup,
%   so it seems cvx is smarter about reformulating the problem than we
%   were... Nevertheless, the conclusion remains the same.

% Copyright:   227A project group
% Last edited:   Apr 20, 2012


%% select which algorithms to run, set other options

options.intpt.active = 1;
options.intpt.tol = 'low'; % default: 'standard'


%% Compare sedumi and sdpt3 (through cvx)
nrun = 10;
dims = [10, 20, 30, 40, 50];
trunavg_sedumi = zeros(1,length(dims));
trunavg_sdpt3 = zeros(1,length(dims));

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

        % compute RPCA using sedumi and sdpt3
        lambda = 1/sqrt(dims(k)); % default value
        options.intpt.solver = 'sedumi';
        result_sedumi = rpca_wrapper(L,S,lambda,options);
        options.intpt.solver = 'sdpt3'; 
        result_sdpt3 = rpca_wrapper(L,S,lambda,options);
        
        if j==1
            trunavg_sedumi(k) = result_sedumi.intpt.t_run;
            trunavg_sdpt3(k) = result_sdpt3.intpt.t_run;
        else
            trunavg_sedumi(k) = (trunavg_sedumi(k)*(j-1)+result_sedumi.intpt.t_run)/j;
            trunavg_sdpt3(k) = (trunavg_sdpt3(k)*(j-1)+result_sdpt3.intpt.t_run)/j;
        end
        
    end
end
    

%% plot
f = figure;
plot(dims,[trunavg_sedumi; trunavg_sdpt3]');
title('Average running time');
xlabel('Matrix dimension (square matrices)');
ylabel('average computation time [s]');
legend('sedumi via cvx','sdpt3 via cvx','Location','NorthWest');