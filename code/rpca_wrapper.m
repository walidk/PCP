%RPCA_WRAPPER: 
%
%   This is a wrapper function that bundles the computation of an RPCA 
%   problems through different algorithms. 

% Copyright:   227A project group
% Last edited:   Apr 09, 2012


function results = rpca_wrapper(L,S,lambda)

    % extract information about problem
    [m,n] = size(L);
    M = L + S;
    
    %% interior point on the dual (using cvx)
    disp('Starting Interior Point Algorithm on the Dual');
    tic;
    flag = cvx_quiet(true);
    cvx_begin        
        variable Y(m,n);
        maximize(trace(Y'*M));
        subject to
            norm(Y,2) <= 1;
            norm(Y(:),Inf) <= 1;
    cvx_end
    cvx_quiet(flag);
    % recover primal solution (TO DO!)
    %results.intpt.Lhat = ;
    %results.intpt.Shat = ;
    % compute relative errors
    %results.intpt.errL = ;
    %results.intpt.errS = ;
    
    results.intpt.t_run = toc;


    %% iterative thresholding
    disp('Starting Iterative Thresholding Algorithm');
    tic;
    [results.itth.Lhat results.itth.Shat] = singular_value_rpca(M,lambda);
    % compute relative errors
    results.itth.errL = norm(L-results.itth.Lhat,'fro')/norm(L,'fro');
    results.itth.errS = norm(S-results.itth.Shat,'fro')/norm(S,'fro');
    
    results.itth.t_run = toc;

    
    %% accelerated proximal gradient
    disp('Starting APG Algorithm');
    tic;
    [results.apg.Lhat results.apg.Shat] = proximal_gradient_rpca(M,lambda);
    % compute relative errors
    results.apg.errL = norm(L-results.apg.Lhat,'fro')/norm(L,'fro');
    results.apg.errS = norm(S-results.apg.Shat,'fro')/norm(S,'fro');
    
    results.apg.t_run = toc;
    
    %% accelerated proximal gradient (partial SVD)
    disp('Starting APG Algorithm using partial SVD');
    tic;
    [results.papg.Lhat results.papg.Shat] = partial_proximal_gradient_rpca(M,lambda);
    % compute relative errors
    results.papg.errL = norm(L-results.papg.Lhat,'fro')/norm(L,'fro');
    results.papg.errS = norm(S-results.papg.Shat,'fro')/norm(S,'fro');
    
    results.papg.t_run = toc;
    
    %% dual projected gradient ascent
    disp('Starting Dual Projected Gradient Ascent Algorithm');
    tic;
    [results.dpga.Lhat results.dpga.Shat] = dual_rpca(M,lambda);
    % compute relative errors
    results.dpga.errL = norm(L-results.dpga.Lhat,'fro')/norm(L,'fro');
    results.dpga.errS = norm(S-results.dpga.Shat,'fro')/norm(S,'fro');
    
    results.dpga.t_run = toc;
    
    %% augmented Lagrangian method (exact)
    disp('Starting Exact ALM Algorithm');
    tic;
    [results.ealm.Lhat results.ealm.Shat] = exact_alm_rpca(M,lambda);
    % compute relative errors
    results.ealm.errL = norm(L-results.ealm.Lhat,'fro')/norm(L,'fro');
    results.ealm.errS = norm(S-results.ealm.Shat,'fro')/norm(S,'fro');
    
    results.ealm.t_run = toc;
    
    %% augmented Lagrangian method (inexact)
    disp('Starting Inexact ALM Algorithm');
    tic;
    [results.ialm.Lhat results.ialm.Shat] = inexact_alm_rpca(M,lambda);
    % compute relative errors
    results.ialm.errL = norm(L-results.ialm.Lhat,'fro')/norm(L,'fro');
    results.ialm.errS = norm(S-results.ialm.Shat,'fro')/norm(S,'fro');
    
    results.ialm.t_run = toc;


end




