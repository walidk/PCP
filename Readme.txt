Name: Maximilian Balandat()	Walid Krichene() Chi Pang Lam()	Ka Kit Lam()

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




