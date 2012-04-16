%RPCA_WRAPPER: 
%
%   This is a wrapper function that bundles the computation of an RPCA 
%   problems through different algorithms. 

% Copyright:   227A project group
% Last edited:   Apr 16, 2012


function results = rpca_wrapper(L,S,lambda,options)

    % don't use algorithms that are not specified
    if ~isfield(options.intpt,'active'), options.intpt.active = 0; end
    if ~isfield(options.itth,'active'), options.itth.active = 0; end
    if ~isfield(options.apg,'active'), options.apg.active = 0; end
    if ~isfield(options.papg,'active'), options.papg.active = 0; end
    if ~isfield(options.dpga,'active'), options.dpga.active = 0; end
    if ~isfield(options.ealm,'active'), options.ealm.active = 0; end
    if ~isfield(options.ialm,'active'), options.ialm.active = 0; end
    if ~isfield(options.BLWSialm,'active'), options.BLWSialm.active = 0; end

    % extract information about problem
    [m,n] = size(L);
    M = L + S;
    
   
    %% interior point on the dual (using cvx)
    if options.intpt.active               
        disp('Starting Interior Point Algorithm on the Dual');
        tic;
        flag = cvx_quiet(false);
        cvx_precision(options.intpt.tol);
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

        results.intpt.numIter = cvx_slvitr;
        results.intpt.t_run = toc;
    end
    

    %% iterative thresholding
    if options.itth.active 
        disp('Starting Iterative Thresholding Algorithm');
        tic;
        [results.itth.Lhat, results.itth.Shat, ~, results.itth.numIter] = ...
            singular_value_rpca(M,lambda,options.itth.tol);
        % compute relative errors
        results.itth.errL = norm(L-results.itth.Lhat,'fro')/norm(L,'fro');
        results.itth.errS = norm(S-results.itth.Shat,'fro')/norm(S,'fro');
        results.itth.t_run = toc;
    end

    
    %% accelerated proximal gradient
    if options.apg.active 
        disp('Starting APG Algorithm');
        tic;
        [results.apg.Lhat, results.apg.Shat, results.apg.numIter] = ...
            proximal_gradient_rpca(M,lambda,-1,options.apg.tol);
        % compute relative errors
        results.apg.errL = norm(L-results.apg.Lhat,'fro')/norm(L,'fro');
        results.apg.errS = norm(S-results.apg.Shat,'fro')/norm(S,'fro');
        results.apg.t_run = toc;
    end
    
    
    %% accelerated proximal gradient (partial SVD)
    if options.papg.active 
        disp('Starting APG Algorithm using partial SVD');
        tic;
        [results.papg.Lhat, results.papg.Shat, results.papg.numIter] = ...
            partial_proximal_gradient_rpca(M,lambda,-1,options.papg.tol);
        % compute relative errors
        results.papg.errL = norm(L-results.papg.Lhat,'fro')/norm(L,'fro');
        results.papg.errS = norm(S-results.papg.Shat,'fro')/norm(S,'fro');
        results.papg.t_run = toc;
    end
    
    
    %% dual projected gradient ascent
    if options.dpga.active 
        disp('Starting Dual Projected Gradient Ascent Algorithm');
        tic;
        [results.dpga.Lhat, results.dpga.Shat, ~, results.dpga.numIter] = ...
            dual_rpca(M,lambda,options.dpga.tol,options.dpga.maxIter);
        % compute relative errors
        results.dpga.errL = norm(L-results.dpga.Lhat,'fro')/norm(L,'fro');
        results.dpga.errS = norm(S-results.dpga.Shat,'fro')/norm(S,'fro');
        results.dpga.t_run = toc;
    end
    
    
    %% augmented Lagrangian method (exact)
    if options.ealm.active 
        disp('Starting Exact ALM Algorithm');
        tic;
        [results.ealm.Lhat, results.ealm.Shat, results.ealm.numIter] = ...
            exact_alm_rpca(M,lambda);
        % compute relative errors
        results.ealm.errL = norm(L-results.ealm.Lhat,'fro')/norm(L,'fro');
        results.ealm.errS = norm(S-results.ealm.Shat,'fro')/norm(S,'fro'); 
        results.ealm.t_run = toc;
    end
    
    
    %% augmented Lagrangian method (inexact)
    if options.ialm.active          
        disp('Starting Inexact ALM Algorithm');
        tic;
        [results.ialm.Lhat, results.ialm.Shat, results.ialm.numIter] = ...
            inexact_alm_rpca(M,lambda);
        % compute relative errors
        results.ialm.errL = norm(L-results.ialm.Lhat,'fro')/norm(L,'fro');
        results.ialm.errS = norm(S-results.ialm.Shat,'fro')/norm(S,'fro');
        results.ialm.t_run = toc;
    end
    
    
    %% augmented Lagrangian method (inexact) via BLWS SVD
    if options.BLWSialm.active          
        disp('Starting Inexact ALM Algorithm using on BLWS SVD');
        tic;
        [results.BLWSialm.Lhat, results.BLWSialm.Shat, results.BLWSialm.numIter] = ...
            BLWS_ialm_rpca(M,lambda,options.BLWSialm.tol,options.BLWSialm.maxIter,1);
        % compute relative errors
        results.BLWSialm.errL = norm(L-results.BLWSialm.Lhat,'fro')/norm(L,'fro');
        results.BLWSialm.errS = norm(S-results.BLWSialm.Shat,'fro')/norm(S,'fro');
        results.BLWSialm.t_run = toc;
    end


end




