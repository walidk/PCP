Main file for testing: test_l1_pca.m

Quick overview of the problem. For details see section 1.5.3 (l1 heurstic) in the report.
The l1 heuristic is to solve the problem

minimize \| M - L\|_1
subject to rank(L) \leq r

where M = L_0 + S_0 is a superposition of a low rank matrix L_0 (known to have rank rank(L_0) \leq r) and S_0 is a sparse noise matrix


Running test_l1_pca.m will compare:
- sequencial l_1 PCA, referred to as Analysis view of PCA (finds one direction at a time, then projects on the complement and solves for the next component). Two flavors are tested:
  - constrained: at each iteration, solve a constrained problem (norm(p, inf) = 1)
  - projected: at each iteration, solve an unconstrained problem then project the solutions (p,q)
- Batch l_1 PCA, referred to as Synthesis view of PCA (solves for all components simultaneously, using a block coordinate descent algorithm)
- RPCA with lambda = 1/sqrt(N) (no information on rank is used in this case)

executing the file will run 
- a comparison using 100 x 10 matrices, with increasing rank
- a comparison using 100 x 10 matrices, with increasing size of the support of the noise matrix

each comparison solves the problem using the different methods, and plots:
- the recovery error: sum(sum(abs(L - L_hat, 1)))
- the rank of the recovered low rank component: rank(L_hat)
- the support size of the recovered sparse component: supp(M - L_hat)

each plot point represents an average of T simulations, where T is specified in the test_l1_pca.m file.





Main functions:

(1) l1_pca
[p, q] = l1_pca(Z, projection_method, [q0])
Computes a rank one approximation of Z, using block-coordinate descent
Input:
q0: optional argument: initial guess for q
projection_method:
  0: at each iteration, solves the constrained problem, with ||p|| = 1
  1: at each iteration, solves an unconstrained problem then normalizes p and q (infinity norm)
Output:
If Z is N x M
L = p*q' is N x M
p is N x 1 and normalized (infinity norm)
q is M x 1



(2) l1_pca_higher_rank
[L, P, Q] = l1_pca_higher_rank(Z, projection_method, rk, [q0])
Computes a rank rk approximation of Z, using the sequential approach (analysis view of PCA). The approximate solution is computed sequentially as a sum of rank-1 approximations
input:
-optional argument q0 specifies the initial guess for the singular vector q
-projection_method:
  0: at each iteration, solves the constrained problem, with ||p|| = 1
  1: at each iteration, solves an unconstrained problem then normalizes p and q (infinity norm)
output:
-L is the approximation, L = P*Q'



(3) l1_pca_higher_rank_block
[L, P, Q] = higher_rank_l1_pca_block(Z, rk, [q0])
Computes a rank rk approximation of Z, using the batch approach (synthesis view of PCA). This will solve for vectors p and q simultaneously, using block coordinate descent. Slower convergence for higher rank.
-optional argument q0 specifies the initial guess for the singular vector q
-projection_method:
  0: at each iteration, solves the constrained problem, with ||p|| = 1
  1: at each iteration, solves an unconstrained problem then normalizes p and q (infinity norm)
-output:
  L_hat is the approximation, L_hat = P*Q'