Name: Maximilian Balandat(21867240) Walid Krichene(23265217) Chi Pang Lam(21421819) Ka Kit Lam(23264500)

Topic: Robust Principal Component Analysis

Folder name: code
Description: codes for generating the simulations, results and figures in our project.
|
|---Folder name: RPCA_algorithms
|   Description : Contains implementations of different RPCA algorithms
|   Use : numerical experiments throughout the report
|   Comment: This is a collection of the PROPACK package and the code freely available from  http://perception.csl.uiuc.edu/matrix-rank/ sample_code.html
|
|---Folder name: simulation data
|   Description : Contains some simulation data as .mat files
|   Use : raw data for the figures in the algorithms chapter
|
|---File name : bench_intpt.m
|   Description : Benchmark interior point algorithms for RPCA
|   Use : Fig 2.1. in Sec. 2.2.1 
|   
|---File name : bench_synthetic.m
|   Description : Test different RPCA algrithms on synthetic data
|   Use : Figs 2.4, 2.5, 2.6 and 2.7 in Sec. 2.3.2 
|   
|---File name : BIG_data.m
|   Description : Test RPCA for some really big matrices (60000x1000)
|   Use : *not used explicitly in the report*
|   
|---File name : coherence.m
|   Description : Computes the coherence parameter mu of a matrix
|   Use : *not used explicitly in the report*
|   
|---File name : compare_svd.m
|   Description : Speed comparison of different SVD methods on synthetic data
|   Use : Figs 2.2 and 2.4 in Sec. 2.3.1
|   
|---File name : get_solvers.m
|   Description : Extracts info from the options structure
|   Use : Auxiliary function used in the bench_synthetic script
|   
|---File name : keep_statistics.m
|   Description : Keeps track of some simulation statistics
|   Use : Auxiliary function used in the bench_synthetic script
|   
|---File name : rpca_wrapper.m
|   Description :  wrapper function that bundles the computation of an RPCA problems through different algorithms. 
|   Use :  Auxiliary function used in different benchmark scripts
|
|---Folder name: applications
|   Description : Contains matlab codes for applications
|   |   
|   |---File name : image_test.m
|   |   Description : Separating the background and foreground with Robust PCA with Lobby data
|   |   Use : Fig 3.1-3.3. in Sec. 3.2.1
|   |   
|   |---File name : video_test.m
|   |   Description : Background foreground separation with our own video
|   |   Use : Fig 3.4-3.5 in Sec. 3.2.1
|   |   
|   |---File name : speech_test.m
|   |   Description : Speech signal de-noising with Robust PCA
|   |   Use : Fig 3.6 in Sec. 3.2.2
|   |   
|   |---File name : vote_test.m
|   |   Description : Running voting data with Robust PCA
|   |   Use : Fig 3.7-3.9 in Sec. 3.2.3
|   |   
|   |---File name : image_rpca.m
|   |   Description : function used in image_test.m and video_test.m
|   |   
|   |---File name : nomalize_scale.m
|   |   Description : function used in image_test.m and video_test.m
|   |   
|   |---folder name : Lobby
|   |   Description : raw data of lobby images
|   |   
|   |---folder name : Senators4
|   |   Description : Senators raw vote data
|   |   
|   |---File name : Movie2012-04-19at16.49.mov
|   |   Description : movie we used for running video_test.m
|   |   
|   |---Files name : FAK_18A_*.ascii
|   |   Description : speech feature data for running speech_test.m
|
|
|---Folder name: algo kk
|   Description : Contains matlab codes for applications
|   |
|   |---File name: comparediff.m
|   |   Description: Compare the Robust PCA and $L_1$ Heuristic in recovering rank 1 matrix from sparse noise
|   |   Use: Produce Figure 1.2 in Sec.  1.5.6
|   |   
|   |---File name: robustpcarankone.m
|   |   Description: Recover rank 1 matrix using power iteration approach by Robust PCA 
|   |   Use: As a subroutine to produce Figure 1.2 in Sec.  1.5.6
|   |   
|   |---File name: robustpcarankonev2.m
|   |   Description: Recover rank 1 matrix using power iteration approach by $L_1$ heuristic 
|   |   Use: As a subroutine to produce Figure 1.2 in Sec.  1.5.6
|   |   
|   |---File name: wmh.m
|   |   Description: Compute the weighted median
|   |   Use: As a subroutine to produce Figure 1.2 in Sec.  1.5.6
|   |   
|   |---File name: higherdimension.m
|   |   Description: Study the performance of $L_1$ heuristic 
|   |   Use: Produce Figure 1.3 in Sec.  1.5.6
|   |   
|   |---File name: robustpcarankonev3.m
|   |   Description: Recover rank - r matrix using power iteration method by $L_1$ heuristic
|   |   Use: As a subroutine to produce Figure 1.3 and 1.4 in Sec. 1.5.6 
|   |   
|   |---File name: compareinhigherdimension.m
|   |   Description:  Compare the Robust PCA and $L_1$ Heuristic in recovering rank 2 matrix from sparse noise
|   |   Use: roduce Figure 1.4 in Sec.  1.5.6
|
|
|---Folder name: l1
|   Description : Quick overview of the problem. For details see section 1.5.3 (l1 heurstic) in the report.
|   |             The l1 heuristic is to solve the problem
|   |
|   |             minimize \| M - L\|_1
|   |             subject to rank(L) \leq r
|   |
|   |             where M = L_0 + S_0 is a superposition of a low rank matrix L_0 (known to have rank rank(L_0) \leq r) and S_0 is a sparse noise matrix
|   |
|   |---File name: test_l1_pca.m
|   |   Description: Main file for testing
|   |                Running test_l1_pca.m will compare:
|   |                - sequencial l_1 PCA, referred to as Analysis view of PCA (finds one direction at a time, then projects on the complement and solves for the next component). Two flavors are tested:
|   |                - constrained: at each iteration, solve a constrained problem (norm(p, inf) = 1)
|   |                - projected: at each iteration, solve an unconstrained problem then project the solutions (p,q)
|   |                - Batch l_1 PCA, referred to as Synthesis view of PCA (solves for all components simultaneously, using a block coordinate descent algorithm)
|   |                - RPCA with lambda = 1/sqrt(N) (no information on rank is used in this case)
|   |                
|   |                executing the file will run 
|   |                - a comparison using 100 x 10 matrices, with increasing rank (and fixed size of the support, K = 20)
|   |                - a comparison using 100 x 10 matrices, with increasing size of the support of the noise matrix (and fixed rank, rk = 1)
|   |                The fixed parameters can be changed
|   |                
|   |                each comparison solves the problem using the different methods, and plots:
|   |                - the recovery error: sum(sum(abs(L - L_hat, 1)))
|   |                - the rank of the recovered low rank component: rank(L_hat)
|   |                - the support size of the recovered sparse component: supp(M - L_hat)
|   |                
|   |                each plot point represents an average of T simulations, where T is specified in the test_l1_pca.m file.
|   |
|   |---File name: l1_pca.m
|   |   Description: Computes a rank one approximation of Z, using block-coordinate descent
|   |                [p, q] = l1_pca(Z, projection_method, [q0])
|   |                Input:
|   |                q0: optional argument: initial guess for q
|   |                projection_method:
|   |                  0: at each iteration, solves the constrained problem, with ||p|| = 1
|   |                  1: at each iteration, solves an unconstrained problem then normalizes p and q (infinity norm)
|   |                Output:
|   |                If Z is N x M
|   |                L = p*q' is N x M
|   |                p is N x 1 and normalized (infinity norm)
|   |                q is M x 1
|   |                
|   |---File name: l1_pca_higher_rank.m
|   |   Description: Computes a rank rk approximation of Z, using the sequential approach (analysis view of PCA). The approximate solution is computed sequentially as a sum of rank-1 approximations
|   |                [L, P, Q] = l1_pca_higher_rank(Z, projection_method, rk, [q0])
|   |                input:
|   |                -optional argument q0 specifies the initial guess for the singular vector q
|   |                -projection_method:
|   |                  0: at each iteration, solves the constrained problem, with ||p|| = 1
|   |                  1: at each iteration, solves an unconstrained problem then normalizes p and q (infinity norm)
|   |                output:
|   |                -L is the approximation, L = P*Q'
|   |
|   |---File name: l1_pca_higher_rank_block.m
|   |   Description: Computes a rank rk approximation of Z, using the batch approach (synthesis view of PCA). This will solve for vectors p and q simultaneously, using block coordinate descent. Slower convergence for higher rank.
|   |                [L, P, Q] = higher_rank_l1_pca_block(Z, rk, [q0])
|   |                -optional argument q0 specifies the initial guess for the singular vector q
|   |                -projection_method:
|   |                  0: at each iteration, solves the constrained problem, with ||p|| = 1
|   |                  1: at each iteration, solves an unconstrained problem then normalizes p and q (infinity norm)
|   |                -output:
|   |                  L_hat is the approximation, L_hat = P*Q'



Folder name: common
Description: Common class and bibliographies used in our project report

Folder name: report
Description: Project report written in LaTex
|
|---Folder name: algorithms
|   Description : LaTex file for algorithms section
|
|---Folder name: applications
|   Description : LaTex file for applications section
|
|---Folder name: figures
|   Description : all figures used in our project report
|
|---Folder name: proposal
|   Description : LaTex file for our project proposal
|
|---Folder name: report
|   Description : Contains the highest level of all of our LaTex files (report.tex).
|




