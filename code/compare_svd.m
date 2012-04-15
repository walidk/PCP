%COMPARE_SVD: Speed comparison of different SVD methods on synthetic data
%
%   Uses the lansvd method from the PROPACK package

% Copyright:   227A project group
% Last edited:   Apr 14, 2012


%% Generate random data

% set matrix sizes
mdims = [50, 75, 100, 150, 200, 300, 500, 750, 1000, 1500, 2000, 3000];
%ndims = [50, 100, 200, 500, 1000, 1500];
ndims = mdims;

% how many runs per size?
nrun = 20;

% initialize time result vector
N = length(mdims);
max_times_svd = zeros(2,N);
avg_times_svd = zeros(2,N);
min_times_svd = Inf*ones(2,N);

%% GO

for k=1:N
    
    % do nrun test runs...
    for i=1:nrun
        
        % generate random matrix (uniform distribution) for different
        % ranges (multiplier i)
        A = 5*i*(rand(mdims(k),ndims(k))-0.5*ones(mdims(k),ndims(k)));
        
        % run Matlab 'econ' svd implementation
        tic;
        [U,S,V] = svd(A,'econ');
        tsvd = toc;
        % run PROPACK's lansvd implementation
        tic;
        [U,S,V] = lansvd(A);
        tlansvd = toc;
        
        % update times
        max_times_svd(1,k) = max(max_times_svd(1,k),tsvd);
        max_times_svd(2,k) = max(max_times_svd(2,k),tlansvd);
        min_times_svd(1,k) = min(max_times_svd(1,k),tsvd);
        min_times_svd(2,k) = min(max_times_svd(2,k),tlansvd);
        if i==1
            avg_times_svd(1,k) = tsvd;
            avg_times_svd(2,k) = tlansvd;
        else
            avg_times_svd(1,k) = (avg_times_svd(1,k)*(i-1) + tsvd) / i;
            avg_times_svd(2,k) = (avg_times_svd(2,k)*(i-1) + tlansvd) / i;
        end
        
    end
    
    
    
end

%% plot
figure;
semilogy(mdims,avg_times_svd);
title('Average running time of Matlab''s SVD routine vs. PROPACK');
xlabel('Matrix dimension (square matrices)');
ylabel('average computation time [s]');
legend('Matlab svd','PROPACK','Location','NorthWest');



%% Compare the thresholded SVD algorithm with the full one

% set matrix sizes
mdims = [50, 75, 100, 150, 200, 300, 500, 750, 1000, 1500, 2000, 3000];
%ndims = [50, 100, 200, 500, 1000, 1500];
ndims = mdims;

% how many runs per size?
nrun = 20;

% how many different threshold values?
nthresh = 5;

% initialize time result vector
N = length(mdims);
max_times_svdthr = zeros(nthresh,N);
avg_times_svdthr = zeros(nthresh,N);
min_times_svdthr = Inf*ones(nthresh,N);
max_times_full = zeros(1,N);
avg_times_full = zeros(1,N);
min_times_full = Inf*ones(1,N);

for k=1:N
    
    % do nrun test runs...
    for i=1:nrun
        
        % generate random matrix (uniform distribution) for different
        % ranges (multiplier i)
        A = 5*i*(rand(mdims(k),ndims(k))-0.5*ones(mdims(k),ndims(k)));
        
        % run PROPACK's lansvd implementation
        tic;
        [U,S,V] = lansvd(A);
        tlansvd = toc;
        
        % keep track of time
        if i==1
            avg_times_full(k) = tlansvd;
        else
            avg_times_full(k) = (avg_times_full(k)*(i-1) + tlansvd) / i;
        end
        max_times_full(k) = max(max_times_full(k),tlansvd);
        min_times_full(k) = min(max_times_full(k),tlansvd);
        
        
        % run the thresholded SVD for different threshold levels
        for j=1:nthresh
            
            % equal spacing for now
            thresh = j/(nthresh+1)*S(1,1);
            
            % compute the thresholded SVD using the modified PROPACK
            tic;
            [Ut,St,Vt] = lansvdthr(A,thresh);
            tlansvdthr = toc;
                        
            % update times
            max_times_svdthr(j,k) = max(max_times_svdthr(j,k),tlansvdthr);
            min_times_svdthr(j,k) = min(max_times_svdthr(j,k),tlansvdthr);
            if i==1
                avg_times_svdthr(j,k) = tlansvdthr;
            else
                avg_times_svdthr(j,k) = (avg_times_svdthr(j,k)*(i-1) + tlansvdthr) / i;
            end
        end
        
    end
    
end

%% plot
figure;
semilogy(mdims,avg_times_svdthr);
hold on
semilogy(mdims,avg_times_full,'k--');
title('Average running time partial SVD vs full SVD (PROPACK)');
xlabel('Matrix dimension (square matrices)');
ylabel('average computation time [s]');
threshlegend = cell(nthresh+1,1);
for j=1:nthresh
    threshlegend{j} = ['\sigma \geq ' num2str(j/(nthresh+1),'%1.1f') '*\sigma_{max}'];
end
threshlegend{end} = 'full SVD';
legend(threshlegend,'Location','NorthWest');
